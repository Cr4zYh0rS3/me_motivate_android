import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class MemoryGame extends StatefulWidget {
  static const routeName = '/game-memory';
  @override
  _MemoryGameState createState() => _MemoryGameState();
}

class _MemoryGameState extends State<MemoryGame> with SingleTickerProviderStateMixin {
  final List<String> _symbols = ['★', '☆', '♥', '♦', '♣', '♠', '⬤', '⬥'];
  List<String> _sequence = [];
  List<String> _userInput = [];
  int _level = 1;
  int _displayDuration = 1000;
  bool _showSequence = true;
  String _currentCard = '';
  late AnimationController _controller;
  late Animation<Offset> _animation;
  late Timer _sequenceTimer;
  late Timer _gameTimer;
  int _remainingTime = 60;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = Tween<Offset>(
      begin: Offset(1.0, 0.0),
      end: Offset(0.0, 0.0),
    ).animate(_controller);
    _startGame();
  }

  @override
  void dispose() {
    _controller.dispose();
    if (_sequenceTimer != null) {
      _sequenceTimer.cancel();
    }
    if (_gameTimer != null) {
      _gameTimer.cancel();
    }
    super.dispose();
  }

  void _startGame() {
    _startNewLevel();
    _startGameTimer();
  }

  void _startNewLevel() {
    _userInput.clear();
    _sequence = List.generate(_level + 2, (index) => _generateRandomCard());
    _displayDuration = max(100, _displayDuration - 50);
    _showSequence = true;
    _currentCard = '';
    setState(() {});
    _showSequenceToUser();
  }

  void _startGameTimer() {
    _gameTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_remainingTime <= 0) {
        timer.cancel();
        _navigateToGameOverPage();
      } else {
        setState(() {
          _remainingTime--;
        });
      }
    });
  }

  String _generateRandomCard() {
    final random = Random();
    return random.nextBool() ? (random.nextInt(9) + 1).toString() : _symbols[random.nextInt(_symbols.length)];
  }

  void _showSequenceToUser() {
    int index = 0;
    _sequenceTimer = Timer.periodic(Duration(milliseconds: _displayDuration), (timer) {
      if (index >= _sequence.length) {
        timer.cancel();
        setState(() {
          _showSequence = false;
          _currentCard = '';
        });
      } else {
        _controller.reset();
        setState(() {
          _currentCard = _sequence[index];
        });
        _controller.forward();
        index++;
      }
    });
  }

  void _onUserInput(String input) {
    setState(() {
      _userInput.add(input);
      if (_userInput.length == _sequence.length) {
        if (_userInput.join() == _sequence.join()) {
          _level++;
          _startNewLevel();
        } else {
          _level = 1;
          _displayDuration = 1000;
          _startNewLevel();
        }
      }
    });
  }

  void _navigateToGameOverPage() {
    Navigator.pushReplacementNamed(context, '/game-introduction', arguments: {'gamePath': '/game-memory'});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _showSequence ? _buildSequenceDisplay() : _buildUserInput(),
    );
  }

  Widget _buildSequenceDisplay() {
    return Center(
      child: Stack(
        children: [
          // Background Layer
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image(
              image: AssetImage('assets/images/game2bg.png'),
              fit: BoxFit.cover,
            ),
          ),
          // Card Layer
          SlideTransition(
            position: _animation,
            child: Container(
              color: Colors.transparent,
              child: Center(
                child: _currentCard.isNotEmpty
                    ? Stack(
                        alignment: Alignment.center,
                        children: [
                          // Background Layer
                          Image(
                            image: AssetImage('assets/images/game2card.png'),
                          ),
                          // Value Layer
                          Text(
                            _currentCard,
                            style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                        ],
                      )
                    : Container(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserInput() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          // Background Layer
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image(
              image: AssetImage('assets/images/woodenbackground.png'),
              fit: BoxFit.cover,
            ),
          ),
          // Content Layer
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.width * 0.25,
                color: Colors.red,
                child: Center(
                  child: Wrap(
                    children: _userInput.map((input) => Text(input, style: TextStyle(fontSize: 24))).toList(),
                  ),
                ),
              ),
              Wrap(
                alignment: WrapAlignment.center,
                children: [
                  ..._symbols.map((symbol) => _buildCard(symbol)),
                  ...List.generate(9, (index) => _buildCard((index + 1).toString())),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCard(String value) {
    return GestureDetector(
      onTap: () => _onUserInput(value),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.2,
        color: Colors.transparent,
        margin: EdgeInsets.all(8),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Background Layer
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.2,
              child: Image(
                image: AssetImage('assets/images/game2cardlittle.png'),
                fit: BoxFit.contain,
              ),
            ),
            // Value Layer
            Text(value, style: TextStyle(fontSize: 24, color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
