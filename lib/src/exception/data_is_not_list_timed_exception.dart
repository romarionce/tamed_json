import 'package:tamed_json/src/entity/timed_json_exception.dart';

class DataIsNotListTimedException extends TimedJsonException {
  DataIsNotListTimedException({
    super.description,
    super.key,
    required super.json,
  }) : super(reason: 'Data is not subtype of type List<dynamic>');
}
