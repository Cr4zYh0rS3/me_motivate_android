import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class GameIntroduction extends StatelessWidget {
  static const routeName = '/game-introduction';
  const GameIntroduction({super.key});

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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Stack(
              children: [
                Container(
                  width: deviceSize.width,
                  height: deviceSize.height * 0.3,
                  child: Image(
                    image: AssetImage(args['gameOutroMedia']),
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  width: deviceSize.width,
                  height: deviceSize.height * 0.3,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.black, Colors.transparent],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                ),
                Container(
                  width: deviceSize.width,
                  height: deviceSize.height * 0.3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: deviceSize.width * 0.02, top: deviceSize.height * 0.04),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushReplacementNamed(context, '/game-test-screen');
                          },
                          child: Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: deviceSize.width * 0.02, top: deviceSize.height * 0.01),
                            child: Text(
                              args['gameName'],
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: deviceSize.width * 0.06,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, args['gamePath'].toString());
              },
              child: Container(
                margin: EdgeInsets.only(top: deviceSize.height * 0.02),
                width: deviceSize.width * 0.8,
                height: deviceSize.width * 0.15,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Center(
                  child: Text(
                    'Try Again',
                    style: TextStyle(color: Colors.white, fontSize: deviceSize.width * 0.05),
                  ),
                ),
              ),
            ),
            Container(
              width: deviceSize.width,
              height: deviceSize.height * 0.55,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
                color: Color(0xff040932),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: deviceSize.width * 0.25,
                    child: Image(
                      image: AssetImage('assets/images/ranking.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Text(
                    'Global Rankings',
                    style: TextStyle(color: Colors.white, fontSize: deviceSize.width * 0.05),
                  ),
                  Container(
                    child: Column(
                      children: [
                        Text(
                          '186. M.Franklin 1286 pts',
                          style: TextStyle(color: Colors.white, fontSize: deviceSize.width * 0.045),
                        ),
                        Text(
                          '187. M.Franklin 1285 pts',
                          style: TextStyle(color: Colors.white, fontSize: deviceSize.width * 0.045),
                        ),
                        Text(
                          '188. M.Franklin 1284 pts',
                          style: TextStyle(color: Colors.white, fontSize: deviceSize.width * 0.045),
                        ),
                        Container(
                          color: Colors.blue,
                          child: Text(
                            '189. M.Franklin ${args['score']} pts',
                            style: TextStyle(color: Colors.white, fontSize: deviceSize.width * 0.045),
                          ),
                        ),
                        Text(
                          '190. M.Franklin 1282 pts',
                          style: TextStyle(color: Colors.white, fontSize: deviceSize.width * 0.045),
                        ),
                        Text(
                          '191. M.Franklin 1281 pts',
                          style: TextStyle(color: Colors.white, fontSize: deviceSize.width * 0.045),
                        ),
                        Text(
                          '192. M.Franklin 1280 pts',
                          style: TextStyle(color: Colors.white, fontSize: deviceSize.width * 0.045),
                        ),
                        Text(
                          '193. M.Franklin 1279 pts',
                          style: TextStyle(color: Colors.white, fontSize: deviceSize.width * 0.045),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
