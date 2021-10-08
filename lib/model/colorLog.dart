final String tableLogs = 'logs';

// ignore: camel_case_types
class colorFields {
  static final List<String> values = [id, colorSaved, createTime];

  static final String id = '_id';
  static final String colorSaved = 'colorSaved';
  static final String createTime = 'createTime';
}

// ignore: camel_case_types
class colorLog {
  final int? id;
  final int colorSaved;
  final DateTime createTime;
  const colorLog({this.id, required this.colorSaved, required this.createTime});

  colorLog copy({
    int? id,
    int? colorSaved,
    DateTime? createTime,
  }) =>
      colorLog(
          id: id ?? this.id,
          colorSaved: colorSaved ?? this.colorSaved,
          createTime: createTime ?? this.createTime);

  static colorLog fromJson(Map<String, Object?> json) => colorLog(
        id: json[colorFields.id] as int?,
        colorSaved: json[colorFields.colorSaved] as int,
        createTime: DateTime.parse(json[colorFields.createTime] as String),
      );

  Map<String, Object?> toJson() => {
        colorFields.id: id,
        colorFields.colorSaved: colorSaved,
        colorFields.createTime: createTime.toIso8601String()
      };
}
