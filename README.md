# tamed_json

`tamed_json` is a lightweight and extensible utility for safe and type-aware JSON parsing in Dart.

This package provides:
- 🔒 Type-safe access to JSON fields
- ✅ Default fallback (`or:`) and null-aware access
- 🚨 Custom exceptions for invalid data structures
- 🏗️ A `JsonFactory<T>` interface for converting models
- 🧩 Convenient list parsing via factory support

`tamed_json` helps turn verbose, error-prone JSON parsing into clean, declarative, and resilient code — especially useful in projects with structured API responses and multiple model classes.

---

## Getting started
Add dependency:
```bash
dart pub add tamed_json
```

## Features
✅ Type-safe access to JSON  
💡 `or:` fallback values on missing or null keys  
⚠️ Custom exceptions for invalid structures  
🏗️ Generic factory support for `fromJson` and `toJson`  
🧪 Built-in test coverage

## Usage
##### 1. Read values from JSON
```dart
import 'package:tamed_json/tamed_json.dart';

final json = {...};

final int count = json.int('count');
final String title = json.string('title');
final double price = json.double('price');
final bool inStock = json.bool('in_stock');
final JsonMap object = json.object('child');
final List list = json.list('list');
```
##### 1.1 Read nullable values
```dart
final int? count = json.intNull('count');
final String? title = json.stringNull('title');
final double? price = json.doubleNull('price');
final bool? inStock = json.boolNull('in_stock');
final JsonMap? object = json.objectNull('child');
final List? list = json.listNull('list');
```

##### 1.2 Read values with fallback
```dart
final int count = json.int('count', or: 0);
```

##### 1.3 Read values in chain
```dart
final int count = json.object('a').int('b');
final int? count = json.objectNull('a')?.int('b');
```


##### 2. Create factory
```dart
class ProductModelJsonFactory implements JsonFactory<ProductModel> {
  const ProductModelJsonFactory();

  @override
  ProductModel fromJson(JsonMap json)=>
    ProductModel(
      price: json.double('price'),
      title: json.string('title'),
    );

  @override
  JsonMap toJson(ProductModel model)=>
    {
      'price': model.price,
      'title': model.title,
    };
}
```

##### 2.1 Use factory
```dart
const productFactory = ProductModelJsonFactory();

final model = productFactory.fromJson(json);
final model = json.factory(productFactory, key: 'product');

final json = productFactory.toJson(model);
```

##### 2.2 Use factory with list
```dart
final List<ProductModel> products = json.factoryList(
  productFactory,
  key: 'products',
);
```

##### 2.3 Skip invalid data
```dart
final List<ProductModel> products = json.factoryList(
  productFactory,
  key: 'products',
  throws: false,
);
```

##### 3 Combine it as you need
```dart
/// EXAMPLE 1
MyModel fromJson(JsonMap json){
    final product = json.object('product').factory(productFactory);
    final List<Tags> tags = json.factoryList(
      productFactory,
      key: 'tags',
    );
    return MyModel(product: product, tags: tags);
}

/// EXAMPLE 2
String extractTitle(JsonMap e) => e.string('title');

final items = json
    .object('data')
    .list('product')
    .map(extractTitle)
    .toList();
```

## Additional information

#### Exception message format
```dart
Type: JsonParseFieldException
Reason: Expected double, but got '12' (String). data['price'] is '12'
Key: price
Data: {price: '12', title: Phone1}
StackTrace: ...
```
