import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SimonGamePage extends StatefulWidget {
  static const routeName = '/game6.1';
  @override
  _SimonGamePageState createState() => _SimonGamePageState();
}

class _SimonGamePageState extends State<SimonGamePage> {
  List<int> _sequence = [];
  List<int> _playerInput = [];
  int _currentLevel = 0;
  bool _isPlayerTurn = false;
  bool _isGameOver = false;

  final List<Color> _colors = [
    Colors.red.withOpacity(0.2),
    Colors.green.withOpacity(0.2),
    Colors.blue.withOpacity(0.2),
    Colors.yellow.withOpacity(0.2),
  ];
  final List<Color> _highlightColors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow,
  ];
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _startGame();
  }

  void _startGame() {
    _sequence.clear();
    _playerInput.clear();
    _currentLevel = 0;
    _isPlayerTurn = false;
    _isGameOver = false;
    _nextLevel();
  }

  void _nextLevel() {
    setState(() {
      _playerInput.clear();
      _sequence.add(_random.nextInt(4));
      _currentLevel++;
      _isPlayerTurn = false;
    });
    _playSequence();
  }

  Future<void> _playSequence() async {
    for (int colorIndex in _sequence) {
      await _highlightButton(colorIndex);
      await Future.delayed(Duration(milliseconds: 500));
    }
    setState(() {
      _isPlayerTurn = true;
    });
  }

  Future<void> _highlightButton(int index) async {
    await Future.delayed(Duration(milliseconds: 100));
    final player = AudioPlayer();
    if (index == 0) {
      player.play(AssetSource('audios/crashcymbal.mp3'));
    }
    if (index == 1) {
      player.play(AssetSource('audios/ridecymbal.mp3'));
    }
    if (index == 2) {
      player.play(AssetSource('audios/snare.mp3'));
    }
    if (index == 3) {
      player.play(AssetSource('audios/tom.mp3'));
    }

    setState(() {
      _colors[index] = _highlightColors[index];
    });
    await Future.delayed(Duration(milliseconds: 500));
    setState(() {
      _colors[index] = _highlightColors[index].withOpacity(0.2);
    });
  }

  Future<void> _handleButtonPress(int index) async {
    if (!_isPlayerTurn) return;

    // Click effect
    setState(() {
      _colors[index] = _highlightColors[index];
    });
    await Future.delayed(Duration(milliseconds: 50));
    //
    final player = AudioPlayer();
    if (index == 0) {
      player.play(AssetSource('audios/crashcymbal.mp3'));
    }
    if (index == 1) {
      player.play(AssetSource('audios/ridecymbal.mp3'));
    }
    if (index == 2) {
      player.play(AssetSource('audios/snare.mp3'));
    }
    if (index == 3) {
      player.play(AssetSource('audios/tom.mp3'));
    }
    //
    setState(() {
      _colors[index] = _highlightColors[index].withOpacity(0.2);
    });
    await Future.delayed(Duration(milliseconds: 500));

    setState(() {
      _playerInput.add(index);
    });

    if (_sequence[_playerInput.length - 1] != index) {
      setState(() {
        _isGameOver = true;

        _isPlayerTurn = false;
      });
      await Future.delayed(Duration(seconds: 2));
      Navigator.pushReplacementNamed(context, '/game-introduction', arguments: {'gamePath': '/game6.1', 'gameOutroMedia': 'assets/images/game6.1outromedia.png', 'gameName': 'Game 6.1'});
      return;
    }

    if (_playerInput.length == _sequence.length) {
      _nextLevel();
    }
  }

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: deviceSize.width,
        height: deviceSize.height,
        child: Stack(
          children: [
            // Background Layer
            Container(
              width: deviceSize.width,
              height: deviceSize.height,
              child: Image(
                image: AssetImage('assets/images/drumkit.png'),
                fit: BoxFit.cover,
              ),
            ),
            // Content Layer
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  /*Text(
                    'Level: $_currentLevel',
                    style: TextStyle(fontSize: 24),
                  ),*/
                  _buildButtonGrid(),
                  /*_isGameOver
                      ? Column(
                          children: [
                            Text(
                              'Game Over!',
                              style: TextStyle(fontSize: 24, color: Colors.red),
                            ),
                            SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: _startGame,
                              child: Text('Restart'),
                            ),
                          ],
                        )
                      : Container(),*/
                ],
              ),
            ),
            _isGameOver == true
                ? Container(
                    width: deviceSize.width,
                    height: deviceSize.height,
                    color: Colors.black.withOpacity(0.5),
                    child: Center(
                      child: Text(
                        "Game Over!",
                        style: TextStyle(color: Colors.white, fontSize: deviceSize.width * 0.08),
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  Widget _buildButtonGrid() {
    var deviceSize = MediaQuery.of(context).size;
    return Container(
      width: deviceSize.width,
      height: deviceSize.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(top: deviceSize.height * 0.035, left: deviceSize.width * 0.032),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(500),
                  child: GestureDetector(
                    onTap: () => _handleButtonPress(0),
                    child: Container(
                      width: deviceSize.width * 0.31,
                      height: deviceSize.width * 0.31,
                      decoration: BoxDecoration(
                        color: _colors[0],
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: deviceSize.height * 0.035, right: deviceSize.width * 0.035, bottom: deviceSize.height * 0.005),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(500),
                  child: GestureDetector(
                    onTap: () => _handleButtonPress(1),
                    child: Container(
                      width: deviceSize.width * 0.41,
                      height: deviceSize.width * 0.41,
                      decoration: BoxDecoration(
                        color: _colors[1],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(left: deviceSize.width * 0.17, bottom: deviceSize.height * 0.068),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(500),
                  child: GestureDetector(
                    onTap: () => _handleButtonPress(2),
                    child: Container(
                      width: deviceSize.width * 0.25,
                      height: deviceSize.width * 0.25,
                      decoration: BoxDecoration(
                        color: _colors[2],
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: deviceSize.width * 0.1, bottom: deviceSize.height * 0.17),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(500),
                  child: GestureDetector(
                    onTap: () => _handleButtonPress(3),
                    child: Container(
                      width: deviceSize.width * 0.25,
                      height: deviceSize.width * 0.25,
                      decoration: BoxDecoration(
                        color: _colors[3],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
