import 'package:dio/dio.dart';
import 'package:vecino_vigilante/http/dio_client.dart';
import 'package:vecino_vigilante/http/responses/get_all_complaints_response.dart';
import 'package:vecino_vigilante/mappers/complaint_mappers.dart';
import 'package:vecino_vigilante/models/complaint_model.dart';

Future<List<ComplaintModel>> getAllComplaints() async {
  try {
    Response<String> response = await dioClient.get("/complaints");

    return getAllComplaintsResponseFromJson(response.data!)
        .map((complaintDTO) => mapComplaintDTOToComplaintModel(complaintDTO))
        .toList();
  } catch (e) {
    throw Exception(
      "Oh no! An error occurred while trying to obtain the complaints: $e",
    );
  }
}
