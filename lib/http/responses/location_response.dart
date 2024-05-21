class LocationFromComplaintResponse {
  String? id;
  String? incidentId;
  double? latitude;
  double? longitude;
  String? direction;

  LocationFromComplaintResponse({
    required this.id,
    required this.incidentId,
    required this.latitude,
    required this.longitude,
    required this.direction,
  });

  factory LocationFromComplaintResponse.fromJson(Map<String, dynamic> json) =>
      LocationFromComplaintResponse(
        id: json["id"],
        incidentId: json["incident_id"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        direction: json["direction"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "incident_id": incidentId,
        "latitude": latitude,
        "longitude": longitude,
        "direction": direction,
      };
}
