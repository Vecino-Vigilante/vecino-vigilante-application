import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:vecino_vigilante/models/position.dart';

Future<PositionModel> getCurrentUserLocation() async {
  await Geolocator.requestPermission().then((value) {}).onError(
    (error, stackTrace) async {
      await Geolocator.requestPermission();
    },
  );

  Position currentPosition = await Geolocator.getCurrentPosition();

  List<Placemark> placemarks = await placemarkFromCoordinates(
    currentPosition.latitude,
    currentPosition.longitude,
  );
  Placemark? placemark = placemarks.firstOrNull;

  String address = placemark != null ? "${placemark.street}" : "";

  return PositionModel(
    latitude: currentPosition.latitude,
    longitude: currentPosition.longitude,
    address: address,
  );
}
