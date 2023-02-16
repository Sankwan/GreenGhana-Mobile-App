import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:instagram_aa/controllers/post_controller.dart';
import 'package:instagram_aa/views/widgets/custom_widgets.dart';

import '../../models/posts_model.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  Position? currentLoc;
  final post = PostControllerImplement();

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    currentLoc = await Geolocator.getCurrentPosition();
    setState(() {});
    logger.d(currentLoc);
    return currentLoc!;
  }

  @override
  void initState() {
    _determinePosition();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentLoc == null
          ? const Center(
              child: SizedBox(
                  height: 50, width: 50, child: CircularProgressIndicator()),
            )
          : StreamBuilder<List<PostsModel>>(
            stream: post.loadPosts(), 
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return Container();
              }
              if (snapshot.data!.isEmpty) {
                return Container();
              }
                var data = snapshot.data!;
                logger.d(data[0].longitude);
              Set<Marker> markers = Set<Marker>.from(data.map((e) {
                return Marker(
                    markerId: MarkerId('MarkerId'),
                    position: LatLng(e.latitude!, e.longitude!),
                    infoWindow: InfoWindow(
                        title: 'Destination',
                        snippet: 'Mr man planted here'),
                    // icon: await BitmapDescriptor.fromAssetImage(
                    //     ImageConfiguration(
                    //         size: Size(1, 1), devicePixelRatio: 0.5),
                    //     'assets/images/p-marker.png'),
                  );

              }));
              return GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: CameraPosition(
                  target:
                      LatLng(currentLoc!.latitude, currentLoc!.longitude),
                  zoom: 15,
                ),
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                markers: markers,
              );
            },
          ),
    );
  }
}
