import 'package:flutter/material.dart';
import 'package:mpt3_client/widgets/custom_button.dart';
import 'package:mpt3_client/widgets/custom_text_field.dart';

class CreateRoomScreen extends StatefulWidget {
  const CreateRoomScreen({super.key});

  @override
  State<CreateRoomScreen> createState() => _CreateRoomScreenState();
}

class _CreateRoomScreenState extends State<CreateRoomScreen> {
  final TextEditingController _nameController = TextEditingController();

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
            CustomButton(onTap: () => {}, text: 'create'),
          ],
        ),
      ),
    );
  }
}
