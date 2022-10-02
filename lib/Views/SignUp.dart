// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_chat/Views/SignIn.dart';
import 'package:flutter_chat/widgets/widgets.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
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
                  decoration: inputtextfield("Username"),
                  onTap: (() {}),
                ),
                SizedBox(
                  height: 15,
                ),
                TextField(
                  obscureText: true,
                  decoration: inputtextfield("Email"),
                  onTap: (() {}),
                ),
                SizedBox(
                  height: 15,
                ),
                TextField(
                  obscureText: true,
                  decoration: inputtextfield("Password"),
                  onTap: (() {}),
                ),

                SizedBox(
                  height: 20,
                ),
                // ignore: sized_box_for_whitespace
                Container(
                  width: 300,
                  height: 50,
                  child: ElevatedButton(
                    child: Text("Sign Up".toUpperCase(),
                        style: TextStyle(fontSize: 14)),
                    style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.black),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    side: BorderSide(color: Colors.black)))),
                    onPressed: () {},
                  ),
                ),
                SizedBox(
                  height: 7,
                ),
                Container(
                  width: 300,
                  height: 50.3,
                  child: ElevatedButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/googlesign.png",
                          height: 40,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text("Sign Up with Google".toUpperCase(),
                            style:
                                TextStyle(fontSize: 14, color: Colors.black)),
                      ],
                    ),
                    style: ButtonStyle(
                        elevation: MaterialStateProperty.all<double>(20),
                        shadowColor:
                            MaterialStateProperty.all<Color>(Colors.black),
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    side: BorderSide(color: Colors.white)))),
                    onPressed: () {},
                  ),
                ),
                // ignore: prefer_const_literals_to_create_immutables
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account?"),
                    TextButton(
                        onPressed: () {Navigator.pop(context);
                        },
                        child: Text(
                          "Sign In",
                          style: TextStyle(color: Colors.grey[700]),
                        ))
                  ],
                )
              ],
            )),
      ),
    );
  }
}
