import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:instagram_aa/controllers/post_controller.dart';

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
    return currentLoc!;
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
      body: currentLoc == null
          ? const Center(
              child: SizedBox(
                  height: 50, width: 50, child: CircularProgressIndicator()),
            )
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
                        title: 'Green Ghana Day', snippet: 'Seedlings were distributed here'),
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
                    target: LatLng(currentLoc!.latitude, currentLoc!.longitude),
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
