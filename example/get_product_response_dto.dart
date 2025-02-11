import 'package:tamed_json/src/entity/json_factory.dart';

class GetProductResponseDTO implements JsonRequestDTO {
  GetProductResponseDTO({
    required this.username,
    required this.password,
  });

  final String username;
  final String password;

  @override
  get toJSON => {
        'username': username,
        'password': password,
      };
}
