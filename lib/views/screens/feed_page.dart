// import 'package:flutter/material.dart';
// import 'package:instagram_aa/views/screens/profile_page.dart';
// import 'package:instagram_aa/views/widgets/custom_widgets.dart';

// class FeedPage extends StatefulWidget {
//   const FeedPage({super.key});

//   @override
//   State<FeedPage> createState() => _FeedPageState();
// }

// class _FeedPageState extends State<FeedPage> {
//   // var firebaseService = FirebaseServices();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         // extendBodyBehindAppBar: true,
//         appBar: AppBar(
//           backgroundColor: Colors.transparent,
//           centerTitle: true,
//           title: const Text(
//             'Green Ghana',
//             style: TextStyle(color: Colors.black54, fontSize: 15),
//           ),
//           elevation: 0,
//           actions: [
//             IconButton(
//               onPressed: () {},
//               icon: const Icon(
//                 Icons.search,
//                 color: Colors.black54,
//                 size: 27,
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.only(left: 20, right: 20),
//               child: GestureDetector(
//                 onTap: () {
//                   nextNav(context, ProfilePage());
//                 },
//                 child: const CircleAvatar(
//                   backgroundColor: Colors.white,
//                   radius: 16,
//                   child:
//                       Image(image: AssetImage('assets/images/profilepic1.jpg')),
//                 ),
//               ),
//             ),
//           ],
//         ),
//         body: ListView()
//         // StreamBuilder(
//         //   stream: firebaseService.getVideos(),
//         //   builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//         //     if (snapshot.connectionState == ConnectionState.waiting) {
//         //       return const Center(
//         //           child: SizedBox(
//         //         height: 50,
//         //         width: 50,
//         //         child: CircularProgressIndicator(
//         //           color: Colors.green,
//         //         ),
//         //       ));
//         //     }

//         //     logger.d(snapshot.data!.docs.length);

//         //     return ListView(
//         //         padding: const EdgeInsets.all(10),
//         //         children: snapshot.data!.docs.map((DocumentSnapshot doc) {
//         //           Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;

//         //           final videoPlayerController = VideoPlayerController.network(
//         //             data['videoUrl'],
//         //           );

//         //           final chewieController = ChewieController(
//         //             aspectRatio: 16 / 9,
//         //             videoPlayerController: videoPlayerController,
//         //             autoPlay: false,
//         //             looping: false,
//         //           );

//         //           final playerWidget = Chewie(
//         //             controller: chewieController,
//         //           );



//         //           return Container(
//         //             padding: EdgeInsets.all(8),
//         //             child: Column(
//         //               crossAxisAlignment: CrossAxisAlignment.start,
//         //               children: [
//         //                 Row(
//         //                   children:const [
//         //                     CircleAvatar(
//         //                       backgroundImage: NetworkImage('https://afrogistmedia.com/wp-content/uploads/2021/06/Featured.jpg'),
//         //                     ),
//         //                     Text('Sankwan'),
//         //                   ],
//         //                 ),
//         //                 Container(
//         //                   height: 450,
//         //                   width: double.infinity,
//         //                   child: data['videoUrl'] == ''
//         //                       ? const Image(
//         //                           image: NetworkImage(
//         //                             'https://afrogistmedia.com/wp-content/uploads/2021/06/Featured.jpg',
//         //                           ),
//         //                           // fit: BoxFit.fill,
//         //                         )
//         //                       : InstaVideoPlayer(
//         //                           videoUrl:
//         //                               data['https://youtu.be/vSFgg0D2nYA']),
//         //                 ),
//         //                 Row(
//         //                   children: [
//         //                     IconButton(
//         //                       onPressed: () {
//         //                       },
//         //                       icon: data['likes']
//         //                           ? Icon(Icons.favorite)
//         //                           : Icon(FontAwesomeIcons.heart),
//         //                       color: data['likes']
//         //                           ? Colors.red
//         //                           : Colors.black,
//         //                     ),
//         //                     IconButton(
//         //                         onPressed: () {
//         //                           try {
//         //                             showModalBottomSheet(
//         //                               // shape: const RoundedRectangleBorder(
//         //                               //     borderRadius: BorderRadius.vertical(
//         //                               //         top: Radius.circular(20))),
//         //                               // enableDrag: true,
//         //                               // isScrollControlled: true,
//         //                               context: context,
//         //                               builder: (context) {
//         //                                 return Padding(
//         //                                   padding: EdgeInsets.only(
//         //                                       top: 10,
//         //                                       bottom: MediaQuery.of(context)
//         //                                           .viewInsets
//         //                                           .bottom),
//         //                                   child: Container(
//         //                                       height: MediaQuery.of(context)
//         //                                               .size
//         //                                               .height *
//         //                                           0.5,
//         //                                       child: Container(height: 150,)
//         //                                           // CommentScreen(id: data['id'])
//         //                                           ),
//         //                                 );
//         //                               },
//         //                             );
//         //                           } catch (error) {
//         //                             logger.d(error);
//         //                           }
//         //                           // logger.d('Comment Btn Pressed');
//         //                         },
//         //                         icon: const Icon(FontAwesomeIcons.comment)),
//         //                     IconButton(
//         //                         onPressed: () {},
//         //                         icon: const Icon(FontAwesomeIcons.reply)),
//         //                   ],
//         //                 ),
//         //                 Text('${data['likes'].length} likes'),
//         //                 Text('${data['commentsCount']} comments'),
//         //               ],
//         //             ),
//         //           );
//         //         }).toList());
//         //   },
//         // ),
//         );
//   }
// }
