import 'package:dio/dio.dart';
import 'package:vecino_vigilante/http/dio_client.dart';
import 'package:vecino_vigilante/http/responses/get_complaint_by_id_response.dart';
import 'package:vecino_vigilante/mappers/complaint_mappers.dart';
import 'package:vecino_vigilante/models/complaint_model.dart';

Future<ComplaintModel> getComplaintById(String complaintId) async {
  try {
    Response<String> response = await dioClient.get("/complaints/$complaintId");

    return mapComplaintDTOToComplaintModel(
      getComplaintByIdResponseFromJson(response.data!),
    );
  } catch (e) {
    throw Exception(
      "Oh no! An error occurred while trying to obtain the complaint with id $complaintId: $e",
    );
  }
}
