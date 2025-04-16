import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:pixelfield_project/core/constatns/db_key.dart';
import 'package:pixelfield_project/features/my_collection/bloc/my_collection_bloc.dart';
import 'package:pixelfield_project/features/my_collection/model/my_collection.dart';
import 'package:pixelfield_project/features/my_collection/repository/my_collection_repository.dart';
import 'package:pixelfield_project/features/my_collection/view/my_collection_list.dart';

class MyCollectionPage extends StatefulWidget {
  const MyCollectionPage({super.key});

  @override
  State<MyCollectionPage> createState() => _MyCollectionPageState();
}

class _MyCollectionPageState extends State<MyCollectionPage> {
  @override
  Widget build(BuildContext context) {
    final dataBox = Hive.box<MyCollection>(myCollectionKey);
    final myCollectionRepository = MyCollectionRepository(dataBox);

    const Color backgroundColor = Color(0xFF0E1C21);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        centerTitle: false,
        automaticallyImplyLeading: false,
        elevation: 0, // Remove any drop shadow
        title: Row(
          children: [
            // "My collection" text on the left
            SizedBox(width: 10),
            Text(
              'My collection',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            // Spacer to push the bell icon to the right
            const Spacer(),
            // Bell icon with a red dot
            Stack(
              clipBehavior: Clip.none,
              children: [
                // Bell outline icon
                IconButton(
                  icon: const Icon(
                    Icons.notifications_none,
                    color: Colors.white,
                    size: 30,
                  ),
                  onPressed: () {
                    // Handle tap on bell icon
                  },
                ),
                // Red notification dot positioned in the top-right corner
                Positioned(
                  // right: 6,
                  // top: 10,
                  bottom: 13,
                  right: 12,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: BlocProvider(
        create:
            (_) =>
                MyCollectionBloc(myCollectionRepository: myCollectionRepository)
                  ..add(MyCollectionFetched()),
        child: MyCollectionList(),
      ),
    );
  }
}
