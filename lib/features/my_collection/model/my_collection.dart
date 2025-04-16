import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'my_collection.g.dart';

@HiveType(typeId: 0)
final class MyCollection extends Equatable {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final String imagePath;

  @HiveField(2)
  final int year;

  @HiveField(3)
  final int number;

  @HiveField(4)
  final int currentCount;

  @HiveField(5)
  final int totalCount;

  @HiveField(6)
  final String type;

  const MyCollection({
    required this.title,
    required this.imagePath,
    required this.year,
    required this.number,
    required this.currentCount,
    required this.totalCount,
    required this.type,
  });

  // Factory constructor to create an instance from JSON data.
  factory MyCollection.fromJson(Map<String, dynamic> json) {
    return MyCollection(
      title: json['title'] as String,
      imagePath: json['imagePath'] as String,
      year: json['year'] as int,
      number: json['number'] as int,
      currentCount: json['currentCount'] as int,
      totalCount: json['totalCount'] as int,
      type: json['type'] as String,
    );
  }

  // Method to convert an instance to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'imagePath': imagePath,
      'year': year,
      'number': number,
      'currentCount': currentCount,
      'totalCount': totalCount,
      'type': type,
    };
  }

  @override
  List<Object?> get props => [
    title,
    imagePath,
    year,
    number,
    currentCount,
    totalCount,
    type,
  ];
}
