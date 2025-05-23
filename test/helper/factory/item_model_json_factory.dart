import 'package:tamed_json/tamed_json.dart';

import '../model/item_model.dart';

class ItemModelJsonFactory implements JsonFactory<ItemModel> {
  const ItemModelJsonFactory();

  @override
  ItemModel fromJson(JsonMap json) {
    return ItemModel(
      id: json.integer('id'),
      title: json.string('title'),
    );
  }

  @override
  JsonMap toJson(ItemModel model) {
    return {
      'id': model.id,
      'title': model.title,
    };
  }
}
