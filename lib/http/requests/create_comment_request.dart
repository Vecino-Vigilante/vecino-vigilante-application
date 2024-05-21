import 'dart:convert';

CreateCommentRequest createCommentRequestFromJson(String str) =>
    CreateCommentRequest.fromJson(json.decode(str));

String createCommentRequestToJson(CreateCommentRequest data) =>
    json.encode(data.toJson());

class CreateCommentRequest {
  String? incidentId;
  String? userId;
  String? content;
  DateTime? date;
  String? resource;

  CreateCommentRequest({
    this.incidentId,
    this.userId,
    this.content,
    this.date,
    this.resource,
  });

  factory CreateCommentRequest.fromJson(Map<String, dynamic> json) =>
      CreateCommentRequest(
        incidentId: json["incident_id"],
        userId: json["user_id"],
        content: json["content"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        resource: json["resource"],
      );

  Map<String, dynamic> toJson() => {
        "incident_id": incidentId,
        "user_id": userId,
        "content": content,
        "date": date?.toIso8601String(),
        "resource": resource,
      };
}
