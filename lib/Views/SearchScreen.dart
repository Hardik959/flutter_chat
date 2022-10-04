// ignore_for_file: prefer_const_constructors, duplicate_ignore, non_constant_identifier_names, avoid_unnecessary_containers, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, unnecessary_new, avoid_print, unnecessary_null_comparison, await_only_futures

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/Services/database.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController searchText = new TextEditingController();
  DatabaseMethods databaseMethods = new DatabaseMethods();
   QuerySnapshot? searchSnapshot;
  QuerySnapshot? searsnapshot;
  initiateSearch() async {
    searchSnapshot =
        await databaseMethods.getUserbyUsername('ttttttt ');
  }

  @override
  void initState() {
    initiateSearch();
    // TODO: implement initState
    super.initState();
  }

  Widget SearchList() {
    return searchSnapshot != null
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: searchSnapshot!.size,
            itemBuilder: ((context, index) {
              return SearchTile(
                  userNAme: searchSnapshot!.docs[index].get('Name'),
                  userEmail: searchSnapshot!.docs[index].get('Email'));
            }))
        : Container(color: Colors.grey);
    //     color: Colors.white,

    //     child: Text("Fucker"),
    //   );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black87,
        // ignore: prefer_const_constructors
        title: Text(
          "Connect",
          style: TextStyle(color: Colors.grey),
        ),
      ),
      body: SearchList(), //Container(
      //   child: Column(
      //     children: [SearchList(),
      //       Container(
      //         color: Colors.grey,
      //         padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      //         child: Row(
      //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //           // ignore: prefer_const_literals_to_create_immutables
      //           children: [
      //             Expanded(
      //                 child: TextField(
      //               controller: searchText,
      //               cursorColor: Colors.black,
      //               decoration: InputDecoration(
      //                   border: InputBorder.none,
      //                   hintText: "Enter the username..",
      //                   hintStyle: TextStyle(color: Colors.white)),
      //             )),
      //             IconButton(
      //                 onPressed: () {
      //                   initiateSearch();
      //                 },
      //                 icon: Icon(
      //                   Icons.search,
      //                   color: Colors.white,
      //                 ))
      //           ],
      //         ),
      //       ),
      //       SearchList(),
      //     ],
      //   ),
    );
  }
}

class SearchTile extends StatelessWidget {
  final String userNAme;
  final String userEmail;
  SearchTile({required this.userNAme, required this.userEmail});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Column(
            children: [
              Text(userNAme),
              Text(userEmail),
            ],
          ),
          Spacer(),
          ElevatedButton(
            child: Text("Message".toUpperCase(),
                style: TextStyle(fontSize: 14, color: Colors.white)),
            style: ButtonStyle(
                elevation: MaterialStateProperty.all<double>(20),
                shadowColor: MaterialStateProperty.all<Color>(Colors.black),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(color: Colors.white)))),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
