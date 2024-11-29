import 'dart:convert';

CreateComplaintRequest createComplaintRequestFromJson(String str) =>
    CreateComplaintRequest.fromJson(json.decode(str));

String createComplaintRequestToJson(CreateComplaintRequest data) =>
    json.encode(data.toJson());

class CreateComplaintRequest {
  String? typeId;
  String? userId;
  String? description;
  DateTime? date;
  Location? location;
  String? resource;

  CreateComplaintRequest({
    required this.typeId,
    required this.userId,
    required this.description,
    required this.date,
    required this.location,
    required this.resource,
  });

  factory CreateComplaintRequest.fromJson(Map<String, dynamic> json) =>
      CreateComplaintRequest(
        typeId: json["type_id"],
        userId: json["user_id"],
        description: json["description"],
        date: DateTime.parse(json["date"]),
        location: Location.fromJson(json["location"]),
        resource: json["resource"],
      );

  Map<String, dynamic> toJson() => {
        "type_id": typeId,
        "user_id": userId,
        "description": description,
        "date": date?.toIso8601String(),
        "location": location?.toJson(),
        "resource": resource,
      };
}

class Location {
  double? latitude;
  double? longitude;
  String? direction;

  Location({
    required this.latitude,
    required this.longitude,
    required this.direction,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        latitude: json["latitude"],
        longitude: json["longitude"],
        direction: json["direction"],
      );

  Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
        "direction": direction,
      };
}
