import 'package:geolocator/geolocator.dart';

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

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
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
      return Future.error('Location permissions are permanently denied,'
          ' we cannot request permissions.');
    }
    Position position = await Geolocator.getCurrentPosition();
    return position;
  }
}
