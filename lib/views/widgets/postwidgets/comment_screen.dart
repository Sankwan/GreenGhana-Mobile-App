import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_aa/controllers/user_controller.dart';
import 'package:instagram_aa/models/usermodel.dart';
import 'package:instagram_aa/services/firebase_service.dart';
import 'package:instagram_aa/utils/custom_theme.dart';
import 'package:instagram_aa/views/widgets/custom_widgets.dart';
import 'package:instagram_aa/views/widgets/postwidgets/custom_circle_avatar.dart';
import 'package:instagram_aa/views/widgets/requestwidgets/form_input_builder.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../models/comment.dart';

class Comments extends StatefulWidget {
  final String id;
  final Function()? updateComment;
  const Comments({
    super.key,
    required this.id,
    this.updateComment,
  });

  @override
  State<Comments> createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  TextEditingController comment = TextEditingController();
  var user = UserControllerImplement();
  DateTime date = DateTime.now();
  List<Comment> commentList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // var user = context.watch<UserProvider>().usermodel;
    var comments =
        FirebaseFirestore.instance.collection('posts').doc(widget.id).get();
    final size = MediaQuery.of(context).size;
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    return ListView(children: [
      Column(
        children: [
          Text('Comments'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Divider(),
          ),
          FutureBuilder<DocumentSnapshot>(
            future: comments,
            builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.33,
                    child: const Center(child: CircularProgressIndicator()));
              }
              if (snapshot.data == null) {
                return const Text('No Comments');
              }
              Map<String, dynamic> data =
                  snapshot.data!.data() as Map<String, dynamic>;
              if (data['comments'] == null || data['comments'].isEmpty) {
                return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.33,
                    child: const Center(child: Text('No Comments')));
              }
              List commentData = data['comments']
                  .where((element) => element["user_id"] != null)
                  .toList();
              commentList =
                  commentData.map<Comment>((e) => Comment.fromSnap(e)).toList();
              // logger.d(data['comments'][0]);
              return SingleChildScrollView(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.33,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: commentList.length,
                      itemBuilder: (context, index) {
                        Comment commentData = commentList[index];
                        //     Comment.fromSnap(data['comments'][index]);
                        // var userData;
                        return FutureBuilder(
                          future: user.getUserDataAsync(commentData.user_id),
                          builder:
                              (context, AsyncSnapshot<UserModel> snapshot) {
                            if (!snapshot.hasData) {
                              return Container();
                            }
                            // var data = snapshot.data
                            return ListTile(
                              leading: CustomCircleAvatar(
                                  avatar: snapshot.data!.avatar!),
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    snapshot.data!.userName!,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    commentData.comment,
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ],
                              ),
                              subtitle: Text(
                                timeago.format(commentData.createdAt!.toDate()),
                                style: subtitlestlye.copyWith(
                                    fontSize: 12,
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    fontWeight: FontWeight.w400),
                              ),
                              // trailing: IconButton(onPressed: (){}, icon: Icon(Icons.favorite), iconSize: 16,),
                            );
                          },
                        );
                      }),
                ),
              );
            },
          ),
          const Divider(
            thickness: 2,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: ListTile(
              //add comment avatar not completed
              // leading: CustomCircleAvatar(avatar: '',),
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
                    commentList.add(Comment(
                      comment: comment.text,
                      user_id: mAuth.currentUser!.uid,
                      createdAt: Timestamp.fromDate(DateTime.now()),
                    ));
                    // setState(() {});
                    widget.updateComment!();
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
