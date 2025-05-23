import 'package:tamed_json/tamed_json.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'helper/factory/item_model_json_factory.dart';
import 'helper/model/item_model.dart';

void main() {
  group('ItemModelJsonFactory test', () {
    const factory = ItemModelJsonFactory();

    final JsonMap json = {
      'list': [
        {'id': 1, 'title': 'item1'},
        {'id': 2, 'title': 'item2'},
      ],
      'single': {'id': 3, 'title': 'item3'},
    };

    test('factoryList returns list of ItemModel', () {
      final result = json.factoryList(factory, key: 'list');

      expect(result.length, 2);
      expect(result[0].title, 'item1');
      expect(result[0].id, 1);
      expect(result[1].title, 'item2');
      expect(result[1].id, 2);
    });

    test('factory returns single ItemModel', () {
      final model = json.factory(factory, key: 'single');

      expect(model.title, 'item3');
      expect(model.id, 3);
    });

    test('factoryList returns fallback if key not found', () {
      final fallback = [
        const ItemModel(id: 0, title: 'Fallback'),
      ];

      final result = json.factoryList(factory, key: 'missing', or: fallback);

      expect(result, equals(fallback));
    });

    test('factory returns fallback if key not found', () {
      final fallback = const ItemModel(id: 0, title: 'Fallback');
      final result = json.factory(factory, key: 'missing', or: fallback);

      expect(result, equals(fallback));
    });

    test('factoryList throws on invalid structure', () {
      final brokenJson = {'list': 'not_a_list'};

      expect(
        () => brokenJson.factoryList(factory, key: 'list'),
        throwsA(isA<DataIsNotListTimedException>()),
      );
    });
  });
}
