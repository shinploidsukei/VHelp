final String tableLog = 'TimeStampLog';

class TimeStampFields {
  static final List<String> values = [
    /// Add all fields
    id, datetime
  ];

  static final String id = '_id';
  static final String datetime = 'datetime';
}

class TimeStampDetails {
  final int? id;
  final DateTime datetime;

  const TimeStampDetails({
    this.id,
    required this.datetime,
  });

  TimeStampDetails copy({
    int? id,
    DateTime? datetime,
  }) =>
      TimeStampDetails(
        id: id ?? this.id,
        datetime: datetime ?? this.datetime,
      );

  static TimeStampDetails fromJson(Map<String, Object?> json) =>
      TimeStampDetails(
        id: json[TimeStampFields.id] as int?,
        datetime: DateTime.parse(json[TimeStampFields.datetime] as String),
      );

  Map<String, Object?> toJson() => {
        TimeStampFields.id: id,
        TimeStampFields.datetime: datetime.toIso8601String(),
      };
}
