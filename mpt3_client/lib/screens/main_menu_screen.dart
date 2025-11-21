import 'package:flutter/material.dart';
import 'package:mpt3_client/widgets/custom_button.dart';

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.sports_esports, size: 150, color: colorScheme.primary),
            const Text(
              "Multiplayer Tic Tac Toe",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 40),
            CustomButton(
              onTap: () => {Navigator.pushNamed(context, "/create-room")},
              text: 'create room',
            ),
            const SizedBox(height: 20),
            CustomButton(
              onTap: () => {Navigator.pushNamed(context, "/join-room")},
              text: 'join room',
            ),
          ],
        ),
      ),
    );
  }
}
