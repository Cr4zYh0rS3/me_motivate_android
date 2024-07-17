import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:me_motivate_android/Games/Memory%20Test%20Images/questions_scripts.dart';

class Questions extends StatefulWidget {
  static const routeName = '/questions';
  const Questions({super.key});

  @override
  State<Questions> createState() => _QuestionsState();
}

class _QuestionsState extends State<Questions> {
  int questionCounter = 1;

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    Map args = ModalRoute.of(context)!.settings.arguments as Map;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        width: deviceSize.width,
        height: deviceSize.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: deviceSize.width * 0.9,
              height: deviceSize.width * 0.5,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(QuestionScripts().Questions[args['imageNum'].toString()]['Q$questionCounter']),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    if (QuestionScripts().Questions[args['imageNum'].toString()]['Q${questionCounter}1'] == QuestionScripts().Questions[args['imageNum'].toString()]['Q${questionCounter}A']) {
                      print('true');

                      if (questionCounter < 10) {
                        setState(() {
                          questionCounter++;
                          print(questionCounter);
                        });
                      } else {
                        Navigator.pushReplacementNamed(context, '/gameplay-view', arguments: {'currentImage': args['imageNum'] + 1});
                      }
                    }
                  },
                  child: Container(
                    width: deviceSize.width * 0.3,
                    height: deviceSize.width * 0.15,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(QuestionScripts().Questions[args['imageNum'].toString()]['Q${questionCounter}1']),
                  ),
                ),
                SizedBox(width: deviceSize.width * 0.02),
                GestureDetector(
                  onTap: () {
                    if (QuestionScripts().Questions[args['imageNum'].toString()]['Q${questionCounter}2'] == QuestionScripts().Questions[args['imageNum'].toString()]['Q${questionCounter}A']) {
                      print('true');

                      if (questionCounter < 10) {
                        setState(() {
                          questionCounter++;
                          print(questionCounter);
                        });
                      } else {
                        Navigator.pushReplacementNamed(context, '/gameplay-view', arguments: {'currentImage': args['imageNum'] + 1});
                      }
                    }
                  },
                  child: Container(
                    width: deviceSize.width * 0.3,
                    height: deviceSize.width * 0.15,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(QuestionScripts().Questions[args['imageNum'].toString()]['Q${questionCounter}2']),
                  ),
                ),
                SizedBox(width: deviceSize.width * 0.02),
                GestureDetector(
                  onTap: () {
                    if (QuestionScripts().Questions[args['imageNum'].toString()]['Q${questionCounter}3'] == QuestionScripts().Questions[args['imageNum'].toString()]['Q${questionCounter}A']) {
                      print('true');

                      if (questionCounter < 10) {
                        setState(() {
                          questionCounter++;
                          print(questionCounter);
                        });
                      } else {
                        Navigator.pushReplacementNamed(context, '/gameplay-view', arguments: {'currentImage': args['imageNum'] + 1});
                      }
                    }
                  },
                  child: Container(
                    width: deviceSize.width * 0.3,
                    height: deviceSize.width * 0.15,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(QuestionScripts().Questions[args['imageNum'].toString()]['Q${questionCounter}3']),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
