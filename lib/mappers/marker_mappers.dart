import 'package:vecino_vigilante/http/responses/get_all_complaints_response.dart';
import 'package:vecino_vigilante/models/location_model.dart';

LocationModel mapLocationDTOToLocationModel(LocationDTO locationDTO) {
  return LocationModel(
    direction: locationDTO.direction,
    incidentId: locationDTO.incidentId,
    latitude: locationDTO.latitude,
    longitude: locationDTO.longitude,
  );
}
