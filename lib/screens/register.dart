import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Register extends StatefulWidget {
  static const routeName = '/register';
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _sirnameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _pwdController = TextEditingController();
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
                  radius: 2.0,
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
                color: Colors.transparent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: deviceSize.height * 0.1),
                    Text(
                      "Sign Up",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: deviceSize.width * 0.09,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      width: deviceSize.width * 0.9,
                      child: Text(
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.74),
                          fontSize: deviceSize.width * 0.035,
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                    ),
                    SizedBox(height: deviceSize.height * 0.06),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: deviceSize.width * 0.425,
                          height: deviceSize.width * 0.18,
                          padding: EdgeInsets.only(left: deviceSize.width * 0.02, right: deviceSize.width * 0.01),
                          decoration: BoxDecoration(
                            color: Color(0xff191a2b),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: TextField(
                              controller: _nameController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                icon: Icon(
                                  Icons.account_circle_outlined,
                                  color: Colors.white,
                                ),
                                hintText: "Ad",
                                hintStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.w300, fontSize: deviceSize.width * 0.04),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: deviceSize.width * 0.05),
                        Container(
                          width: deviceSize.width * 0.425,
                          height: deviceSize.width * 0.18,
                          padding: EdgeInsets.only(left: deviceSize.width * 0.02, right: deviceSize.width * 0.01),
                          decoration: BoxDecoration(
                            color: Color(0xff191a2b),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: TextField(
                              controller: _sirnameController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                icon: Icon(
                                  Icons.account_circle_outlined,
                                  color: Colors.white,
                                ),
                                hintText: "Soyad",
                                hintStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.w300, fontSize: deviceSize.width * 0.04),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: deviceSize.height * 0.02),
                    Container(
                      width: deviceSize.width * 0.9,
                      height: deviceSize.width * 0.18,
                      padding: EdgeInsets.only(left: deviceSize.width * 0.02, right: deviceSize.width * 0.01),
                      decoration: BoxDecoration(
                        color: Color(0xff191a2b),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: TextField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              Icons.account_circle_outlined,
                              color: Colors.white,
                            ),
                            hintText: "Email",
                            hintStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.w300, fontSize: deviceSize.width * 0.04),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: deviceSize.height * 0.02),
                    Container(
                      width: deviceSize.width * 0.9,
                      height: deviceSize.width * 0.18,
                      padding: EdgeInsets.only(left: deviceSize.width * 0.02, right: deviceSize.width * 0.01),
                      decoration: BoxDecoration(
                        color: Color(0xff191a2b),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: TextField(
                          controller: _pwdController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              Icons.lock_open_rounded,
                              color: Colors.white,
                            ),
                            hintText: "Password",
                            hintStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.w300, fontSize: deviceSize.width * 0.04),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: deviceSize.height * 0.02),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacementNamed(context, '/game-test-screen');
                      },
                      child: Container(
                        width: deviceSize.width * 0.9,
                        height: deviceSize.width * 0.15,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: Center(
                          child: Text(
                            "Sign Up",
                            style: TextStyle(color: Colors.white, fontSize: deviceSize.width * 0.045, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: deviceSize.height * 0.05),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: deviceSize.width * 0.3,
                          height: 2,
                          color: Colors.grey,
                        ),
                        SizedBox(width: deviceSize.width * 0.02),
                        Text(
                          "Or sign in with",
                          style: TextStyle(color: Colors.white.withOpacity(0.74), fontSize: deviceSize.width * 0.035),
                        ),
                        SizedBox(width: deviceSize.width * 0.02),
                        Container(
                          width: deviceSize.width * 0.3,
                          height: 2,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                    SizedBox(height: deviceSize.height * 0.02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: deviceSize.width * 0.17,
                          height: deviceSize.width * 0.17,
                          padding: EdgeInsets.all(deviceSize.width * 0.02),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(
                            child: Image(
                              image: AssetImage('assets/images/googlelogo.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: deviceSize.width * 0.04),
                        Container(
                          width: deviceSize.width * 0.17,
                          height: deviceSize.width * 0.17,
                          padding: EdgeInsets.all(deviceSize.width * 0.02),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(
                            child: Image(
                              image: AssetImage('assets/images/applelogo.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: deviceSize.height * 0.03),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already gave an account? ",
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.74),
                            fontSize: deviceSize.width * 0.035,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/login');
                          },
                          child: Text(
                            "Sign In",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: deviceSize.width * 0.035,
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.white,
                                decorationThickness: 2,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: deviceSize.height * 0.01),
                    Container(
                      width: deviceSize.width * 0.9,
                      child: Text(
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.74),
                          fontSize: deviceSize.width * 0.035,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
