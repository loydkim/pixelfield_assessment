import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixelfield_project/features/my_collection/bloc/my_collection_bloc.dart';
import 'package:pixelfield_project/features/my_collection/widgets/my_collection_item.dart';

class MyCollectionList extends StatelessWidget {
  const MyCollectionList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyCollectionBloc, MyCollectionState>(
      builder: (context, state) {
        switch (state.status) {
          case MyCollectionStatus.initial:
            return const Center(child: CircularProgressIndicator());
          case MyCollectionStatus.success:
            return Padding(
              padding: const EdgeInsets.all(16.0),
              // A GridView showing 2 columns of items
              child: GridView.builder(
                itemBuilder: (context, index) {
                  return MyCollectionItem(
                    myCollection: state.myCollections[index],
                  );
                },
                itemCount: state.myCollections.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2 columns
                  mainAxisSpacing: 16.0,
                  crossAxisSpacing: 16.0,
                  childAspectRatio: 0.55, // Adjust as needed
                ),
              ),
            );
          case MyCollectionStatus.failure:
            return const Center(child: Text('failed to fetch my collection'));
        }
      },
    );
  }
}
