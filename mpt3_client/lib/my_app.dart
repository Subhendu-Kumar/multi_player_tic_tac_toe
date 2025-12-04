import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:mpt3_client/screens/game_screen.dart';
import 'package:mpt3_client/screens/join_room_screen.dart';
import 'package:mpt3_client/screens/main_menu_screen.dart';
import 'package:mpt3_client/screens/create_room_screen.dart';
import 'package:mpt3_client/provider/room_data_provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RoomDataProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        debugShowCheckedModeBanner: false,
        routes: {
          "/game-screen": (context) => GameScreen(),
          "/main-menu": (context) => MainMenuScreen(),
          "/join-room": (context) => JoinRoomScreen(),
          "/create-room": (context) => CreateRoomScreen(),
        },
        home: const MainMenuScreen(),
      ),
    );
  }
}
