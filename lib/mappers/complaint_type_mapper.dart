import 'package:vecino_vigilante/dto/complaint_type_dto.dart';
import 'package:vecino_vigilante/http/responses/complaint_type_response.dart';

class ComplaintTypeMapper {
  static ComplaintTypeDTO toDTO(ComplaintTypeResponse response) {
    return ComplaintTypeDTO(
      id: response.id,
      name: response.name,
    );
  }
}
