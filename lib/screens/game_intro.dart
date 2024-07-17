import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';

class GameIntro extends StatefulWidget {
  static const routeName = '/game-intro';
  const GameIntro({super.key});

  @override
  State<GameIntro> createState() => _GameIntroState();
}

class _GameIntroState extends State<GameIntro> {
  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    Map args = ModalRoute.of(context)!.settings.arguments as Map;
    return Scaffold(
      body: Stack(
        children: [
          OnBoardingSlider(
            headerBackgroundColor: Color(0xff1d1e30),
            finishButtonText: 'Get Started',
            finishButtonTextStyle: TextStyle(color: Colors.white),
            onFinish: () {
              // Navigate to another screen when onboarding is finished
              Navigator.pushReplacementNamed(context, args['gamePath']);
            },
            skipTextButton: Text(
              'Skip',
              style: TextStyle(
                color: Colors.white,
                fontSize: deviceSize.width * 0.045,
              ),
            ),
            trailing: Container(
              color: Colors.transparent,
            ),
            trailingFunction: () {
              // Handle trailing button action
            },
            controllerColor: Colors.blue,
            hasFloatingButton: true,
            totalPage: 3,
            speed: 1.8,
            pageBackgroundColor: Color(0xff1d1e30),
            background: [
              Container(color: Colors.red),
              Container(color: Colors.green),
              Container(color: Colors.blue),
            ],
            pageBodies: [
              _buildPage(
                imagePath: args['introMediaPath'].toString(),
                description: args['introMediaDesc'].toString(),
                context: context,
              ),
              _buildPage(
                imagePath: args['introMediaPath2'].toString(),
                description: args['introMediaDesc2'].toString(),
                context: context,
              ),
              Stack(
                children: [
                  Positioned.fill(
                    child: Image(
                      image: AssetImage(
                        args['introMediaPath3'].toString(),
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.black, Colors.transparent],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                  ),
                  /*GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, args['gamePath']);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          width: deviceSize.width * 0.9,
                          height: deviceSize.width * 0.18,
                          margin: EdgeInsets.only(left: deviceSize.width * 0.05, bottom: deviceSize.height * 0.02),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Center(
                            child: Text(
                              'Start Game',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: deviceSize.width * 0.05,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),*/
                ],
              ),
            ],
            finishButtonStyle: FinishButtonStyle(
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: deviceSize.width * 0.04, top: deviceSize.height * 0.045),
            child: GestureDetector(
              onTap: () {
                Navigator.pushReplacementNamed(context, '/game-test-screen');
              },
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}

Widget _buildPage({required String imagePath, required String description, required BuildContext context}) {
  var deviceSize = MediaQuery.of(context).size;
  return Container(
    width: double.infinity,
    height: double.infinity,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: deviceSize.width * 0.8,
          height: deviceSize.width * 0.8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Colors.transparent,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(height: deviceSize.height * 0.02),
        Container(
          width: deviceSize.width * 0.9,
          child: Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    ),
  );
}
