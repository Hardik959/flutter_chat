// ignore_for_file: prefer_const_constructors, unnecessary_new, empty_statements, avoid_unnecessary_containers, avoid_print, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_chat/Services/auth.dart';
import 'package:flutter_chat/Services/database.dart';
import 'package:flutter_chat/Services/helperfunctions.dart';
import 'package:flutter_chat/Views/ChatRoom.dart';
import 'package:flutter_chat/Views/SignIn.dart';
import 'package:flutter_chat/Views/SignUp.dart';
import 'package:flutter_chat/widgets/widgets.dart';

class SignUp extends StatefulWidget {
  Function? toggle;
  SignUp(this.toggle);

  @override
  State<SignUp> createState() => SignUpState();
}

class SignUpState extends State<SignUp> {
  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();
  bool isloading = false;
  final formkey = GlobalKey<FormState>();
  TextEditingController userName = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  signmeUP() {
    if (formkey.currentState!.validate()) {
      setState(() {
        isloading = true;
      });
      authMethods
          .signUpWithEmailandPassword(email.text, password.text)
          .then((value) => print("{$value.userId}"));
      Map<String, String> usermap = {
        "Name": userName.text,
        "Email": email.text,
      };
      HelperFunctions.saveUserEmailSharedPreference(email.text);
      HelperFunctions.saveUserNameSharedPreference(userName.text);
      databaseMethods.uploadUserInfo(usermap);
      HelperFunctions.saveUserLoggedInSharedPreference(true);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Chatroom()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50), child: appbarmain(context)),
      body: isloading
          ? Center(
              child: Container(
                child: CircularProgressIndicator(),
              ),
            )
          : SingleChildScrollView(
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
                      Form(
                        key: formkey,
                        child: Column(
                          children: [
                            TextFormField(
                              validator: (String? value) {
                                if (value != null &&
                                    value.isEmpty &&
                                    value.length < 3) {
                                  return "Please enter a valid username";
                                }

                                return null;
                              },
                              controller: userName,
                              decoration: inputtextfield("Username"),
                              onTap: (() {}),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                              validator: (String? value) {
                                return RegExp(
                                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                        .hasMatch(value!)
                                    ? null
                                    : "Please Enter a valid Email";
                                // if (value != null &&
                                //     value.isEmpty &&
                                //     value.length < 3) {
                                //   return "Please enter a valid username";
                                // }

                                // return null;
                              },
                              controller: email,
                              decoration: inputtextfield("Email"),
                              onTap: (() {}),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                              validator: (String? value) {
                                if (value!.length < 6 || value.isEmpty) {
                                  return "Please enter a password greater than 6 characters";
                                }

                                return null;
                              },
                              controller: password,
                              obscureText: true,
                              decoration: inputtextfield("Password"),
                              onTap: (() {}),
                            ),
                          ],
                        ),
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
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.black),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      side: BorderSide(color: Colors.black)))),
                          onPressed: () {
                            signmeUP();
                          },
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
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.black)),
                            ],
                          ),
                          style: ButtonStyle(
                              elevation: MaterialStateProperty.all<double>(20),
                              shadowColor: MaterialStateProperty.all<Color>(
                                  Colors.black),
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
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
                              onPressed: () {
                                widget.toggle!();
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

  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
