import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'notes_detail.g.dart';

@HiveType(typeId: 2)
class NotesDetail extends Equatable {
  @HiveField(0)
  final String? by;

  @HiveField(1)
  final List<String> nose;

  @HiveField(2)
  final List<String> palate;

  @HiveField(3)
  final List<String> finish;

  const NotesDetail({
    this.by,
    required this.nose,
    required this.palate,
    required this.finish,
  });

  /// Creates an instance of NotesDetail from a JSON map.
  factory NotesDetail.fromJson(Map<String, dynamic> json) {
    return NotesDetail(
      by: json['by'] as String?,
      nose:
          (json['nose'] as List<dynamic>)
              .map((item) => item as String)
              .toList(),
      palate:
          (json['palate'] as List<dynamic>)
              .map((item) => item as String)
              .toList(),
      finish:
          (json['finish'] as List<dynamic>)
              .map((item) => item as String)
              .toList(),
    );
  }

  /// Converts an instance of NotesDetail to a JSON map.
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      'nose': nose,
      'palate': palate,
      'finish': finish,
    };

    if (by != null) {
      data['by'] = by;
    }
    return data;
  }

  @override
  List<Object?> get props => [nose, palate, finish, by];
}
