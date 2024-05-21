import 'package:vecino_vigilante/dto/user_dto.dart';

class CommentDTO {
  String? id;
  String? incidentId;
  String? content;
  DateTime? date;
  String? imageUrl;
  UserDTO? user;

  CommentDTO({
    this.id,
    this.incidentId,
    this.content,
    this.date,
    this.imageUrl,
    this.user,
  });
}
