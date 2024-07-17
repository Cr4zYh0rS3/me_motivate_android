import 'package:flutter/material.dart';

class LoaderScreen extends StatefulWidget {
  static const routeName = '/loader-screen';
  const LoaderScreen({super.key});

  @override
  _LoaderScreenState createState() => _LoaderScreenState();
}

class _LoaderScreenState extends State<LoaderScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/get-started'); // Change '/next-screen' to your target route name
    });
  }

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
              child: Image(
                image: AssetImage('assets/images/wires.png'),
                fit: BoxFit.cover,
              ),
            ),
            Container(
              width: deviceSize.width,
              height: deviceSize.height,
              color: Colors.transparent,
              child: Center(
                child: Text(
                  "MeMotivate",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: deviceSize.width * 0.08,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
