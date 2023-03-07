import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:instagram_aa/controllers/firebase_services.dart';
import 'package:instagram_aa/models/posts_model.dart';
import 'package:instagram_aa/services/firebase_service.dart';
import 'package:instagram_aa/views/widgets/postwidgets/post_item_card.dart';

class SinglePost extends StatefulWidget {
  final PostsModel post;
  const SinglePost({super.key, required this.post});

  @override
  State<SinglePost> createState() => _SinglePostState();
}

class _SinglePostState extends State<SinglePost> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          widget.post.userId == mAuth.currentUser!.uid
              ? IconButton(
                  onPressed: () {
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) => AlertDialog(
                        actionsAlignment: MainAxisAlignment.center,
                        icon: Icon(
                          CupertinoIcons.exclamationmark_triangle,
                          size: 70,
                          color: Colors.orangeAccent,
                        ),
                        content: Text(
                          'This cannot be undone.\n Do you want to delete this post?',
                          textAlign: TextAlign.center,
                        ),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('No')),
                          ElevatedButton(
                              onPressed: () {
                                firebaseFireStore
                                    .collection('posts')
                                    .doc(widget.post.postId)
                                    .delete()
                                    .then((value) {
                                  Navigator.pop(context);
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      actionsAlignment:
                                          MainAxisAlignment.center,
                                      content: Text(
                                        'Post Deleted',
                                        textAlign: TextAlign.center,
                                      ),
                                      actions: [
                                        ElevatedButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                              Navigator.pop(context);
                                              setState(() {});
                                            },
                                            child: Text('Done'))
                                      ],
                                    ),
                                  );
                                });
                              },
                              child: Text('Yes'))
                        ],
                      ),
                    );
                  },
                  icon: Icon(
                    CupertinoIcons.delete,
                    color: Colors.red,
                  ))
              : Container()
        ],
      ),
      body: ListView(
        children: [
          PostItemCard(post: widget.post, onPress: () {}),
        ],
      ),
    );
  }
}
