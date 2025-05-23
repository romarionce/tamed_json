// Need to prevent analyser warning
// ignore_for_file: library_private_types_in_public_api

import 'package:tamed_json/src/exception/json_parse_field_exception.dart';
import 'package:tamed_json/src/model/json_unknown_type.dart';
import 'package:tamed_json/src/types/json.dart';

// Override double, int, bool type in file
// use json.double()
typedef _Double = double;
typedef _Bool = bool;
typedef _Int = int;

extension JsonParseField on JsonMap {
  dynamic _get(String? key) => key == null ? this : this[key];

  JsonParseFieldException _parseError(String type, String? key) =>
      JsonParseFieldException(type: type, json: this, key: key);

  T? _parseGeneric<T>(String? key, T? or, {_Bool isNullable = false}) {
    var data = _get(key);
    if (data == null) {
      if (or != null) return or;
      if (isNullable) return null;
      throw _parseError('$T${isNullable ? '?' : ''}', key);
    }
    try {
      dynamic tryResult = JsonUnknownType();
      if (T == String || T == _Bool || T == JsonMap || T == List) {
        tryResult = data;
      } else if (T == _Int) {
        tryResult = (data as num).toInt();
      } else if (T == _Double) {
        tryResult = (data as num).toDouble();
      }

      if (tryResult is! JsonUnknownType) {
        return tryResult as T;
      }

      throw tryResult;
    } catch (e) {
      if (or != null) return or;
      final isNullableStr = isNullable ? '?' : '';
      throw _parseError('$T$isNullableStr', key);
    }
  }

  /// Read int value from [key] with default [or] value
  _Int int([String? key, _Int? or]) => _parseGeneric<_Int>(key, or)!;

  /// Read int? value from [key] with default [or] value
  _Int? intNull([String? key, _Int? or]) =>
      _parseGeneric<_Int>(key, or, isNullable: true);

  /// Read double value from [key] with default [or] value
  _Double double([String? key, _Double? or]) =>
      _parseGeneric<_Double>(key, or)!;

  /// Read double? value from [key] with default [or] value
  _Double? doubleNull([String? key, _Double? or]) =>
      _parseGeneric<_Double>(key, or, isNullable: true);

  /// Read String value from [key] with default [or] value
  String string([String? key, String? or]) => _parseGeneric<String>(key, or)!;

  /// Read String? value from [key] with default [or] value
  String? stringNull([String? key, String? or]) =>
      _parseGeneric<String>(key, or, isNullable: true);

  /// Read bool value from [key] with default [or] value
  _Bool bool([String? key, _Bool? or]) => _parseGeneric<_Bool>(key, or)!;

  /// Read bool? value from [key] with default [or] value
  _Bool? boolNull([String? key, _Bool? or]) =>
      _parseGeneric<_Bool>(key, or, isNullable: true);

  /// Read JsonMap value from [key] with default [or] value
  JsonMap object([String? key, JsonMap? or]) =>
      _parseGeneric<JsonMap>(key, or)!;

  /// Read JsonMap? value from [key] with default [or] value
  JsonMap? objectNull([String? key, JsonMap? or]) =>
      _parseGeneric<JsonMap>(key, or, isNullable: true);

  List list([String? key, List? or]) => _parseGeneric<List>(key, or)!;

  List? listNull([String? key, List? or]) =>
      _parseGeneric<List>(key, or, isNullable: true);
}
