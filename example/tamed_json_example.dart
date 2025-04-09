import 'dart:convert';
import 'model_json_factory.dart';
import 'product_model.dart';

dynamic decode(Object? data) {
  return jsonDecode(jsonEncode(data));
}

void main() {
  final startModels = [
    ProductModel(price: 12, title: 'Phone'),
    ProductModel(price: 2.1, title: 'Table'),
  ];

  const modelFactory = ProductModelJsonFactory();
  final List jsonModel = decode(
    startModels.map(modelFactory.toJson).toList(),
  );

  print(jsonModel);

  //TODO
}
