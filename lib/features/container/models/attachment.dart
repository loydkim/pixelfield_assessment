import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'attachment.g.dart';

@HiveType(typeId: 4)
class Attachment extends Equatable {
  @HiveField(0)
  final String attachmentName;

  @HiveField(1)
  final String attachmentUrl;

  const Attachment({required this.attachmentName, required this.attachmentUrl});

  /// Creates an instance of [Attachment] from a JSON map.
  factory Attachment.fromJson(Map<String, dynamic> json) {
    return Attachment(
      attachmentName: json['attachmentName'] as String,
      attachmentUrl: json['attachmentUrl'] as String,
    );
  }

  /// Converts an instance of [Attachment] to a JSON map.
  Map<String, dynamic> toJson() {
    return {'attachmentName': attachmentName, 'attachmentUrl': attachmentUrl};
  }

  @override
  List<Object?> get props => [attachmentName, attachmentUrl];
}
