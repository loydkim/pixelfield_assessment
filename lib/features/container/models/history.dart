import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'attachment.dart';

part 'history.g.dart';

@HiveType(typeId: 5)
class History extends Equatable {
  @HiveField(0)
  final String label;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final List<String> descriptions;

  @HiveField(3)
  final List<Attachment> attachments;

  const History({
    required this.label,
    required this.title,
    required this.descriptions,
    required this.attachments,
  });

  /// Creates an instance of [History] from a JSON map.
  factory History.fromJson(Map<String, dynamic> json) {
    return History(
      label: json['label'] as String,
      title: json['title'] as String,
      descriptions: List<String>.from(json['descriptions'] as List),
      attachments:
          (json['attachments'] as List<dynamic>)
              .map((item) => Attachment.fromJson(item as Map<String, dynamic>))
              .toList(),
    );
  }

  /// Converts an instance of [History] to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'label': label,
      'title': title,
      'descriptions': descriptions,
      'attachments':
          attachments.map((attachment) => attachment.toJson()).toList(),
    };
  }

  @override
  List<Object?> get props => [label, title, descriptions, attachments];
}
