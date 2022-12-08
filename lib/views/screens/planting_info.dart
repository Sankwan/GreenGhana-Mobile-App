import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:instagram_aa/views/screens/full_plant_info.dart';
import 'package:instagram_aa/views/widgets/carousel.dart';
import 'package:instagram_aa/views/widgets/custom_widgets.dart';
import 'package:logger/logger.dart';

class PlantingInfo extends StatefulWidget {
  const PlantingInfo({Key? key}) : super(key: key);

  @override
  State<PlantingInfo> createState() => _PlantingInfoState();
}

class _PlantingInfoState extends State<PlantingInfo> {
  List seedlingInfo = [];

  var dio = Dio();

  getItems() async {
    var response = await dio.get('https://fakestoreapi.com/products');
    var data = response.data;
    setState(() {
      seedlingInfo = data;
    });
    logger.d(seedlingInfo);
  }

  @override
  void initState() {
    getItems();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'How to Plant Seedlings',
            style: TextStyle(fontSize: 15),
          ),
          centerTitle: true,
        ),
        body:
            // Container(),
            seedlingInfo.length == 0
                ? const Center(
                    child: SizedBox(
                      height: 50,
                      width: 50,
                      child: CircularProgressIndicator(),
                    ),
                  )
                : Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text('Popular Seedlings'),
                      SizedBox(
                        height: 200,
                        child: const Carousel(),
                      ),
                      
                      // const SizedBox(
                      //   height: 30,
                      // ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: seedlingInfo.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            seedlingInfo[index]['image']))),
                              ),
                              title: Text(
                                seedlingInfo[index]['title'],
                                overflow: TextOverflow.ellipsis,
                              ),
                              subtitle: Text(
                                seedlingInfo[index]['description'],
                                overflow: TextOverflow.ellipsis,
                              ),
                              onTap: () {
                                nextNav(
                                  context,
                                  FullPlantingInfo(
                                    image: seedlingInfo[index]['image'],
                                    description: seedlingInfo[index]['description'],
                                    title: seedlingInfo[index]['title'],
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      )
                    ],
                  ));
  }
}
