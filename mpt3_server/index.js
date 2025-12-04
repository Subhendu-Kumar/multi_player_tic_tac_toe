import cors from "cors";
import dotenv from "dotenv";
import express from "express";
import mongoose from "mongoose";
import { Server } from "socket.io";
import { createServer } from "http";

// LOAD .ENV
dotenv.config();

// EXPRESS APP INIT
const app = express();

// MIDDLEWARES
app.use(cors());
app.use(express.json());

// HTTP SERVER INIT
const httpServer = createServer(app);

// SOCKET.IO INIT
const io = new Server(httpServer, {
  cors: { origin: "*" },
});

// TEST ROUTE
app.get("/", (req, res) => {
  res.send("Socket.IO + Express + CORS + MongoDB");
});

// DB SCHEMA & MODEL

const playerSchema = new mongoose.Schema({
  socketID: { type: String },
  points: { type: Number, default: 0 },
  nickname: { type: String, trim: true },
  playerType: { type: String, required: true },
});

const roomSchema = new mongoose.Schema({
  turn: playerSchema,
  players: [playerSchema],
  turnIndex: { type: Number, default: 0 },
  occupancy: { type: Number, default: 2 },
  maxRounds: { type: Number, default: 6 },
  isJoin: { type: Boolean, default: true },
  currentRound: { type: Number, required: true, default: 1 },
});

const Room = mongoose.model("Room", roomSchema);

/*----------------------------------------------------
   🔥 SOCKET.IO EVENTS (converted from old code)
----------------------------------------------------*/

io.on("connection", (socket) => {
  console.log("User connected:", socket.id);

  // CREATE ROOM
  socket.on("createRoom", async ({ nickname }) => {
    try {
      let room = new Room();
      const player = {
        socketID: socket.id,
        nickname,
        playerType: "X",
      };
      room.players.push(player);
      room.turn = player; // first player turn
      room = await room.save();
      const roomId = room._id.toString();
      socket.join(roomId);
      console.log(`Room created with ID: ${roomId}`);
      io.to(roomId).emit("createRoomSuccess", room);
    } catch (err) {
      console.log(err);
      socket.emit("errorOccurred", "Unable to create room.");
    }
  });

  // JOIN ROOM
  socket.on("joinRoom", async ({ nickname, roomId }) => {
    try {
      if (!roomId.match(/^[0-9a-fA-F]{24}$/)) {
        socket.emit("errorOccurred", "Please enter a valid Room ID.");
        return;
      }
      let room = await Room.findById(roomId);
      if (room && room.isJoin) {
        const player = {
          nickname,
          socketID: socket.id,
          playerType: "O",
        };
        socket.join(roomId);
        room.players.push(player);
        room.isJoin = false;
        room = await room.save();
        io.to(roomId).emit("joinRoomSuccess", room);
        io.to(roomId).emit("updatePlayers", room.players);
        io.to(roomId).emit("updateRoom", room);
      } else {
        socket.emit("errorOccurred", "Game already in progress.");
      }
    } catch (err) {
      console.log(err);
      socket.emit("errorOccurred", "Unable to join room.");
    }
  });

  // TAP EVENT
  socket.on("tap", async ({ index, roomId }) => {
    try {
      let room = await Room.findById(roomId);
      let choice = room.turn.playerType;
      if (room.turnIndex === 0) {
        room.turn = room.players[1];
        room.turnIndex = 1;
      } else {
        room.turn = room.players[0];
        room.turnIndex = 0;
      }
      room = await room.save();
      io.to(roomId).emit("tapped", {
        index,
        choice,
        room,
      });
    } catch (err) {
      console.log(err);
    }
  });

  // WINNER EVENT
  socket.on("winner", async ({ winnerSocketId, roomId }) => {
    try {
      let room = await Room.findById(roomId);
      let player = room.players.find((p) => p.socketID === winnerSocketId);
      player.points += 1;
      room = await room.save();
      if (player.points >= room.maxRounds) {
        io.to(roomId).emit("endGame", player);
      } else {
        io.to(roomId).emit("pointIncrease", player);
      }
    } catch (err) {
      console.log(err);
    }
  });
});

/*----------------------------------------------------
   🟢 MONGOOSE + SERVER START
----------------------------------------------------*/

mongoose
  .connect(process.env.DATABASE_URL)
  .then(() => {
    httpServer.listen(5000, () => {
      console.log("Database connected");
      console.log("Server running on -  http://localhost:5000");
    });
  })
  .catch((err) => console.log(err));
