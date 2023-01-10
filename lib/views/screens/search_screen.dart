import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
   SearchScreen({super.key});
  TextEditingController searchQuery = TextEditingController();

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
            toolbarHeight: 70,
            backgroundColor: Colors.grey.shade50,
            foregroundColor: Colors.black,
            elevation: 0,
            title: TextFormField(
              cursorColor: Colors.black,
              style: TextStyle(color: Colors.black),
              decoration: new InputDecoration(
                filled: true,
                fillColor: Colors.grey.shade300,

                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.grey.shade700,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                contentPadding:
                    EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                hintText: "Search Username",
                hintStyle: TextStyle(color: Colors.grey),
              ),
              // controller: searchQuery,
              // onFieldSubmitted: (value) {
              //   searchController.searchUser(value);
              //},
            ),
          ),
    );
  }
}