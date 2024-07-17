import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:me_motivate_android/screens/login.dart';

class GetStarted extends StatelessWidget {
  static const routeName = '/get-started';
  const GetStarted({super.key});

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xff1d1e30),
      body: Center(
        child: Stack(
          children: [
            Container(
              width: deviceSize.width,
              height: deviceSize.height,
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: [Color(0xff2c74e2), Colors.transparent],
                  center: Alignment.topLeft,
                  radius: 1.0,
                ),
              ),
            ),
            Container(
              width: deviceSize.width,
              height: deviceSize.height,
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: [Color(0xff2c74e2), Colors.transparent],
                  center: Alignment.bottomRight,
                  radius: 2.0,
                ),
              ),
            ),
            Container(
              width: deviceSize.width,
              height: deviceSize.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: deviceSize.height * 0.1),
                    width: deviceSize.width * 0.8,
                    child: Image(
                      image: AssetImage('assets/images/brain.png'),
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: deviceSize.width,
              height: deviceSize.height,
              padding: EdgeInsets.only(left: deviceSize.width * 0.1, right: deviceSize.width * 0.1),
              color: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Creative",
                    style: TextStyle(color: Colors.white.withOpacity(0.74), fontSize: deviceSize.width * 0.045),
                  ),
                  Text(
                    "Brain Levels",
                    style: TextStyle(color: Colors.white, fontSize: deviceSize.width * 0.08, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor ",
                    style: TextStyle(color: Colors.white.withOpacity(0.74), fontSize: deviceSize.width * 0.035),
                  ),
                  SizedBox(height: deviceSize.height * 0.065),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(context, '/login');
                        },
                        child: Container(
                          width: deviceSize.width * 0.8,
                          height: deviceSize.width * 0.15,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                "Let's get started",
                                style: TextStyle(color: Colors.white, fontSize: deviceSize.width * 0.045, fontWeight: FontWeight.bold),
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Colors.white,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: deviceSize.height * 0.06),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
