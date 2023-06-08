// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:instagram_aa/views/screens/profile_page.dart';
// import 'package:instagram_aa/views/widgets/custom_widgets.dart';
// import 'package:instagram_aa/views/widgets/postwidgets/custom_circle_avatar.dart';

// class SearchWidget extends SearchDelegate {
//   final CollectionReference _firebaseFirestore =
//       FirebaseFirestore.instance.collection('users');

//   @override
//   List<Widget>? buildActions(BuildContext context) {
//     // TODO: implement buildActions
//     // throw UnimplementedError();
//     return <Widget>[
//       IconButton(
//         onPressed: () {
//           query = '';
//         },
//         icon: const Icon(Icons.close),
//       ),
//     ];
//   }

//   @override
//   Widget? buildLeading(BuildContext context) {
//     // TODO: implement buildLeading
//     // throw UnimplementedError();
//     return IconButton(
//       onPressed: () {
//         Navigator.of(context).pop();
//       },
//       icon: const Icon(Icons.arrow_back),
//     );
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//     // TODO: implement buildResults
//     // throw UnimplementedError();
//     return StreamBuilder<QuerySnapshot>(
//         stream: _firebaseFirestore.snapshots().asBroadcastStream(),
//         builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (!snapshot.hasData) {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           } else {
//             if (snapshot.data!.docs
//                 .where((QueryDocumentSnapshot<Object?> element) =>
//                     element['user_name']
//                         .toString()
//                         .toLowerCase()
//                         .contains(query.toLowerCase()))
//                 .isEmpty) {
//               return const Center(
//                 child: Text('No such user found'),
//               );
//             } else {
//               // fetch data here
//               if (query.isEmpty) {
//                 return const Center(
//                   child: Text('No Username has been entered'),
//                 );
//               } else {
//                 return ListView(
//                   children: [
//                     ...snapshot.data!.docs
//                         .where((QueryDocumentSnapshot<Object?> element) =>
//                             element['user_name']
//                                 .toString()
//                                 .toLowerCase()
//                                 .contains(query.toLowerCase()))
//                         .map((QueryDocumentSnapshot<Object?> data) {
//                       final String userName = data.get('user_name');
//                       final String avatar = data.get('avatar');
//                       final String id = data.get('user_id');

// return ListTile(
//   onTap: () {
//     nextNav(context, ProfilePage(id: id));
//   },
//   title: Text(userName),
//   leading: CustomCircleAvatar(avatar: avatar),
// );
//                     })
//                   ],
//                 );
//               }
//             }
//           }
//         }
//         );
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     // TODO: implement buildSuggestions
//     // throw UnimplementedError();
//     return const Center(
//       child: Text('Search users here'),
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_aa/views/widgets/postwidgets/custom_circle_avatar.dart';

import '../screens/profile_page.dart';
import 'custom_widgets.dart';

class SearchPageWidget extends StatefulWidget {
  const SearchPageWidget({super.key});

  @override
  State<SearchPageWidget> createState() => _SearchPageWidgetState();
}

class _SearchPageWidgetState extends State<SearchPageWidget> {
  String name = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: TextField(
          autofocus: true,
          textInputAction: TextInputAction.search,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Search users...",
          ),
          onChanged: (value) {
            setState(() {
              name = value;
            });
          },
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshots) {
          return (snapshots.connectionState == ConnectionState.waiting)
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  controller: ScrollController(),
                  itemCount: snapshots.data!.docs.length,
                  itemBuilder: (context, index) {
                    var data = snapshots.data!.docs[index].data()
                        as Map<String, dynamic>;
                    String username = data["user_name"];
                    String userId = data["user_id"];
                    String userAvatar = data["avatar"];
                    if (name.isEmpty) {
                      return ListTile(
                        onTap: (){
                          nextNav(context, ProfilePage(id: userId));
                        },
                        title: Text("$username "),
                        leading: CustomCircleAvatar(avatar: userAvatar),
                      );
                    }
                    if (data['user_name']
                            .toString()
                            .startsWith(name.toLowerCase()) ||
                        data['user_name']
                            .toString()
                            .startsWith(name.toUpperCase())) {
                      String username = data["user_name"];
                      String userId = data["user_id"];
                      String userAvatar = data["avatar"];
                      return ListTile(
                        onTap: (){
                          nextNav(context, ProfilePage(id: userId));
                        },
                        title: Text("$username "),
                        leading: CustomCircleAvatar(avatar: userAvatar),
                      );
                    }
                    return Container();
                  },
                );
        },
      ),
    );
  }
}
