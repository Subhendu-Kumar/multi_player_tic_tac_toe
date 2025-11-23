import 'package:flutter/material.dart';
import 'package:mpt3_client/provider/room_data_provider.dart';
import 'package:mpt3_client/resources/socket_methods.dart';
import 'package:mpt3_client/views/waiting_lobby.dart';
import 'package:provider/provider.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final SocketMethods _socketMethods = SocketMethods();

  @override
  Widget build(BuildContext context) {
    RoomDataProvider roomDataProvider = Provider.of<RoomDataProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Tic Tac Toe")),
      body: roomDataProvider.roomData["isJoin"]
          ? const WaitingLobby()
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text('Game Screen'),
                const SizedBox(height: 20),
                Text('Room ID: ${roomDataProvider.roomData["_id"]}'),
              ],
            ),
    );
  }
}
