import 'dart:math';
import 'package:flutter/material.dart';

class EmojiGame extends StatefulWidget {
  static const routeName = '/game3.1';
  @override
  _EmojiGameState createState() => _EmojiGameState();
}

class _EmojiGameState extends State<EmojiGame> {
  final List<String> initialEmojis = ['🚪', '🐦', '🍎', '📖'];
  final List<String> lettersNumbers = ['M', 'H', '9', 'X'];
  final List<String> allEmojis = ['🚪', '🐦', '🍎', '📖', '🐱', '🌳', '🎈', '🍇', '🎧', '✈️'];
  final List<String> allLettersNumbers = ['M', 'H', '9', 'X', 'J', 'K', 'L', 'P', 'Q', 'R'];
  Map<String, String> emojiMap = {};
  final Random _random = Random();
  String currentEmoji = '';
  String currentAnswer = '';
  List<String> options = [];
  bool showResult = false;
  Color resultColor = Colors.white;
  int trueAnswerCount = 0;
  Map<String, int> recentAddedEmojis = {};
  String clickedOption = '';
  double containerWidth = 0;
  double containerHeight = 0;
  bool isClicked = false;

  @override
  void initState() {
    super.initState();
    shuffleEmojiMap(initialEmojis, lettersNumbers);
    generateNewCard();
  }

  void shuffleEmojiMap(List<String> emojis, List<String> lettersNumbers) {
    final shuffledLettersNumbers = List<String>.from(lettersNumbers)..shuffle(_random);
    setState(() {
      emojiMap = Map.fromIterables(emojis, shuffledLettersNumbers);
    });
  }

  void generateNewCard() {
    final emoji = emojiMap.keys.elementAt(_random.nextInt(emojiMap.length));
    setState(() {
      currentEmoji = emoji;
      currentAnswer = emojiMap[emoji]!;
      options = generateOptions(currentAnswer);
      showResult = false;
      clickedOption = '';
      isClicked = false;
    });
  }

  List<String> generateOptions(String answer) {
    List<String> newOptions = [answer];
    while (newOptions.length < 4) {
      final option = emojiMap.values.elementAt(_random.nextInt(emojiMap.length));
      if (!newOptions.contains(option)) {
        newOptions.add(option);
      }
    }
    newOptions.shuffle();
    return newOptions;
  }

  void checkAnswer(String answer) {
    setState(() {
      showResult = true;
      resultColor = (answer == currentAnswer) ? Colors.green : Colors.red;
      clickedOption = answer;
    });
    Future.delayed(Duration(milliseconds: 500), () {
      if (answer == currentAnswer) {
        setState(() {
          trueAnswerCount++;
          updateRecentAddedEmojis();
          if (trueAnswerCount > 15 && trueAnswerCount % 10 == 5) {
            addRandomEmoji();
          }
          generateNewCard();
        });
      } else {
        Navigator.pushReplacementNamed(context, '/game-introduction', arguments: {'gamePath': '/game3.1', 'gameOutroMedia': 'assets/images/game3.1outromedia.png', 'gameName': 'Game 3.1'});
        /*showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text("Game Over"),
            content: Text("Incorrect answer!"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    trueAnswerCount = 0;
                    recentAddedEmojis.clear();
                    shuffleEmojiMap(initialEmojis, lettersNumbers);
                    generateNewCard();
                  });
                },
                child: Text("Restart"),
              ),
            ],
          ),
        );*/
      }
    });
  }

  void addRandomEmoji() {
    final availableEmojis = allEmojis.where((emoji) => !emojiMap.containsKey(emoji)).toList();
    final availableLettersNumbers = allLettersNumbers.where((letterNumber) => !emojiMap.containsValue(letterNumber)).toList();

    if (availableEmojis.isNotEmpty && availableLettersNumbers.isNotEmpty) {
      final newEmoji = availableEmojis[_random.nextInt(availableEmojis.length)];
      final newLetterNumber = availableLettersNumbers[_random.nextInt(availableLettersNumbers.length)];

      setState(() {
        emojiMap[newEmoji] = newLetterNumber;
        recentAddedEmojis[newEmoji] = 0;
      });
    }
  }

  void updateRecentAddedEmojis() {
    final toRemove = <String>[];
    recentAddedEmojis.forEach((emoji, count) {
      if (count + 1 >= 5) {
        toRemove.add(emoji);
      } else {
        recentAddedEmojis[emoji] = count + 1;
      }
    });
    toRemove.forEach((emoji) => recentAddedEmojis.remove(emoji));
  }

  void handleTap(String option) {
    setState(() {
      clickedOption = option;
      isClicked = true;
    });
    Future.delayed(Duration(milliseconds: 200), () {
      setState(() {
        isClicked = false;
      });
      checkAnswer(option);
    });
  }

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    var widthOfOption = deviceSize.width * 0.3;
    var heightOfOption = deviceSize.width * 0.18;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image(
              image: AssetImage('assets/images/blueorb.gif'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: deviceSize.width * 0.5,
                  height: deviceSize.width * 0.5,
                  child: Stack(
                    children: [
                      Image(
                        image: AssetImage('assets/images/scififrame.png'),
                        fit: BoxFit.cover,
                      ),
                      Container(
                        child: Center(
                          child: Text(
                            currentEmoji,
                            style: TextStyle(fontSize: deviceSize.width * 0.2),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: deviceSize.height * 0.2),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: options.map((option) {
                    MapEntry displayText = emojiMap.entries.firstWhere((entry) => entry.value == option);
                    bool showEmoji = trueAnswerCount <= 5 || recentAddedEmojis.containsKey(displayText.key);
                    return GestureDetector(
                      onTap: () {
                        handleTap(option);
                      },
                      child: AnimatedContainer(
                        width: isClicked && clickedOption == option ? widthOfOption * 0.9 : widthOfOption,
                        height: isClicked && clickedOption == option ? heightOfOption * 0.9 : heightOfOption,
                        margin: EdgeInsets.only(top: deviceSize.height * 0.01),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        duration: Duration(milliseconds: 200),
                        child: Stack(
                          children: [
                            Image(
                              image: AssetImage('assets/images/scifioptionframe.png'),
                              fit: BoxFit.cover,
                            ),
                            Center(
                              child: Text(
                                showEmoji ? '${displayText.key} = ${displayText.value}' : '${displayText.value}',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
