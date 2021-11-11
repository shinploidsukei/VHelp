import 'package:flutter/material.dart';

final String tableLogs = 'logs';

// ignore_for_file: camel_case_types
class eventFields {
  static final List<String> values = [
    id,
    title,
    description,
    from,
    to,
    backgroundColor,
    isAllDay
  ];

  static final String id = '_id';
  static final String title = 'title';
  static final String description = 'description';
  static final String from = 'from';
  static final String to = 'to';
  static final String backgroundColor = 'backgroundColor';
  static final String isAllDay = 'isAllDay';
}

class Event {
  final int? id;
  final String title;
  final String description;
  final DateTime from;
  final DateTime to;
  final Color backgroundColor;
  final bool isAllDay;

  const Event({
    this.id,
    required this.title,
    required this.description,
    required this.from,
    required this.to,
    this.backgroundColor = Colors.lightGreen,
    this.isAllDay = false,
  });

  Event copy({
    int? id,
    String? title,
    String? description,
    DateTime? from,
    DateTime? to,
    Color? backgroundColor,
    bool? isAllDay,
  }) =>
      Event(
          id: id ?? this.id,
          title: title ?? this.title,
          description: description ?? this.description,
          from: from ?? this.from,
          to: to ?? this.to,
          backgroundColor: backgroundColor ?? this.backgroundColor,
          isAllDay: isAllDay ?? this.isAllDay);

  static Event fromJson(Map<String, Object?> json) => Event(
        id: json[eventFields.id] as int?,
        title: json[eventFields.title] as String,
        description: json[eventFields.description] as String,
        from: json[eventFields.from] as DateTime,
        to: json[eventFields.to] as DateTime,
        backgroundColor: json[eventFields.backgroundColor] as Color,
        isAllDay: json[eventFields.isAllDay] == 1,
      );

  Map<String, Object?> toJson() => {
        eventFields.id: id,
        eventFields.title: title,
        eventFields.description: description,
        eventFields.from: from.toIso8601String(),
        eventFields.to: to.toIso8601String(),
        eventFields.backgroundColor: backgroundColor,
        eventFields.isAllDay: isAllDay ? 1 : 0,
      };
}
