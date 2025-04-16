import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'detail.g.dart';

@HiveType(typeId: 1)
class Detail extends Equatable {
  @HiveField(0)
  final String distillery;

  @HiveField(1)
  final String region;

  @HiveField(2)
  final String country;

  @HiveField(3)
  final String type;

  @HiveField(4)
  final String ageStatement;

  @HiveField(5)
  final int filled;

  @HiveField(6)
  final int bottled;

  @HiveField(7)
  final double caskNumber;

  @HiveField(8)
  final double abv;

  @HiveField(9)
  final String size;

  @HiveField(10)
  final String finish;

  const Detail({
    required this.distillery,
    required this.region,
    required this.country,
    required this.type,
    required this.ageStatement,
    required this.filled,
    required this.bottled,
    required this.caskNumber,
    required this.abv,
    required this.size,
    required this.finish,
  });

  /// Creates an instance of [Detail] from a JSON map.
  factory Detail.fromJson(Map<String, dynamic> json) {
    return Detail(
      distillery: json['distillery'] as String,
      region: json['region'] as String,
      country: json['country'] as String,
      type: json['type'] as String,
      ageStatement: json['ageStatement'] as String,
      filled: json['filled'] as int,
      bottled: json['bottled'] as int,
      caskNumber: (json['caskNumber'] as num).toDouble(),
      abv: (json['abv'] as num).toDouble(),
      size: json['size'] as String,
      finish: json['finish'] as String,
    );
  }

  /// Converts an instance of [Detail] to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'distillery': distillery,
      'region': region,
      'country': country,
      'type': type,
      'ageStatement': ageStatement,
      'filled': filled,
      'bottled': bottled,
      'caskNumber': caskNumber,
      'abv': abv,
      'size': size,
      'finish': finish,
    };
  }

  @override
  List<Object?> get props => [
    distillery,
    region,
    country,
    type,
    ageStatement,
    filled,
    bottled,
    caskNumber,
    abv,
    size,
    finish,
  ];
}
