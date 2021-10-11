final String tableLog = 'TimeStampLog';

class TimeStampFields {
  static final List<String> values = [
    /// Add all fields
    id, isImportant, datetime
  ];

  static final String id = '_id';
  static final String isImportant = 'isImportant';
  static final String datetime = 'datetime';
}

class TimeStampDetails {
  final int? id;
  final bool isImportant;
  final DateTime datetime;

  const TimeStampDetails({
    this.id,
    required this.isImportant,
    required this.datetime,
  });

  TimeStampDetails copy({
    int? id,
    bool? isImportant,
    DateTime? datetime,
  }) =>
      TimeStampDetails(
        id: id ?? this.id,
        isImportant: isImportant ?? this.isImportant,
        datetime: datetime ?? this.datetime,
      );

  static TimeStampDetails fromJson(Map<String, Object?> json) =>
      TimeStampDetails(
        id: json[TimeStampFields.id] as int?,
        isImportant: json[TimeStampFields.isImportant] == 1,
        datetime: DateTime.parse(json[TimeStampFields.datetime] as String),
      );

  Map<String, Object?> toJson() => {
        TimeStampFields.id: id,
        TimeStampFields.isImportant: isImportant ? 1 : 0,
        TimeStampFields.datetime: datetime.toIso8601String(),
      };
}
