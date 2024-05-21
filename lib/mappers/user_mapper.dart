import 'package:vecino_vigilante/dto/user_dto.dart';
import 'package:vecino_vigilante/http/responses/user_response.dart';

class UserMapper {
  static UserDTO toDTO(UserResponse response) {
    return UserDTO(
      id: response.id,
      name: response.name,
      lastName: response.lastName,
      email: response.email,
    );
  }
}
