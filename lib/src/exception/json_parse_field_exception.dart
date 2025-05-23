import 'package:tamed_json/src/entity/timed_json_exception.dart';

class JsonParseFieldException extends TimedJsonException {
  JsonParseFieldException({
    required String type,
    super.key,
    required super.json,
  }) : super(
          reason:
              "Expected $type, but got ${json[key]} (${json[key].runtimeType}). data['$key'] is ${json[key]}",
        );
}
