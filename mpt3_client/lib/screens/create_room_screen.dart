import 'package:flutter/material.dart';

import 'package:mpt3_client/widgets/custom_button.dart';
import 'package:mpt3_client/resources/socket_methods.dart';
import 'package:mpt3_client/widgets/custom_text_field.dart';

class CreateRoomScreen extends StatefulWidget {
  const CreateRoomScreen({super.key});

  @override
  State<CreateRoomScreen> createState() => _CreateRoomScreenState();
}

class _CreateRoomScreenState extends State<CreateRoomScreen> {
  final SocketMethods _socketMethods = SocketMethods();
  final TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _socketMethods.createRoomSuccessListener(context);
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Create Room")),
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
            CustomButton(
              onTap: () =>
                  _socketMethods.createRoom(_nameController.text.trim()),
              text: 'create',
            ),
          ],
        ),
      ),
    );
  }
}
