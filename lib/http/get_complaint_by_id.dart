import 'package:dio/dio.dart';
import 'package:vecino_vigilante/dto/complaint_dto.dart';
import 'package:vecino_vigilante/http/dio_client.dart';
import 'package:vecino_vigilante/http/responses/complaint_response.dart';
import 'package:vecino_vigilante/mappers/complaint_mapper.dart';
import 'package:vecino_vigilante/utils/auth_utils.dart';

Future<ComplaintWithCommentsDTO?> getComplaintById(String complaintId) async {
  try {
    Response<String> response = await dioClient.get(
      "/complaints/$complaintId",
      options: Options(
        headers: {
          "Authorization": await AuthUtils.getBearerToken(),
        },
      ),
    );

    ComplaintWithCommentsResponse getComplaintByIdResponse =
        complaintWithCommentsResponseFromJson(response.data!);

    return ComplaintMapper.toComplaintWithCommentsDTO(getComplaintByIdResponse);
  } catch (e) {
    throw Exception(
      "Oh no! An error occurred while trying to obtain the complaint with id $complaintId: $e",
    );
  }
}
