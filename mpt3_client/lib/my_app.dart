import 'package:flutter/material.dart';
import 'package:mpt3_client/screens/create_room_screen.dart';
import 'package:mpt3_client/screens/join_room_screen.dart';
import 'package:mpt3_client/screens/main_menu_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        "/main-menu": (context) => MainMenuScreen(),
        "/create-room": (context) => CreateRoomScreen(),
        "/join-room": (context) => JoinRoomScreen(),
      },
      home: const MainMenuScreen(),
    );
  }
}
