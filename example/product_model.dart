// ignore_for_file: public_member_api_docs, sort_constructors_first
abstract interface class Product {
  String get title;
  double get price;
}

class ProductModel implements Product {
  const ProductModel({
    required this.price,
    required this.title,
  });

  @override
  final double price;

  @override
  final String title;

  @override
  String toString() => 'ProductModel(price: $price, title: $title)';
}
