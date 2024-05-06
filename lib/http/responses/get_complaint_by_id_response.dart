import 'dart:convert';
import 'package:vecino_vigilante/http/responses/get_all_complaints_response.dart';

ComplaintDTO getComplaintByIdResponseFromJson(String str) =>
    ComplaintDTO.fromJson(json.decode(str));

String getComplaintByIdResponseToJson(ComplaintDTO data) =>
    json.encode(data.toJson());
