import 'package:flutter/material.dart';

class GameBoxMain extends StatelessWidget {
  final String introMediaPath;
  final String introMediaDesc;
  final String introMediaPath2;
  final String introMediaDesc2;
  final String introMediaPath3;
  final String gameName;
  final String gamePath;

  const GameBoxMain({
    required this.gameName,
    required this.gamePath,
    required this.introMediaPath,
    required this.introMediaDesc,
    required this.introMediaPath2,
    required this.introMediaDesc2,
    required this.introMediaPath3,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/game-intro',
          arguments: {
            'gamePath': this.gamePath,
            'introMediaPath': this.introMediaPath,
            'introMediaDesc': this.introMediaDesc,
            'introMediaPath2': this.introMediaPath2,
            'introMediaDesc2':this.introMediaDesc2,
            'introMediaPath3':this.introMediaPath3,
            },
        );
      },
      child: Container(
          width: deviceSize.width * 0.9,
          height: deviceSize.width * 0.3,
          decoration: BoxDecoration(
            color: Color(0xff1d1e30),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(
              gameName,
              style: TextStyle(
                color: Colors.white,
                fontSize: deviceSize.width * 0.045,
              ),
            ),
          )),
    );
  }
}
