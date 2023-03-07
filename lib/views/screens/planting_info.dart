import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:instagram_aa/controllers/firebase_services.dart';
import 'package:instagram_aa/services/firebase_service.dart';
import 'package:instagram_aa/views/screens/full_plant_info.dart';
import 'package:instagram_aa/views/widgets/custom_widgets.dart';

import '../widgets/plant_info_article.dart';

class PlantingInfo extends StatefulWidget {
  const PlantingInfo({Key? key}) : super(key: key);

  @override
  State<PlantingInfo> createState() => _PlantingInfoState();
}

class _PlantingInfoState extends State<PlantingInfo> {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  List seedlingInfo = [];
  var dio = Dio();

  getItems() async {
    //this api keeps fetching info from the clothes store into the console.
    var response = await dio.get('https://fakestoreapi.com/products');
    var data = response.data;
    setState(() {
      seedlingInfo = data;
    });
    logger.d(seedlingInfo);
  }

  _initToken() async {
    await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: false,
      criticalAlert: true,
      provisional: false,
      sound: true,
    );
  }

  @override
  void initState() {
    getItems();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _initToken();
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text(
          'How to Plant Seedlings',
          style: TextStyle(fontSize: 15),
        ),
        centerTitle: true,
        elevation: .5,
      ),
      body: GridView.builder(
        padding: EdgeInsets.only(left: 10, right: 10, top: 20),
        itemCount: 4,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 10,
            childAspectRatio: 0.60),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              nextNav(
                  context,
                  FullPlantingInfo(
                    image: images[index],
                    title: titles[index],
                    description: descriptions[index],
                  ));
            },
            child: Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        image: DecorationImage(
                            image: NetworkImage(images[index]),
                            fit: BoxFit.cover),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      titles[index],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      textAlign: TextAlign.start,
                    ),
                    //  Text(
                    //   descriptions[index],
                    //   overflow: TextOverflow.ellipsis,
                    //   maxLines: 1,
                    //   textAlign: TextAlign.start,
                    // ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
