import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_geocoding_api/google_geocoding_api.dart';
import 'package:vecino_vigilante/dto/location_dto.dart';

Future<LocationDTO> getCurrentUserLocation() async {
  await Geolocator.requestPermission().then((value) {}).onError(
    (error, stackTrace) async {
      await Geolocator.requestPermission();
    },
  );

  Position currentPosition = await Geolocator.getCurrentPosition();

  final api = GoogleGeocodingApi(dotenv.get("GOOGLE_MAPS_API_KEY"));

  final placeSearchByPosition = await api.reverse(
    '${currentPosition.latitude},${currentPosition.longitude}',
    language: "en",
  );

  return LocationDTO(
    latitude: currentPosition.latitude,
    longitude: currentPosition.longitude,
    direction:
        placeSearchByPosition.results.firstOrNull?.formattedAddress ?? "",
  );
}
