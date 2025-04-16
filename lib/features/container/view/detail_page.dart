import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:pixelfield_project/core/constatns/db_key.dart';
import 'package:pixelfield_project/features/container/bloc/detail_bloc.dart';
import 'package:pixelfield_project/features/container/models/detail.dart';
import 'package:pixelfield_project/features/container/repository/detail_repository.dart';
import 'package:pixelfield_project/features/container/widgets/detail_list_item.dart';

class DetailPage extends StatelessWidget {
  final Color panelColor;
  const DetailPage({super.key, required this.panelColor});

  @override
  Widget build(BuildContext context) {
    final dataBox = Hive.box<Detail>(detailKey);
    final detailRepository = DetailRepository(dataBox);
    return BlocProvider(
      create:
          (_) =>
              DetailBloc(detailRepository: detailRepository)
                ..add(DetailFetched()),
      child: BlocBuilder<DetailBloc, DetailState>(
        builder: (context, state) {
          switch (state.status) {
            case DetailStatus.initial:
              return const Center(child: CircularProgressIndicator());
            case DetailStatus.success:
              return Padding(
                padding: const EdgeInsets.all(16.0),
                // Table-like list of attributes
                child:
                    state.detail == null
                        ? const Center(child: CircularProgressIndicator())
                        : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DetailListItem(
                              label: 'Distillery',
                              value: state.detail!.distillery,
                            ),
                            DetailListItem(
                              label: 'Region',
                              value: state.detail!.region,
                            ),
                            DetailListItem(
                              label: 'Country',
                              value: state.detail!.country,
                            ),
                            DetailListItem(
                              label: 'Type',
                              value: state.detail!.type,
                            ),
                            DetailListItem(
                              label: 'Age statement',
                              value: state.detail!.ageStatement,
                            ),
                            DetailListItem(
                              label: 'Filled',
                              value: state.detail!.filled.toString(),
                            ),
                            DetailListItem(
                              label: 'Bottled',
                              value: state.detail!.bottled.toString(),
                            ),
                            DetailListItem(
                              label: 'Cask number',
                              value: state.detail!.caskNumber.toString(),
                            ),
                            DetailListItem(
                              label: 'ABV',
                              value: state.detail!.abv.toString(),
                            ),
                            DetailListItem(
                              label: 'Size',
                              value: state.detail!.size,
                            ),
                            DetailListItem(
                              label: 'Finish',
                              value: state.detail!.finish,
                            ),
                          ],
                        ),
              );
            case DetailStatus.failure:
              return const Center(child: Text('failed to fetch detail'));
          }
        },
      ),
    );
  }
}
