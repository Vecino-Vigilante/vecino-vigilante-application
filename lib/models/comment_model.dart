import 'package:vecino_vigilante/models/user_model.dart';

class CommentModel {
  String id;
  String incidentId;
  String content;
  DateTime date;
  String imageUrl;
  UserModel user;

  CommentModel({
    required this.id,
    required this.incidentId,
    required this.content,
    required this.date,
    required this.imageUrl,
    required this.user,
  });
}
