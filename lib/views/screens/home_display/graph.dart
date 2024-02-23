import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_aa/theme/colors.dart';
import 'package:instagram_aa/views/screens/year_graph.dart';
import 'package:instagram_aa/views/widgets/seedling_chart.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:logger/logger.dart';

import '../../../animation/bottomupanimate.dart';
import '../../../utils/pagesnavigator.dart';

class Graph extends StatefulWidget {
  const Graph({super.key});

  @override
  State<Graph> createState() => _GraphState();
}

class _GraphState extends State<Graph> {
  //added an internet checker to check for internet connections.
  //Works allover the app not only here
  late StreamSubscription subscription;
  bool isDeviceConnected = false;
  bool isAlertSet = false;
  var dio = Dio();
  var jsonRes;
  int dist = 0;
  var logger = Logger();

  @override
  void initState() {
    getConnectivity();
    getHTTP();
    super.initState();
  }

  getConnectivity() async {
    await Future.delayed(const Duration(seconds: 10));
    subscription = Connectivity().onConnectivityChanged.listen(
      (ConnectivityResult result) async {
        isDeviceConnected = await InternetConnectionChecker().hasConnection;
        if (!isDeviceConnected && isAlertSet == false) {
          showDialogBox();
          setState(() => isAlertSet = true);
        }
      },
    );
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

//trying out dio
  void getHTTP() async {
    try {
      var response =
          await dio.get('http://196.44.97.4/api/green-ghana/v1/seedlings.php');
      if (response.statusCode == 200) {
        var jsonRes = await jsonDecode(response.data);
        setState(() {
          dist = int.parse(jsonRes['masterlist'][0]['seedling_distributed']);
        });
      } else {
        print(response.statusCode);
      }
      print(response);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Seedling Statistics',
          style: TextStyle(fontSize: 15),
        ),
        centerTitle: true,
        actions: [
          TextButton(
              onPressed: () {
                getHTTP();
              },
              child: Text('Refresh', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),))
        ],
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 20,
          ),
          Text(
            'Target number of Seedlings to be planted on the \nGreen Ghana Day against the Actual Seedlings which are \nDistributed for planting.',
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () {},
                child: Text(
                  '2023',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w900,
                    fontSize: 18,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // nextNav(context, SlideAnimate(const YearGraph()));
                  nextScreen(context, BottomUpAnimate(const YearGraph()));
                },
                child: Text(
                  'Year to year',
                  style: TextStyle(fontStyle: FontStyle.italic, fontSize: 18),
                ),
              ),
              // ElevatedButton(
              //   onPressed: () {
              //     nextScreen(context, BottomUpAnimate(const Overview()));
              //   },
              //   child: Text(
              //     'Overview',
              //     style: TextStyle(fontStyle: FontStyle.italic, fontSize: 18),
              //   ),
              // )
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      'Target Seedlings',
                      style: TextStyle(fontSize: 15),
                    ),
                    Text(
                      '10,000,000',
                      // jsonList.isEmpty ? 'No Data' : jsonList.toString()
                      style: TextStyle(color: Colors.brown, fontSize: 20),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      'Distributed Seedlings',
                      style: TextStyle(fontSize: 15),
                    ),
                    Text(
                      // '0',
                      dist.toString(),
                      // ['masterlist'][0]['seedling_distributed'],
                      style: TextStyle(color: acceptedColor, fontSize: 20),
                    )
                  ],
                ),
              ),
            ],
          ),
          // SizedBox(height: 30,),
          SizedBox(
            // height: 800,
            child: Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                  ),
                  child: dist <= 0
                      ? Container()
                      : SeedlingChart(
                          target: 10000000,
                          distributed: dist,
                        )),
            ),
          ),
        ],
      ),
    );
  }
  //GRAPH page ends here

//dialogue is returned if internet connection is lost
  showDialogBox() => showCupertinoDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          actionsAlignment: MainAxisAlignment.center,
          title: const Text(
            'No Connection',
            textAlign: TextAlign.center,
          ),
          content: const Text(
            'Please check your internet connectivity',
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () async {
                Navigator.pop(context, 'Cancel');
                await Future.delayed(Duration(seconds: 10));
                setState(() => isAlertSet = false);
                isDeviceConnected =
                    await InternetConnectionChecker().hasConnection;
                if (!isDeviceConnected && isAlertSet == false) {
                  showDialogBox();
                  setState(() => isAlertSet = true);
                }
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
}
