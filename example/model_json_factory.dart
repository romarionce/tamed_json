import 'package:tamed_json/tamed_json.dart';
import 'product_model.dart';

class ProductModelJsonFactory implements JsonFactory<ProductModel> {
  const ProductModelJsonFactory();

  @override
  fromJson(data) {
    final json = data as JsonMap;
    return ProductModel(
      price: json.double('price2', 20),
      title: json.string('title'),
    );
  }

  @override
  toJson(ProductModel model) {
    return {
      'price': model.price,
      'title': model.title,
    };
  }
}
