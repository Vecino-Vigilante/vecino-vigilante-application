class PositionModel {
  double latitude;
  double longitude;
  String? address;

  PositionModel({
    required this.latitude,
    required this.longitude,
    this.address,
  });
}
