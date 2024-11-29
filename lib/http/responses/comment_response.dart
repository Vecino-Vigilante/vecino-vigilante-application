import 'dart:convert';

import 'package:vecino_vigilante/http/responses/user_response.dart';

CommentResponse commentResponseFromJson(String str) =>
    CommentResponse.fromJson(json.decode(str));

String commentResponseToJson(CommentResponse data) =>
    json.encode(data.toJson());

class CommentResponse {
  String? id;
  String? incidentId;
  String? content;
  DateTime? date;
  String? imageUrl;
  UserResponse? user;

  CommentResponse({
    this.id,
    this.incidentId,
    this.content,
    this.date,
    this.imageUrl,
    this.user,
  });

  factory CommentResponse.fromJson(Map<String, dynamic> json) =>
      CommentResponse(
        id: json["id"],
        incidentId: json["incident_id"],
        content: json["content"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        imageUrl: json["image_url"],
        user: json["user"] == null ? null : UserResponse.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "incident_id": incidentId,
        "content": content,
        "date": date?.toIso8601String(),
        "image_url": imageUrl,
        "user": user?.toJson(),
      };
}
