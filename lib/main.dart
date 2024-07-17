import 'package:flutter/material.dart';
import 'package:me_motivate_android/Games/Game2/game_memory.dart';
import 'package:me_motivate_android/Games/Game3.1/emoji_game.dart';
import 'package:me_motivate_android/Games/Game6.1/simongame.dart';
import 'package:me_motivate_android/Games/Memory%20Test%20Images/gameplay_view.dart';
import 'package:me_motivate_android/Games/Memory%20Test%20Images/questions.dart';
import 'package:me_motivate_android/Games/Speed%20Match/card_matching_game.dart';
import 'package:me_motivate_android/screens/game_intro.dart';
import 'package:me_motivate_android/screens/game_introduction.dart';
import 'package:me_motivate_android/screens/games_test_screen.dart';
import 'package:me_motivate_android/screens/get_started.dart';
import 'package:me_motivate_android/screens/loader_screen.dart';
import 'package:me_motivate_android/screens/login.dart';
import 'package:me_motivate_android/screens/register.dart';

void main() {
  runApp(const MyApp());
}

//
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        //colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        fontFamily: 'VarelaRound-Regular',
      ),
      home: LoaderScreen(),
      routes: {
        LoaderScreen.routeName: (context) => LoaderScreen(),
        GetStarted.routeName: (context) => GetStarted(),
        Login.routeName: (context) => Login(),
        Register.routeName: (context) => Register(),
        GameTestScreen.routeName: (context) => GameTestScreen(),
        GameIntroduction.routeName: (context) => GameIntroduction(),
        GameIntro.routeName: (context) => GameIntro(),
        //
        CardMatchingGame.gameRoute: (context) => CardMatchingGame(),
        SimonGamePage.routeName: (context) => SimonGamePage(),
        EmojiGame.routeName: (context) => EmojiGame(),
        GameplayView.routeName: (context) => GameplayView(),
        Questions.routeName: (context) => Questions(),
        MemoryGame.routeName: (context) => MemoryGame(),
      },
    );
  }
}


/*
created by:
 ________  ________  ________  ________      ___    ___ ___  ___  ________  ________  ________  _______      
|\   ____\|\   __  \|\   __  \|\_____  \    |\  \  /  /|\  \|\  \|\   __  \|\   __  \|\   ____\|\  ___ \     
\ \  \___|\ \  \|\  \ \  \|\  \\|___/  /|   \ \  \/  / | \  \\\  \ \  \|\  \ \  \|\  \ \  \___|\ \   __/|    
 \ \  \    \ \   _  _\ \   __  \   /  / /    \ \    / / \ \   __  \ \  \\\  \ \   _  _\ \_____  \ \  \_|/__  
  \ \  \____\ \  \\  \\ \  \ \  \ /  /_/__    \/  /  /   \ \  \ \  \ \  \\\  \ \  \\  \\|____|\  \ \  \_|\ \ 
   \ \_______\ \__\\ _\\ \__\ \__\\________\__/  / /      \ \__\ \__\ \_______\ \__\\ _\ ____\_\  \ \_______\
    \|_______|\|__|\|__|\|__|\|__|\|_______|\___/ /        \|__|\|__|\|_______|\|__|\|__|\_________\|_______|
                                           \|___|/                                      \|_________|         
Copyright© by Semih Mert UTKAN                                                                                                            
 */