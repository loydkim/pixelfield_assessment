import 'package:flutter/material.dart';
import 'package:pixelfield_project/features/container/view/container_page.dart';
import 'package:pixelfield_project/features/my_collection/model/my_collection.dart';

class MyCollectionItem extends StatelessWidget {
  final MyCollection myCollection;
  const MyCollectionItem({super.key, required this.myCollection});

  @override
  Widget build(BuildContext context) {
    const Color bgColor = Color(0xFF122329);
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ContainerPage(myCollection: myCollection),
          ),
        );
      },
      child: Container(
        color: bgColor,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Image of the bottle
              Expanded(
                child: Image.asset(myCollection.imagePath, fit: BoxFit.cover),
              ),
              const SizedBox(height: 20),
              // Title text
              Text(
                '${myCollection.title} ${myCollection.year} #${myCollection.number}',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 22,
                ),
              ),
              const SizedBox(height: 4),
              // Subtitle text
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '(${myCollection.currentCount}/${myCollection.totalCount})',
                  style: const TextStyle(
                    color: Color(0xFFD7D5D1),
                    fontSize: 13,
                  ),
                ),
              ),

              const SizedBox(height: 6),
            ],
          ),
        ),
      ),
    );
  }
}
