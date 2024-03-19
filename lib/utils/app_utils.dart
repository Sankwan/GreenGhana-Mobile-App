import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:instagram_aa/views/widgets/custom_widgets.dart';
import 'package:shimmer/shimmer.dart';

class AppUtils {
  static String normalizePhoneNumber(String number) {
    if (number.isEmpty) return "";
    number = number.replaceAll("[0-9]", "");
    if (number.substring(0, 1).compareTo("0") == 0 &&
        number.substring(1, 2).compareTo("0") != 0) {
      number = number.substring(1);
    } else if (number.length < 10) {
      number = number;
    }

    if (number.startsWith("+233")) number = number.replaceFirst("+233", "");
    number = number.replaceAll("^[0]{1,4}", "");
    return number;
  }

  Future<Position?> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    // if (!serviceEnabled) {
    //   logger.d(serviceEnabled);
    //   serviceEnabled = await Geolocator.openLocationSettings();
    //   if (!serviceEnabled) {
    //     // return Future.error('Location services are disabled.');
    //     return null;
    //   }
    // }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      logger.d(permission);
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        logger.d(permission);
        // return Future.error('Location permissions are denied');
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
      logger.d(permission);
      // return Future.error('Location permissions are permanently denied,'
      //     ' we cannot request permissions.');
      return null;
    }
    Position? position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    logger.d(position);
    return position;
  }

  Shimmer feedPreload(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CircleAvatar(),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 14,
                          width: 190,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20))),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          height: 14,
                          width: 80,
                          decoration: const BoxDecoration(
                              color: Colors.black,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  color: Colors.grey.shade300,
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: double.infinity,
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CircleAvatar(),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 14,
                          width: 190,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20))),
                        ),
                        const SizedBox(height: 9),
                        Container(
                          height: 14,
                          width: 80,
                          decoration: const BoxDecoration(
                              color: Colors.black,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  color: Colors.grey.shade300,
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: double.infinity,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
