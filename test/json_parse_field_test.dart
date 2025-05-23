import 'package:tamed_json/tamed_json.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  group('JSON Parse Field Extension', () {
    final intKey = 'intKey';
    final doubleKey = 'doubleKey';
    final boolKey = 'boolKey';
    final stringKey = 'stringKey';
    final objectKey = 'objectKey';
    final nullKey = 'nullKey';
    final randomKey = 'RANDOM_KEY';

    final JsonMap childJson = {'key': 'value'};
    final JsonMap json = {
      intKey: 1,
      doubleKey: 1.1,
      boolKey: true,
      stringKey: 'string',
      objectKey: childJson,
      nullKey: null,
    };

    test('integer correct value', () {
      expect(json.integer(intKey), 1);
      expect(json.integerNull(randomKey), null);
      expect(json.integer(randomKey, 1), 1);
    });

    test('double correct value', () {
      expect(json.double(doubleKey), 1.1);
      expect(json.double(intKey), 1.0);
      expect(json.doubleNull(randomKey), null);
      expect(json.double(randomKey, 1.1), 1.1);
    });

    test('bool correct value', () {
      expect(json.bool(boolKey), true);
      expect(json.boolNull(randomKey), null);
      expect(json.bool(randomKey, true), true);
    });

    test('string correct value', () {
      expect(json.string(stringKey), 'string');
      expect(json.stringNull(randomKey), null);
      expect(json.string(randomKey, 'string'), 'string');
    });

    test('object correct value', () {
      expect(json.object(objectKey), childJson);
      expect(json.object(objectKey).string('key'), 'value');
      expect(json.objectNull(randomKey), null);
      expect(json.objectNull(randomKey, childJson), childJson);
      expect(json.objectNull(randomKey, childJson)?.string('key'), 'value');
    });
  });
}
