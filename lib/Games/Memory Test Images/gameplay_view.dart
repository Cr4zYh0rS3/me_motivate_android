import 'dart:async';

import 'package:flutter/material.dart';

class GameplayView extends StatefulWidget {
  static const routeName = '/gameplay-view';
  const GameplayView({super.key});

  @override
  State<GameplayView> createState() => _GameplayViewState();
}

class _GameplayViewState extends State<GameplayView> {
  Timer? _timer;
  int _start = 3;

  int currentImage = 1;

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_start > 0) {
          _start--;
        } else {
          Navigator.pushReplacementNamed(context, '/questions', arguments: {'imageNum': currentImage});
          _timer?.cancel();
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final arguments = ModalRoute.of(context)!.settings.arguments;
    if (arguments != null && arguments is Map<dynamic, dynamic>) {
      Map args = arguments as Map<dynamic, dynamic>;
      if (args.containsKey('currentImage')) {
        print(args['currentImage']);
        currentImage = args['currentImage'];
      }
    } else {
      // Handle the case where arguments are null or not a Map
      print('No arguments or arguments are not a Map');
    }
  }

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        width: deviceSize.width,
        height: deviceSize.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: deviceSize.width * 0.9,
              height: deviceSize.height * 0.8,
              child: Image(
                image: AssetImage('assets/images/Image${currentImage.toString()}.png'),
                fit: BoxFit.cover,
              ),
            ),
            Text(_start.toString()),
          ],
        ),
      ),
    );
  }
}
