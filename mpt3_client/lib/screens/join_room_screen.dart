import 'package:flutter/material.dart';

import 'package:mpt3_client/widgets/custom_button.dart';
import 'package:mpt3_client/resources/socket_methods.dart';
import 'package:mpt3_client/widgets/custom_text_field.dart';

class JoinRoomScreen extends StatefulWidget {
  const JoinRoomScreen({super.key});

  @override
  State<JoinRoomScreen> createState() => _JoinRoomScreenState();
}

class _JoinRoomScreenState extends State<JoinRoomScreen> {
  final SocketMethods _socketMethods = SocketMethods();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _gameIdController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _socketMethods.joinRoomSuccessListener(context);
    _socketMethods.errorOccuredListener(context);
    _socketMethods.updatePlayersStateListener(context);
  }

  @override
  void dispose() {
    _gameIdController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Join Room")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextField(
              controller: _nameController,
              hintText: 'Enter your nickname',
              isReadOnly: false,
            ),
            const SizedBox(height: 20),
            CustomTextField(
              controller: _gameIdController,
              hintText: 'Enter Game ID',
              isReadOnly: false,
            ),
            const SizedBox(height: 20),
            CustomButton(
              onTap: () => _socketMethods.joinRoom(
                _nameController.text,
                _gameIdController.text,
              ),
              text: 'join',
            ),
          ],
        ),
      ),
    );
  }
}
