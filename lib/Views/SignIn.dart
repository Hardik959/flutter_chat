// ignore_for_file: file_names, prefer_const_constructors, sized_box_for_whitespace, non_constant_identifier_names, unnecessary_new, await_only_futures

import 'package:flutter/material.dart';
import 'package:flutter_chat/Services/auth.dart';
import 'package:flutter_chat/Services/authenticator.dart';
import 'package:flutter_chat/Services/database.dart';
import 'package:flutter_chat/Services/helperfunctions.dart';
import 'package:flutter_chat/Views/ChatRoom.dart';
import 'package:flutter_chat/Views/SignUp.dart';
import 'package:flutter_chat/widgets/widgets.dart';

class SignIn extends StatefulWidget {
  Function? toggle;
  SignIn(this.toggle);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final formKey = GlobalKey<FormState>();
  DatabaseMethods databaseMethods = new DatabaseMethods();
  AuthMethods authMethods = new AuthMethods();
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  late Map<String, dynamic> searchResultSnapshot;

  bool isLoading = false;
  signIn() async {
    if (formKey.currentState!.validate()) {
      HelperFunctions.saveUserEmailSharedPreference(email.text);
      //HelperFunctions.saveUserNameSharedPreference(userName.text);
      setState(() {
        isLoading = true;
      });
      await databaseMethods.searchByEmail(email.text).then((value) {
        searchResultSnapshot = value;
        HelperFunctions.saveUserNameSharedPreference(value["Name"]);
      });
      authMethods
          .signInWithEmailAndPassword(email.text, password.text)
          .then((val) {
        if (val != Null) {
          HelperFunctions.saveUserLoggedInSharedPreference(true);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Chatroom()));
        } else {
          final snackBar = SnackBar(
            backgroundColor: Colors.amberAccent,
            content: const Text(
              'Invalid Email Address!',
              style: TextStyle(color: Colors.black),
            ),
            // action: SnackBarAction(
            //   label: 'Undo',
            //   onPressed: () {
            //     // Some code to undo the change.
            //   },
            // ),
          );

          // Find the ScaffoldMessenger in the widget tree
          // and use it to show a SnackBar.
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      });
    }
  }

  // AuthenticateState authenticate = new AuthenticateState();
  // Function? toggle;
  // SignIn(toggle);
  // SignUp(toggle);
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50), child: appbarmain(context)),
      body: SingleChildScrollView(
        child: Container(
            width: width,
            height: height,
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
                  key: formKey,
                  child: Column(
                    children: [
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
                        height: 20,
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
                Container(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                        onPressed: () {
                          authMethods.resetpass(email.text);
                        },
                        child: Text(
                          "Forgot Password?",
                          style: TextStyle(color: Colors.grey[700]),
                        ))),
                SizedBox(
                  height: 5,
                ),
                // ignore: sized_box_for_whitespace
                Container(
                  width: 300,
                  height: 50,
                  child: ElevatedButton(
                    child: Text("Sign In".toUpperCase(),
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
                    onPressed: () {
                      signIn();
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
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
                        Text("Sign In with Google".toUpperCase(),
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
                    Text("Don't have an account?"),
                    TextButton(
                        onPressed: () {
                          // authenticate.toggleView();
                          widget.toggle!();
                        },
                        child: Text(
                          "Register Now",
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
