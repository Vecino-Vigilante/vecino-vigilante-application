import 'package:vecino_vigilante/http/responses/get_all_complaints_response.dart';
import 'package:vecino_vigilante/mappers/marker_mappers.dart';
import 'package:vecino_vigilante/mappers/user_mappers.dart';
import 'package:vecino_vigilante/models/complaint_model.dart';

ComplaintModel mapComplaintDTOToComplaintModel(ComplaintDTO complaintDTO) {
  return ComplaintModel(
    id: complaintDTO.id,
    type: complaintDTO.type,
    typeId: complaintDTO.typeId,
    description: complaintDTO.description,
    date: complaintDTO.date,
    imageUrl: complaintDTO.imageUrl,
    user: mapUserDTOToUserModel(complaintDTO.user),
    location: mapLocationDTOToLocationModel(complaintDTO.location),
  );
}
