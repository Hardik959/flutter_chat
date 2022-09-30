// ignore_for_file: file_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_chat/widgets/widgets.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50), child: appbarmain(context)),
      body: SingleChildScrollView(
        child: Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Image.asset("assets/images/connect.jpg"),
                SizedBox(
                  height: 30,
                ),
                Divider(
                  thickness: 1,
                  color: Colors.black54,
                ),
                SizedBox(
                  height: 30,
                ),
                TextField(
                  decoration: InputDecoration(
                    hintText: "Email",
                    hintStyle: TextStyle(),
                  ),
                  onTap: (() {}),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    
                    hintText: "Password",
                    hintStyle: TextStyle(),
                  ),
                  onTap: (() {}),
                ),
              ],
            )),
      ),
    );
  }
}
