import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:mpt3_client/views/score_board.dart';
import 'package:mpt3_client/views/waiting_lobby.dart';
import 'package:mpt3_client/views/tictactoe_board.dart';
import 'package:mpt3_client/resources/socket_methods.dart';
import 'package:mpt3_client/provider/room_data_provider.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final SocketMethods _socketMethods = SocketMethods();

  @override
  void initState() {
    super.initState();
    _socketMethods.updateRoomListener(context);
    _socketMethods.updatePlayersStateListener(context);
    _socketMethods.pointIncreaseListener(context);
    _socketMethods.endGameListener(context);
  }

  @override
  Widget build(BuildContext context) {
    RoomDataProvider roomDataProvider = Provider.of<RoomDataProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Tic Tac Toe")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: roomDataProvider.roomData["isJoin"]
            ? const WaitingLobby()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const ScoreBoard(),
                  const TictactoeBoard(),
                  Text(
                    '${roomDataProvider.roomData['turn']['nickname']}\'s turn',
                  ),
                ],
              ),
      ),
    );
  }
}
