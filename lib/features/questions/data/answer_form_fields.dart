List<MapEntry<String, String>> flattenAnswerPayload(
  Map<dynamic, dynamic> data,
) {
  final fields = <MapEntry<String, String>>[];
  for (final entry in data.entries) {
    final name = '${entry.key}';
    final value = entry.value;
    if (value is Iterable && value is! String) {
      for (final item in value) {
        fields.add(MapEntry(name, '$item'));
      }
    } else {
      fields.add(MapEntry(name, '$value'));
    }
  }
  return fields;
}
