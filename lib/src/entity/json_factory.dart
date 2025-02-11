import 'package:tamed_json/src/types/json.dart';

abstract interface class JsonRequestDTO {
  dynamic get toJSON;
}

abstract interface class JsonFactory<Model> {
  const JsonFactory();

  dynamic toJSON(Model model);
  Model fromJSON(JsonMap json);
}

abstract interface class JsonFactoryList<Model> {
  const JsonFactoryList();

  List<Model> fromJsonList(List<JsonMap> json);

  List<JsonMap> toJsonList(List<Model> models);
}
