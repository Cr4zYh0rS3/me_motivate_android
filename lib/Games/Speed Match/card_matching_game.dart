import 'dart:async';
import 'dart:math';

import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CardMatchingGame extends StatefulWidget {
  static const gameRoute = '/speed-match';
  @override
  _CardMatchingGameState createState() => _CardMatchingGameState();
}

class _CardMatchingGameState extends State<CardMatchingGame> with SingleTickerProviderStateMixin {
  final List<String> symbolPaths = [
    'assets/images/axes.png',
    'assets/images/castle.png',
    'assets/images/knight (1).png',
    'assets/images/knight.png',
    'assets/images/old-map.png',
    'assets/images/villager.png'
  ];
  String previousCard1 = '';
  String previousCard2 = '';
  String currentCard = '';
  int score = 0;
  bool gameStarted = false;
  bool askingPreviousCardMatch = false;
  bool showButtons = false;
  bool firstSymbolShown = false;
  Timer? gameTimer;
  Timer? symbolTimer;
  int symbolTimerLeft = 3;
  int timeLeft = 60; // Game duration in seconds
  int correctGuesses = 0; // Track the number of correct guesses

  late AnimationController _controller;
  late Animation<Offset> _slideOutAnimation;
  late Animation<Offset> _slideInAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _slideOutAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: Offset(-1.5, 0.0),
    ).animate(_controller);
    _slideInAnimation = Tween<Offset>(
      begin: Offset(1.5, 0.0),
      end: Offset.zero,
    ).animate(_controller);

    // Start the game immediately when the widget is initialized
    startGame();
  }

  @override
  void dispose() {
    gameTimer?.cancel();
    symbolTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void startGame() {
    setState(() {
      gameStarted = true;
      score = 0;
      timeLeft = 63;
      correctGuesses = 0;
      askingPreviousCardMatch = false;
      previousCard1 = '';
      previousCard2 = '';
      showButtons = false;
      firstSymbolShown = false;
    });
    nextCard();
    gameTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (timeLeft > 0) {
        setState(() {
          timeLeft--;
        });
      } else {
        timer.cancel();
        setState(() {
          gameStarted = false;
          Navigator.pushReplacementNamed(context, '/game-introduction',
              arguments: {'gamePath': '/speed-match', 'score': score, 'gameOutroMedia': 'assets/images/speedmatchintro.png', 'gameName': 'Speed Match'});
        });
      }
    });
  }

  void nextCard() {
    symbolTimer?.cancel();
    setState(() {
      previousCard2 = previousCard1;
      previousCard1 = currentCard;
      currentCard = symbolPaths[Random().nextInt(symbolPaths.length)];
      _controller.reset();
      _controller.forward();
      if (firstSymbolShown) {
        showButtons = true; // Show buttons after the first card
      } else {
        firstSymbolShown = true;
        symbolTimer = Timer.periodic(Duration(seconds: 1), (timer) {
          if (symbolTimerLeft > 0) {
            final player = AudioPlayer();
            player.play(AssetSource('audios/countdown.mp3'));
            setState(() {
              symbolTimerLeft--;
            });
          } else {
            timer.cancel();
            final player = AudioPlayer();
            player.play(AssetSource('audios/start.mp3'));
            nextCard();
          }
        });

        //symbolTimer = Timer(Duration(seconds: 3), nextCard); // Set the timer only for the first card
      }
    });
  }

  void handleAnswer(bool isSame) {
    if (!gameStarted || askingPreviousCardMatch) return;

    if (previousCard1.isNotEmpty && ((isSame && currentCard == previousCard1) || (!isSame && currentCard != previousCard1))) {
      setState(() {
        score++;
        correctGuesses++;
      });
      final player = AudioPlayer();
      player.play(AssetSource('audios/correct.mp3'));
    } else if (previousCard1.isNotEmpty) {
      setState(() {
        score--;
      });
      final player = AudioPlayer();
      player.play(AssetSource('audios/false.mp3'));
    }

    if (correctGuesses % 7 == 0 && correctGuesses >= 25 && previousCard2.isNotEmpty && !askingPreviousCardMatch) {
      setState(() {
        askingPreviousCardMatch = true;
      });
    } else {
      nextCard();
    }
  }

  void checkPreviousCardMatch(bool isSame) {
    if ((isSame && currentCard == previousCard2) || (!isSame && currentCard != previousCard2)) {
      setState(() {
        score += 3;
      });
      final player = AudioPlayer();
      player.play(AssetSource('audios/correct.mp3'));
    } else {
      setState(() {
        score -= 3;
      });
      final player = AudioPlayer();
      player.play(AssetSource('audios/false.mp3'));
    }
    setState(() {
      askingPreviousCardMatch = false;
      nextCard();
    });
  }

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          //First Background Layer
          Container(
            width: deviceSize.width,
            height: deviceSize.height,
            child: Image(
              image: AssetImage('assets/images/medieval_background.png'),
              fit: BoxFit.cover,
            ),
          ),
          //Shadow Layer
          Container(
            width: deviceSize.width,
            height: deviceSize.height,
            color: Colors.black.withOpacity(0.2),
          ),
          //Timer Layer
          !symbolTimer!.isActive
              ? Container(
                  margin: EdgeInsets.only(top: deviceSize.height * 0.15),
                  alignment: Alignment.topCenter,
                  child: CircleAvatar(
                    backgroundColor: Colors.black.withOpacity(0.5),
                    radius: deviceSize.width * 0.05,
                    child: AnimatedFlipCounter(
                      duration: Duration(milliseconds: 300),
                      value: timeLeft,
                      textStyle: TextStyle(color: Colors.white, fontSize: deviceSize.width * 0.06),
                    ),
                  )
                  /*Text(
                symbolTimerLeft.toString(),
                style: TextStyle(color: Colors.white),
              ),*/
                  )
              : Container(),
          //Second Game Layer
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                /*Text(
                  'Time Left: $timeLeft',
                  style: TextStyle(fontSize: 24),
                ),
                SizedBox(height: 20),
                Text(
                  'Score: $score',
                  style: TextStyle(fontSize: 24),
                ),
                SizedBox(height: 20),*/
                Stack(
                  children: [
                    if (previousCard1.isNotEmpty && gameStarted)
                      SlideTransition(
                        position: _slideOutAnimation,
                        child: Container(
                          key: ValueKey(previousCard1),
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.transparent, width: 2),
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.transparent,
                          ),
                          alignment: Alignment.center,
                          child: Container(
                            width: 150,
                            height: 150,
                            child: Image.asset(
                              previousCard1,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    if (gameStarted)
                      SlideTransition(
                        position: _slideInAnimation,
                        child: Container(
                          key: ValueKey(currentCard),
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.transparent, width: 2),
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.transparent,
                          ),
                          alignment: Alignment.center,
                          child: Container(
                            width: 150,
                            height: 150,
                            child: Image.asset(
                              currentCard,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
          //
          if (gameStarted && symbolTimer!.isActive)
            Container(
                margin: EdgeInsets.only(bottom: deviceSize.height * 0.2),
                alignment: Alignment.bottomCenter,
                child: CircleAvatar(
                  backgroundColor: Colors.black.withOpacity(0.5),
                  radius: 50,
                  child: AnimatedFlipCounter(
                    duration: Duration(milliseconds: 300),
                    value: symbolTimerLeft,
                    textStyle: TextStyle(color: Colors.white, fontSize: 50),
                  ),
                )
                /*Text(
                symbolTimerLeft.toString(),
                style: TextStyle(color: Colors.white),
              ),*/
                ),
          //
          if (gameStarted && showButtons && !askingPreviousCardMatch)
            Container(
              width: deviceSize.width,
              height: deviceSize.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    '',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  SizedBox(height: deviceSize.height * 0.25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          handleAnswer(true);
                        },
                        child: Container(
                          width: deviceSize.width * 0.49,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text(
                              'Yes',
                              style: TextStyle(color: Colors.white, fontSize: 36),
                            ),
                          ),
                        ),
                      ),

                      /*ElevatedButton(
                        onPressed: () => handleAnswer(true),
                        child: Text('Same'),
                      ),*/
                      SizedBox(width: deviceSize.width * 0.02),
                      GestureDetector(
                        onTap: () {
                          handleAnswer(false);
                        },
                        child: Container(
                          width: deviceSize.width * 0.49,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text(
                              'No',
                              style: TextStyle(color: Colors.white, fontSize: 36),
                            ),
                          ),
                        ),
                      ),
                      /*ElevatedButton(
                        onPressed: () => handleAnswer(false),
                        child: Text('Not Same'),
                      ),*/
                    ],
                  ),
                ],
              ),
            ),
          if (gameStarted && askingPreviousCardMatch)
            Container(
              width: deviceSize.width,
              height: deviceSize.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: deviceSize.width * 0.1,
                    child: Image(
                      image: AssetImage('assets/images/skipper.png'),
                    ),
                  ),
                  /*Text(
                    'X2',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),*/
                  SizedBox(height: deviceSize.height * 0.25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          checkPreviousCardMatch(true);
                        },
                        child: Container(
                          width: deviceSize.width * 0.49,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text(
                              'Yes',
                              style: TextStyle(color: Colors.white, fontSize: 36),
                            ),
                          ),
                        ),
                      ),
                      /* ElevatedButton(
                        onPressed: () => checkPreviousCardMatch(true),
                        child: Text('Same'),
                      ),*/
                      SizedBox(width: deviceSize.width * 0.02),
                      GestureDetector(
                        onTap: () {
                          checkPreviousCardMatch(false);
                        },
                        child: Container(
                          width: deviceSize.width * 0.49,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text(
                              'No',
                              style: TextStyle(color: Colors.white, fontSize: 36),
                            ),
                          ),
                        ),
                      ),
                      /*ElevatedButton(
                        onPressed: () => checkPreviousCardMatch(false),
                        child: Text('Not Same'),
                      ),*/
                    ],
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}










