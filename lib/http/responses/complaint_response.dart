import 'dart:convert';

import 'package:vecino_vigilante/http/responses/comment_response.dart';
import 'package:vecino_vigilante/http/responses/complaint_type_response.dart';
import 'package:vecino_vigilante/http/responses/location_response.dart';
import 'package:vecino_vigilante/http/responses/user_response.dart';

ComplaintResponse complaintResponseFromJson(String str) =>
    ComplaintResponse.fromJson(json.decode(str));

String complaintResponseToJson(ComplaintResponse data) =>
    json.encode(data.toJson());

class ComplaintResponse {
  String? id;
  ComplaintTypeResponse? type;
  String? description;
  DateTime? date;
  String? imageUrl;
  UserResponse? user;
  LocationFromComplaintResponse? location;

  ComplaintResponse({
    this.id,
    this.type,
    this.description,
    this.date,
    this.imageUrl,
    this.user,
    this.location,
  });

  factory ComplaintResponse.fromJson(Map<String, dynamic> json) =>
      ComplaintResponse(
        id: json["id"],
        type: json["type"] == null
            ? null
            : ComplaintTypeResponse.fromJson(json["type"]),
        description: json["description"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        imageUrl: json["image_url"],
        user: json["user"] == null ? null : UserResponse.fromJson(json["user"]),
        location: json["location"] == null
            ? null
            : LocationFromComplaintResponse.fromJson(json["location"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type?.toJson(),
        "description": description,
        "date": date?.toIso8601String(),
        "image_url": imageUrl,
        "user": user?.toJson(),
        "location": location?.toJson(),
      };
}

ComplaintWithCommentsResponse complaintWithCommentsResponseFromJson(
  String str,
) =>
    ComplaintWithCommentsResponse.fromJson(json.decode(str));

String complaintWithCommentsResponseToJson(
        ComplaintWithCommentsResponse data) =>
    json.encode(data.toJson());

class ComplaintWithCommentsResponse extends ComplaintResponse {
  List<CommentResponse>? comments;

  ComplaintWithCommentsResponse({
    this.comments,
    super.id,
    super.type,
    super.description,
    super.date,
    super.imageUrl,
    super.user,
    super.location,
  });

  factory ComplaintWithCommentsResponse.fromJson(Map<String, dynamic> json) =>
      ComplaintWithCommentsResponse(
        id: json["id"],
        type: json["type"] == null
            ? null
            : ComplaintTypeResponse.fromJson(json["type"]),
        description: json["description"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        imageUrl: json["image_url"],
        user: json["user"] == null ? null : UserResponse.fromJson(json["user"]),
        location: json["location"] == null
            ? null
            : LocationFromComplaintResponse.fromJson(json["location"]),
        comments: json["comments"] == null
            ? []
            : List<CommentResponse>.from(
                json["comments"]!.map((x) => CommentResponse.fromJson(x))),
      );

  @override
  Map<String, dynamic> toJson() => super.toJson()
    ..addAll({
      "comments": comments == null
          ? []
          : List<dynamic>.from(comments!.map((x) => x.toJson())),
    });
}
