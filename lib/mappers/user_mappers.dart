import 'package:vecino_vigilante/http/responses/get_all_complaints_response.dart';
import 'package:vecino_vigilante/models/user_model.dart';

UserModel mapUserDTOToUserModel(UserDTO userDTO) {
  return UserModel(
    id: userDTO.id,
    name: userDTO.name,
    lastName: userDTO.lastName,
    email: userDTO.email,
    profileImage: userDTO.profileImage,
  );
}
