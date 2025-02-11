import 'package:tamed_json/src/entity/json_factory.dart';
import 'package:tamed_json/src/extension/json_parse_field.dart';

import 'product_model.dart';

class ProductModelJsonFactory implements JsonFactory<ProductModel> {
  const ProductModelJsonFactory();

  @override
  fromJSON(json) {
    return ProductModel(
      price: json.double('price2', 20),
      title: json.string('title'),
    );
  }

  @override
  toJSON(ProductModel model) {
    return {
      'price': model.price,
      'title': model.title,
    };
  }
}
