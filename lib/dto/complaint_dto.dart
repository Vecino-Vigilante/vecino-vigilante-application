import 'package:vecino_vigilante/dto/comment_dto.dart';
import 'package:vecino_vigilante/dto/complaint_type_dto.dart';
import 'package:vecino_vigilante/dto/location_dto.dart';
import 'package:vecino_vigilante/dto/user_dto.dart';

class ComplaintDTO {
  String? id;
  ComplaintTypeDTO? type;
  String? description;
  DateTime? date;
  String? imageUrl;
  UserDTO? user;
  LocationFromComplaintDTO? location;

  ComplaintDTO({
    this.id,
    this.type,
    this.description,
    this.date,
    this.imageUrl,
    this.user,
    this.location,
  });
}

class ComplaintWithCommentsDTO extends ComplaintDTO {
  List<CommentDTO>? comments;

  ComplaintWithCommentsDTO({
    this.comments,
    super.id,
    super.type,
    super.description,
    super.date,
    super.imageUrl,
    super.user,
    super.location,
  });
}
