import 'package:vecino_vigilante/models/location_model.dart';
import 'package:vecino_vigilante/models/user_model.dart';

class ComplaintModel {
  String id;
  String type;
  int typeId;
  String description;
  DateTime date;
  String imageUrl;
  UserModel user;
  LocationModel location;

  ComplaintModel({
    required this.id,
    required this.type,
    required this.typeId,
    required this.description,
    required this.date,
    required this.imageUrl,
    required this.user,
    required this.location,
  });
}
