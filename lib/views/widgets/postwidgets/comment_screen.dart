import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_aa/controllers/firebase_services.dart';
import 'package:instagram_aa/controllers/user_controller.dart';
import 'package:instagram_aa/models/usermodel.dart';
import 'package:instagram_aa/provider/userprovider.dart';
import 'package:instagram_aa/services/firebase_service.dart';
import 'package:instagram_aa/utils/custom_theme.dart';
import 'package:instagram_aa/views/widgets/custom_widgets.dart';
import 'package:instagram_aa/views/widgets/requestwidgets/form_input_builder.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

class Comments extends StatefulWidget {
  final String id;
  const Comments({super.key, required this.id});

  @override
  State<Comments> createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  TextEditingController comment = TextEditingController();
  var user = UserControllerImplement();
  DateTime date = DateTime.now();
  @override
  Widget build(BuildContext context) {
    // var user = context.watch<UserProvider>().usermodel;
    var comments = FirebaseFirestore.instance
        .collection('posts')
        .doc(widget.id)
        .snapshots();
    final size = MediaQuery.of(context).size;
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    return ListView(children: [
      Column(
        children: [
          StreamBuilder<DocumentSnapshot>(
            stream: comments,
            builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.38,
                    child: const Center(child: CircularProgressIndicator()));
              }
              if (snapshot.data == null) {
                return const Text('No Comments');
              }
              Map<String, dynamic> data =
                  snapshot.data!.data() as Map<String, dynamic>;
              if (data['comments'] == null || data['comments'].isEmpty) {
                return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.38,
                    child: const Center(child: Text('No Comments')));
              }
              // logger.d(data['comments'][0]);
              return SingleChildScrollView(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.38,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: data['comments'].length,
                      itemBuilder: (context, index) {
                        var commentData = data['comments'][index];
                        var userData;
                        return FutureBuilder(
                          future: user.getUserDataAsync(commentData['user_id']),
                          builder:
                              (context, AsyncSnapshot<UserModel> snapshot) {
                            if (!snapshot.hasData) {
                              return Container();
                            }
                            // var data = snapshot.data
                            return ListTile(
                              leading: CircleAvatar(
                                backgroundImage: snapshot
                                        .data!.avatar!.isNotEmpty
                                    ? NetworkImage(snapshot.data!.avatar!)
                                    : AssetImage(
                                            'assets/images/default_image.jpg')
                                        as ImageProvider,
                              ),
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    snapshot.data!.userName!,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(commentData['comment']),
                                ],
                              ),
                              subtitle: Text(
                                timeago
                                    .format(commentData['createdAt'].toDate()),
                                style: subtitlestlye.copyWith(
                                    fontSize: 12,
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    fontWeight: FontWeight.w400),
                              ),
                            );
                          },
                        );
                        getUser() async {
                          DocumentReference commentUser = firebaseFireStore
                              .collection('users')
                              .doc(data['comments'][index]['user_id']);
                          await commentUser.get().then((value) {
                            userData = value.data() as Map<String, dynamic>;
                            return ListTile(
                              leading: CircleAvatar(
                                backgroundImage:
                                    NetworkImage(userData['avatar']),
                              ),
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    userData['user_name'],
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(commentData['comment']),
                                ],
                              ),
                              subtitle: Text(
                                timeago
                                    .format(commentData['createdAt'].toDate()),
                                style: subtitlestlye.copyWith(
                                    fontSize: 12,
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    fontWeight: FontWeight.w400),
                              ),
                            );
                          });
                        }

                        getUser();
                        return Container();
                      }),
                ),
              );
            },
          ),
          const Divider(
            thickness: 2,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: ListTile(
              title: FormInputBuilder(
                hintText: 'Add Comment',
                controller: comment,
                keyboardType: TextInputType.text,
              ),
              trailing: IconButton(
                  onPressed: () async {
                    if (comment.text == '') {
                      return;
                    }
                    List posts = [];
                    DocumentReference postRef = FirebaseFirestore.instance
                        .collection('posts')
                        .doc(widget.id);
                    await postRef.get().then((value) {
                      Map<String, dynamic> postData =
                          value.data() as Map<String, dynamic>;
                      logger.d(postData);
                      if (postData['comments'] != null) {
                        posts = [...postData['comments']];
                      }
                      posts.add({
                        'comment': comment.text,
                        'createdAt': date,
                        'user_id': mAuth.currentUser!.uid,
                        // user!.userId,
                      });
                      postRef.set({
                        'comments': posts,
                      }, SetOptions(merge: true));
                    });
                    comment.clear();
                  },
                  icon: const Icon(
                    Icons.send,
                    color: Colors.green,
                  )),
            ),
          )
        ],
      ),
    ]);
  }
}
