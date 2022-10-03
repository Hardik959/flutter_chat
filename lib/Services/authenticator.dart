import 'package:flutter/material.dart';
import 'package:flutter_chat/Views/SignIn.dart';
import 'package:flutter_chat/Views/SignUp.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showsignin = true;
  void toggleView() {
    setState(() {
      showsignin = !showsignin;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showsignin) {
      return SignIn(toggleView);
    } else
      return SignUp(toggleView);
  }
}