/*
import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';


class CardMatchingGame extends StatefulWidget {
  @override
  _CardMatchingGameState createState() => _CardMatchingGameState();
}

class _CardMatchingGameState extends State<CardMatchingGame> with SingleTickerProviderStateMixin {
  final List<String> symbols = ['🏰', '🏹', '⚔️', '🐴', '👑', '🐲'];
  String previousCard1 = '';
  String previousCard2 = '';
  String currentCard = '';
  int score = 0;
  bool gameStarted = false;
  bool askingPreviousCardMatch = false;
  Timer? gameTimer;
  int timeLeft = 30; // Game duration in seconds
  int correctGuesses = 0; // Track the number of correct guesses

  late AnimationController _controller;
  late Animation<Offset> _slideOutAnimation;
  late Animation<Offset> _slideInAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _slideOutAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: Offset(-1.5, 0.0),
    ).animate(_controller);
    _slideInAnimation = Tween<Offset>(
      begin: Offset(1.5, 0.0),
      end: Offset.zero,
    ).animate(_controller);
  }

  @override
  void dispose() {
    gameTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void startGame() {
    setState(() {
      gameStarted = true;
      score = 0;
      timeLeft = 30;
      correctGuesses = 0;
      askingPreviousCardMatch = false;
      previousCard1 = '';
      previousCard2 = '';
    });
    nextCard();
    gameTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (timeLeft > 0) {
        setState(() {
          timeLeft--;
        });
      } else {
        timer.cancel();
        setState(() {
          gameStarted = false;
        });
      }
    });
  }

  void nextCard() {
    setState(() {
      previousCard2 = previousCard1;
      previousCard1 = currentCard;
      currentCard = symbols[Random().nextInt(symbols.length)];
      _controller.reset();
      _controller.forward();
    });
  }

  void handleAnswer(bool isSame) {
    if (!gameStarted || askingPreviousCardMatch) return;

    if (previousCard1.isNotEmpty && ((isSame && currentCard == previousCard1) || (!isSame && currentCard != previousCard1))) {
      setState(() {
        score++;
        correctGuesses++;
      });
    } else if (previousCard1.isNotEmpty) {
      setState(() {
        score--;
      });
    }

    if (correctGuesses % 5 == 0 && correctGuesses >= 20 && previousCard2.isNotEmpty) {
      setState(() {
        askingPreviousCardMatch = true;
      });
    } else {
      nextCard();
    }
  }

  void checkPreviousCardMatch(bool isSame) {
    if ((isSame && currentCard == previousCard2) || (!isSame && currentCard != previousCard2)) {
      setState(() {
        score += 5;
      });
    } else {
      setState(() {
        score -= 5;
      });
    }
    setState(() {
      askingPreviousCardMatch = false;
      nextCard();
    });
  }

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          //First Background Layer
          Container(
            width: deviceSize.width,
            height: deviceSize.height,
            child: Image(
              image: AssetImage('assets/images/medieval_background.png'),
              fit: BoxFit.cover,
            ),
          ),
          //Shadow Layer
          Container(
            width: deviceSize.width,
            height: deviceSize.height,
            color: Colors.black.withOpacity(0.2),
          ),
          //Second Game Layer
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Time Left: $timeLeft',
                  style: TextStyle(fontSize: 24),
                ),
                SizedBox(height: 20),
                Text(
                  'Score: $score',
                  style: TextStyle(fontSize: 24),
                ),
                SizedBox(height: 20),
                Stack(
                  children: [
                    if (previousCard1.isNotEmpty)
                      SlideTransition(
                        position: _slideOutAnimation,
                        child: Container(
                          key: ValueKey(previousCard1),
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.transparent, width: 2),
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.transparent,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            previousCard1,
                            style: TextStyle(fontSize: 100),
                          ),
                        ),
                      ),
                    SlideTransition(
                      position: _slideInAnimation,
                      child: Container(
                        key: ValueKey(currentCard),
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.transparent, width: 2),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.transparent,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          currentCard,
                          style: TextStyle(fontSize: 100),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                if (!askingPreviousCardMatch)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () => handleAnswer(true),
                        child: Text('Same'),
                      ),
                      SizedBox(width: 20),
                      ElevatedButton(
                        onPressed: () => handleAnswer(false),
                        child: Text('Not Same'),
                      ),
                    ],
                  ),
                if (askingPreviousCardMatch)
                  Column(
                    children: [
                      Text(
                        'Is the current card the same as the card shown two steps before?',
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () => checkPreviousCardMatch(true),
                            child: Text('Same'),
                          ),
                          SizedBox(width: 20),
                          ElevatedButton(
                            onPressed: () => checkPreviousCardMatch(false),
                            child: Text('Not Same'),
                          ),
                        ],
                      ),
                    ],
                  ),
                SizedBox(height: 20),
                if (!gameStarted)
                  ElevatedButton(
                    onPressed: startGame,
                    child: Text('Start Game'),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
*/