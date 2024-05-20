import 'package:dio/dio.dart';
import 'package:vecino_vigilante/dto/comment_dto.dart';
import 'package:vecino_vigilante/http/dio_client.dart';
import 'package:vecino_vigilante/http/requests/create_comment_request.dart';
import 'package:vecino_vigilante/http/responses/comment_response.dart';
import 'package:vecino_vigilante/mappers/comment_mapper.dart';
import 'package:vecino_vigilante/utils/auth_utils.dart';

Future<CommentDTO?> createComment(
  CreateCommentRequest comment,
) async {
  try {
    Response<String> response = await dioClient.post(
      "/comments",
      data: createCommentRequestToJson(comment),
      options: Options(
        headers: {
          "Authorization": await AuthUtils.getBearerToken(),
        },
      ),
    );

    CommentResponse createCommentResponse =
        commentResponseFromJson(response.data!);

    return CommentMapper.toDTO(createCommentResponse);
  } catch (e) {
    throw Exception(
      "Oh no! An error occurred while trying to create the comment: $e",
    );
  }
}
