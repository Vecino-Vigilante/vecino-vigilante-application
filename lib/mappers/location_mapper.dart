import 'package:vecino_vigilante/dto/location_dto.dart';
import 'package:vecino_vigilante/http/responses/location_response.dart';

class LocationMapper {
  static LocationFromComplaintDTO toDTO(
    LocationFromComplaintResponse response,
  ) {
    return LocationFromComplaintDTO(
      id: response.id,
      incidentId: response.incidentId,
      latitude: response.latitude,
      longitude: response.longitude,
      direction: response.direction,
    );
  }
}
