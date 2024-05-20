import 'package:dio/dio.dart';
import 'package:vecino_vigilante/dto/complaint_dto.dart';
import 'package:vecino_vigilante/http/dio_client.dart';
import 'package:vecino_vigilante/http/requests/create_complaint_request.dart';
import 'package:vecino_vigilante/http/responses/complaint_response.dart';
import 'package:vecino_vigilante/mappers/complaint_mapper.dart';
import 'package:vecino_vigilante/utils/auth_utils.dart';

Future<ComplaintDTO?> createComplaint(
  CreateComplaintRequest formData,
) async {
  try {
    Response<String> response = await dioClient.post(
      "/complaints",
      data: createComplaintRequestToJson(formData),
      options: Options(
        headers: {
          "Authorization": await AuthUtils.getBearerToken(),
        },
      ),
    );

    ComplaintResponse createComplaintResponse =
        complaintResponseFromJson(response.data!);

    return ComplaintMapper.toDTO(createComplaintResponse);
  } catch (e) {
    throw Exception(
      "Oh no! An error occurred while trying to create the complaint: $e",
    );
  }
}
