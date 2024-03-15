import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:instagram_aa/controllers/post_controller.dart';
import 'package:instagram_aa/utils/app_utils.dart';
import 'package:instagram_aa/views/widgets/custom_widgets.dart';
import 'package:instagram_aa/views/widgets/custom_widgets/timeout_widget.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../models/posts_model.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  Position? currentLoc;
  String errorMessage = '';
  bool showErrorDialog = true;
  final post = PostControllerImplement();

  Future _determinePosition() async {
    logger.d("Getting position");
    setState(() {
      errorMessage = '';
    });
    bool serviceEnabled;
    LocationPermission permission;

    try {
      // Test if location services are enabled.
      serviceEnabled = await Geolocator.isLocationServiceEnabled();

      if (!serviceEnabled) {
        throw Exception('Location services are disabled.');
      }

      permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        logger.wtf(permission);
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception('Location permissions are denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        var openAppSettings = await Geolocator.openLocationSettings();
        if (openAppSettings) {
        } else {
          throw Exception(
              'Location permissions are permanently denied, we cannot request permissions.');
        }
      }

      errorMessage = '';
      currentLoc = await Geolocator.getCurrentPosition();
      setState(() {});
      // return currentLoc!;
    } catch (e) {
      errorMessage = e.toString();
      setState(() {});
    }
  }

  @override
  void initState() {
    _determinePosition();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentLoc == null && errorMessage.isEmpty
          ? Center(
              // child: Padding(
              //   padding: const EdgeInsets.all(12),
              //   child: Column(
              //     mainAxisSize: MainAxisSize.min,
              //     children: [
              //       Text(errorMessage),
              //       SizedBox(
              //         height: 20,
              //       ),
              //       ElevatedButton(
              //           onPressed: () async {
              //             await Geolocator.openAppSettings();
              //             _determinePosition();
              //           },
              //           child: Text("Try Again"))
              //     ],
              //   ),
              // ),
              child: CircularProgressIndicator(),
            )
          : errorMessage.isNotEmpty
              ? TimeoutWidget(
                  message: errorMessage,
                  callBack: _determinePosition,
                )
              // ? FutureBuilder(
              //     future: Future.delayed(Duration.zero),
              //     builder: (context, snapshot) {
              //       SchedulerBinding.instance.addPersistentFrameCallback(
              //         (_) {
              //           showDialog(
              //             context: context,
              //             builder: (context) {
              //               return AlertDialog(
              //                 title: Text(errorMessage),
              //                 actions: [
              //                   ElevatedButton(
              //                       onPressed: _determinePosition,
              //                       child: Text("Try again"))
              //                 ],
              //               );
              //             },
              //           );
              //         },
              //       );
              //       return Container();
              //     },
              //   )
              : FutureBuilder<List<PostsModel>>(
                  future: post.loadPosts(),
                  builder: (context, snapshot) {
                    if (snapshot.data == null) {
                      return Container();
                    }
                    if (snapshot.data!.isEmpty) {
                      return Container();
                    }
                    var data = snapshot.data!;
                    Set<Marker> markers = Set<Marker>.from(data.map((e) {
                      return Marker(
                        markerId: MarkerId('MarkerId'),
                        position: LatLng(e.latitude!, e.longitude!),
                        infoWindow: InfoWindow(
                            title: 'Green Ghana Day',
                            snippet: 'Seedlings were distributed here'),
                        // icon: await BitmapDescriptor.fromAssetImage(
                        //     ImageConfiguration(
                        //         size: Size(1, 1), devicePixelRatio: 0.5),
                        //     'assets/images/p-marker.png'),
                      );
                    }));
                    return GoogleMap(
                      padding: EdgeInsets.only(top: 20),
                      mapType: MapType.normal,
                      initialCameraPosition: CameraPosition(
                        target:
                            LatLng(currentLoc!.latitude, currentLoc!.longitude),
                        zoom: 10,
                      ),
                      onMapCreated: (GoogleMapController controller) {
                        _controller.complete(controller);
                      },
                      myLocationEnabled: true,
                      myLocationButtonEnabled: true,
                      zoomControlsEnabled: false,
                      markers: markers,
                    );
                  },
                ),
    );
  }
}
