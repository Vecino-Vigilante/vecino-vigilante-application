import 'package:vecino_vigilante/dto/comment_dto.dart';
import 'package:vecino_vigilante/http/responses/comment_response.dart';
import 'package:vecino_vigilante/mappers/user_mapper.dart';

class CommentMapper {
  static CommentDTO toDTO(CommentResponse response) {
    return CommentDTO(
      id: response.id,
      incidentId: response.incidentId,
      content: response.content,
      date: response.date,
      imageUrl: response.imageUrl,
      user: response.user != null ? UserMapper.toDTO(response.user!) : null,
    );
  }
}
