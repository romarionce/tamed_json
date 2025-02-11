import 'package:tamed_json/src/entity/json_factory.dart';
import 'package:tamed_json/src/exception/data_is_not_list_timed_exception.dart';
import 'package:tamed_json/src/types/json.dart';

List<D> _factoryList<D>(
  JsonFactory<D> i, {
  String? key,
  List<D>? or,
  bool throws = false,
  dynamic json,
}) {
  var data = key != null ? json[key] : json;
  if (data == null && or != null) return or;
  if (data is! List) {
    throw DataIsNotListTimedException(key: key, json: data);
  }

  return (data)
      .map((e) {
        try {
          final result = i.fromJSON(e);
          return result;
        } catch (e) {
          if (throws) rethrow;
        }
      })
      .whereType<D>()
      .toList();
}

// TODO
// extension JsonListParseFactory on List<dynamic> {
//   List<D> factoryList<D>(
//     JsonFactory<D> i, {
//     List<D>? or,
//     bool throws = false,
//   }) =>
//       _factoryList(i, or: or, throws: throws, json: this);
// }

extension JsonParseFactoryExtension on JsonMap {
  D factory<D, T extends JsonFactory<D>>(T i, {String? key, D? or}) {
    var data = key != null ? this[key] : this;
    if (data == null && or != null) return or;
    return i.fromJSON(data);
  }

  List<D> factoryList<D>(
    JsonFactory<D> i, {
    List<D>? or,
    bool throws = false,
  }) =>
      _factoryList(i, or: or, throws: throws, json: this);
}
