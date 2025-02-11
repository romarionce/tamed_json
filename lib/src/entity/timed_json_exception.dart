abstract class TimedJsonException extends Error {
  TimedJsonException({
    required this.reason,
    required this.json,
    this.key,
    this.description,
  });

  final String reason;

  final String? description;

  final String? key;

  final dynamic json;

  String get keyText => key == null ? '' : 'with $key';

  @override
  String toString() {
    String result = 'Type: $runtimeType\n';
    result += 'Reason: $reason\n';
    if (description != null) result += 'Description: $description\n';
    result += 'Key: $key\n';
    result += 'Data: $json\n';
    result += 'StackTrace: $stackTrace';

    return result;
  }
}
