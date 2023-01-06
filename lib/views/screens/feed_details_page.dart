import 'package:flutter/material.dart';
import 'package:instagram_aa/models/video.dart';
import 'package:instagram_aa/views/widgets/cached_image.dart';

class FeedDetailsPage extends StatelessWidget {
  final Video vid;
  const FeedDetailsPage({super.key, required this.vid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEDF0F6),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 30),
              width: double.infinity,
              // height: 500.0,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25.0)),
              child: Column(
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: Icon(Icons.arrow_back),
                            iconSize: 30.0,
                            color: Colors.black,
                            onPressed: () => Navigator.pop(context),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: ListTile(
                              leading: Container(
                                width: 50.0,
                                height: 50.0,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black54,
                                          offset: Offset(0, 2),
                                          blurRadius: 6.0)
                                    ]),
                                child: const CircleAvatar(
                                  child: ClipOval(
                                    child: CustomCacheImage(
                                        imageUrl: "", radius: 0),
                                  ),
                                ),
                              ),
                              title: const Text(
                                "",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(""),
                              trailing: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.more_horiz,
                                    color: Colors.black,
                                  )),
                            ),
                          )
                        ],
                      ),

                      Container(
                        margin: const EdgeInsets.all(10.0),
                        width: double.infinity,
                        height: 400.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.0),
                          boxShadow: const [
                             BoxShadow(
                            color: Colors.black45,
                            offset: Offset(8, 5),
                            blurRadius: 8.0
                          )
                          ],
                        ),
                      
                      )


                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
