abstract interface class JsonRequestDTO {
  dynamic get toJson;
}

abstract interface class JsonResponseDTO {
  dynamic get fromJson;
}
