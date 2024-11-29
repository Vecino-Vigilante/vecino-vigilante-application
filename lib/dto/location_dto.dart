class LocationDTO {
  double? latitude;
  double? longitude;
  String? direction;

  LocationDTO({
    this.latitude,
    this.longitude,
    this.direction,
  });
}

class LocationFromComplaintDTO extends LocationDTO {
  String? id;
  String? incidentId;

  LocationFromComplaintDTO({
    this.id,
    this.incidentId,
    super.direction,
    super.latitude,
    super.longitude,
  });
}
