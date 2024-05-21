import 'package:vecino_vigilante/dto/complaint_dto.dart';
import 'package:vecino_vigilante/http/responses/complaint_response.dart';
import 'package:vecino_vigilante/mappers/comment_mapper.dart';
import 'package:vecino_vigilante/mappers/complaint_type_mapper.dart';
import 'package:vecino_vigilante/mappers/location_mapper.dart';
import 'package:vecino_vigilante/mappers/user_mapper.dart';

class ComplaintMapper {
  static ComplaintDTO toDTO(ComplaintResponse response) {
    return ComplaintDTO(
      id: response.id,
      type: response.type != null
          ? ComplaintTypeMapper.toDTO(response.type!)
          : null,
      description: response.description,
      date: response.date,
      imageUrl: response.imageUrl,
      user: response.user != null ? UserMapper.toDTO(response.user!) : null,
      location: response.location != null
          ? LocationMapper.toDTO(response.location!)
          : null,
    );
  }

  static ComplaintWithCommentsDTO toComplaintWithCommentsDTO(
      ComplaintWithCommentsResponse response) {
    return ComplaintWithCommentsDTO(
      id: response.id,
      type: response.type != null
          ? ComplaintTypeMapper.toDTO(response.type!)
          : null,
      description: response.description,
      date: response.date,
      imageUrl: response.imageUrl,
      user: response.user != null ? UserMapper.toDTO(response.user!) : null,
      location: response.location != null
          ? LocationMapper.toDTO(response.location!)
          : null,
      comments: response.comments
          ?.map((comment) => CommentMapper.toDTO(comment))
          .toList(),
    );
  }
}
