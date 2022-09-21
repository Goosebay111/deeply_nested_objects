import 'package:deeply_nested_objects/bloc/collection_bloc.dart';
import 'package:deeply_nested_objects/bloc/collection_event.dart';
import 'package:deeply_nested_objects/bloc/collection_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void addToCollectionLogic(
    ShowType showType, int index, int count, BuildContext context) {
  void passToBloc(String name, ShowType showType) =>
      BlocProvider.of<CollectionBloc>(context).add(
        AddInfo(
          index: index,
          child: CollectionState(name: name, showType: showType, children: []),
        ),
      );

  switch (showType) {
    case ShowType.collection:
      passToBloc('Series $count', ShowType.series);
      break;
    case ShowType.series:
      passToBloc('Season $count', ShowType.season);
      break;
    case ShowType.season:
      passToBloc('Episode $count', ShowType.episode);
      break;
    case ShowType.episode:
      break;
  }
}
