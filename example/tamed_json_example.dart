import 'dart:convert';
import 'package:tamed_json/tamed_json.dart';

/// lib/feature/product/data/model/product_model.dart
class ProductModel {
  const ProductModel({
    required this.price,
    required this.title,
  });

  final double price;
  final String title;

  @override
  String toString() => 'ProductModel(price: $price, title: $title)';
}

/// lib/feature/product/boundary/product_model_json_factory.dart
class ProductModelJsonFactory implements JsonFactory<ProductModel> {
  const ProductModelJsonFactory();

  @override
  ProductModel fromJson(JsonMap json) {
    return ProductModel(
      price: json.double('price'),
      title: json.string('title'),
    );
  }

  @override
  JsonMap toJson(ProductModel model) {
    return {
      'price': model.price,
      'title': model.title,
    };
  }
}

void main() {
  final data = '''{
      "phones":[{"price":12,"title":"Phone1"},{"price":2.1,"title":"Phone2"}, {"invalid_key": "invalid_value"}],
      "computers":[{"price":20,"title":"PC1"},{"price":3.1,"title":"PC2"}]
      }''';
  final JsonMap json = jsonDecode(data);

  /// OPTION 1
  final List<ProductModel> phones = json.factoryList(
    const ProductModelJsonFactory(),
    key: 'phones',
    throws: false, // default: false. if true, throws exception on invalid data
  );

  /// OPTION 2
  final List<ProductModel> pcs = json
      .list('computers')
      .map((e) => const ProductModelJsonFactory().fromJson(e))
      .toList();

  print('phones:\t$phones');
  print('pcs:\t$pcs');
}
