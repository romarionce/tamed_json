import 'dart:convert';
import 'model_json_factory.dart';
import 'product_model.dart';

dynamic deco(Object? data) {
  return jsonDecode(jsonEncode(data));
}

void main() {
  final startModels = [
    ProductModel(price: 12, title: 'Phone'),
    ProductModel(price: 2.1, title: 'Table'),
  ];

  final modelFactory = ProductModelJsonFactory();
  final List jsonModel = deco(
    startModels.map(modelFactory.toJSON).toList(),
  );
  print(jsonModel);

  final model = jsonModel.map((e) => modelFactory.fromJSON(e)).toList();

  print(model);
}
