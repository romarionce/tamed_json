import 'package:tamed_json/src/entity/json_dto.dart';

class GetProductResponseDTO implements JsonRequestDTO {
  GetProductResponseDTO({
    required this.username,
    required this.password,
  });

  final String username;
  final String password;

  @override
  get toJson => {
        'username': username,
        'password': password,
      };
}
