import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:vecino_vigilante/dto/complaint_dto.dart';
import 'package:vecino_vigilante/http/dio_client.dart';
import 'package:vecino_vigilante/http/responses/complaint_response.dart';
import 'package:vecino_vigilante/mappers/complaint_mapper.dart';
import 'package:vecino_vigilante/utils/auth_utils.dart';

Future<List<ComplaintDTO>?> getAllComplaints() async {
  try {
    Response<String> response = await dioClient.get(
      "/complaints",
      options: Options(
        headers: {
          "Authorization": await AuthUtils.getBearerToken(),
        },
      ),
    );

    List<dynamic> jsonList = json.decode(response.data!);

    List<ComplaintResponse> getAllComplaintsResponse =
        jsonList.map((json) => ComplaintResponse.fromJson(json)).toList();

    return getAllComplaintsResponse
        .map((complaintResponse) => ComplaintMapper.toDTO(complaintResponse))
        .toList();
  } catch (e) {
    throw Exception(
      "Oh no! An error occurred while trying to obtain the complaints: $e",
    );
  }
}
