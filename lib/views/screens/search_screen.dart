// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';

// class SearchScreen extends StatefulWidget {
//   SearchScreen({super.key});

//   @override
//   State<SearchScreen> createState() => _SearchScreenState();
// }

// class _SearchScreenState extends State<SearchScreen> {
//   TextEditingController searchQuery = TextEditingController();
//   CollectionReference _searchRef =
//       FirebaseFirestore.instance.collection('users');
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         toolbarHeight: 70,
//         backgroundColor: Colors.grey.shade50,
//         foregroundColor: Colors.black,
//         elevation: 0,
//         title: TextFormField(
//           cursorColor: Colors.black,
//           style: const TextStyle(color: Colors.black),
//           onChanged: (value) {
//             setState(() {});
//           },
//           decoration: new InputDecoration(
//             filled: true,
//             fillColor: Colors.grey.shade300,
//             suffixIcon: Icon(
//               Icons.search,
//               color: Colors.grey.shade700,
//             ),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(5),
//               borderSide: BorderSide.none,
//             ),
//             contentPadding:
//                 EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
//             hintText: "Search Username",
//             hintStyle: TextStyle(color: Colors.grey),
//           ),
//         ),
//       ),
//       body: searchQuery.text.isNotEmpty
//           ? StreamBuilder<QuerySnapshot>(
//               stream: _searchRef.snapshots().asBroadcastStream(),
//               builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//                 if (!snapshot.hasData) {
//                   return const Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 } else {
//                   return ListView(
//                     children: [
//                       ...snapshot.data!.docs
//                           .where((QueryDocumentSnapshot<Object?> element) =>
//                               element['user_name']
//                                   .toString()
//                                   .toLowerCase()
//                                   .contains(searchQuery.text.toLowerCase()))
//                           .map((QueryDocumentSnapshot<Object?> data) {
//                         final name = data.get('user_name');
//                         final profilePic = data.get('avatar');

//                         return ListTile(
//                           title: Text(name),
//                         );
//                       })
//                     ],
//                   );
//                 }
//               },
//             )
//           : const Center(
//               child: Text("Search User"),
//             ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:instagram_aa/views/widgets/searchwidget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(slivers: <Widget>[
      SliverAppBar(
        floating: true,
        snap: true,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: SearchWidget(),
              );
            },
          ),
        ],
      ),
    ]));
  }
}
