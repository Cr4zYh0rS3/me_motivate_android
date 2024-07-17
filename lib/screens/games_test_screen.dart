import 'package:flutter/material.dart';
import 'package:me_motivate_android/widgets/games_box_main.dart';

class GameTestScreen extends StatelessWidget {
  static const routeName = '/game-test-screen';
  const GameTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xff040932),
      body: Container(
        width: deviceSize.width,
        height: deviceSize.height,
        child: Column(
          children: [
            SizedBox(height: deviceSize.height * 0.04),
            SizedBox(
              width: deviceSize.width * 0.9,
              child: Text(
                'Game Test',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: deviceSize.width * 0.06,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: deviceSize.height * 0.02),
            const GameBoxMain(
              gameName: 'Speed Test',
              gamePath: '/speed-match',
              introMediaPath: 'assets/images/speedtestintro1.png',
              introMediaDesc: 'Game starts with one of the random icons in the game. After the first icon, you have to decide if the previous icon is the same or not the same as the new one.',
              introMediaPath2: 'assets/images/skipper.png',
              introMediaDesc2:
                  'After some time, you have to be more careful about skippers. If skippers appear, you have to decide if the 2 previous ones are the same as the new one. Be fast; you only have 60 seconds!',
              introMediaPath3: 'assets/images/speedmatchintro3.png',
            ),
            SizedBox(height: deviceSize.height * 0.04),
            const GameBoxMain(
              gameName: 'Game 6.1',
              gamePath: '/game6.1',
              introMediaPath: 'assets/images/game6.1intromedia.png',
              introMediaDesc: 'Are you ready to rthym up with [Game Name]! Follow the blinking parts of the drum set',
              introMediaPath2: 'assets/images/game6.1intromedia2.png',
              introMediaDesc2: 'Follow up the order and try to reach your best. Dont forget every level its gonna get hard!',
              introMediaPath3: 'assets/images/game6.1intromedia3.png',
            ),
            SizedBox(height: deviceSize.height * 0.04),
            const GameBoxMain(
              gameName: 'Game 3.1',
              gamePath: '/game3.1',
              introMediaPath: 'assets/images/game3.1intromedia.png',
              introMediaDesc: 'New Artificial Intelligence has come to earth. Your duty is train AI about the world. Get ready there is much to teach',
              introMediaPath2: 'assets/images/game3.1intromedia2.png',
              introMediaDesc2: 'First objects and creatures from earth display in the screen. As a trainer you should teach what is thoose things in the display in machines language. ',
              introMediaPath3: 'assets/images/game3.1intromedia3.png',
            ),
            /*const GameBoxMain(
              gameName: 'Memory Test Images',
              gamePath: '/gameplay-view',
              introMediaPath: 'assets/images/speedtestintro1.png',
              introMediaDesc: 'Game starts with one of the random icons in the game. After the first icon, you have to decide if the previous icon is the same or not the same as the new one.',
              introMediaPath2: 'assets/images/skipper.png',
              introMediaDesc2:
                  'After some time, you have to be more careful about skippers. If skippers appear, you have to decide if the 2 previous ones are the same as the new one. Be fast; you only have 60 seconds!',
              introMediaPath3: 'assets/images/speedmatchintro3.png',
            ),
            const GameBoxMain(
              gameName: 'Game 2',
              gamePath: '/game-memory',
              introMediaPath: 'assets/images/speedtestintro1.png',
              introMediaDesc: 'Game starts with one of the random icons in the game. After the first icon, you have to decide if the previous icon is the same or not the same as the new one.',
              introMediaPath2: 'assets/images/skipper.png',
              introMediaDesc2:
                  'After some time, you have to be more careful about skippers. If skippers appear, you have to decide if the 2 previous ones are the same as the new one. Be fast; you only have 60 seconds!',
              introMediaPath3: 'assets/images/speedmatchintro3.png',
            ),*/
          ],
        ),
      ),
    );
  }
}
