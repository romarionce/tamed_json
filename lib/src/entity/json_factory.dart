import 'package:tamed_json/src/types/json.dart';

abstract interface class JsonFactory<Model> {
  const JsonFactory();

  dynamic toJson(Model model);

  Model fromJson(dynamic data);
}

abstract interface class JsonFactoryList<Model> {
  const JsonFactoryList();

  List<Model> fromJsonList(List<JsonMap> json);

  List<JsonMap> toJsonList(List<Model> models);
}
