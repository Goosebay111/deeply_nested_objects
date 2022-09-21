import 'package:deeply_nested_objects/bloc/collection_bloc.dart';
import 'package:deeply_nested_objects/bloc/collection_event.dart';
import 'package:deeply_nested_objects/bloc/collection_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void addToCollectionLogic(
    ShowType showType, int index, int count, BuildContext context) {
  switch (showType) {
    case ShowType.collection:
      passToBloc('Series $count', index, ShowType.series, context);
      break;
    case ShowType.series:
      passToBloc('Season $count', index, ShowType.season, context);
      break;
    case ShowType.season:
      passToBloc('Episode $count', index, ShowType.episode, context);
      break;
    case ShowType.episode:
      break;
  }
}

void passToBloc(name, index, showType, context) {
  BlocProvider.of<CollectionBloc>(context).add(
    AddInfo(
      index: index,
      child: CollectionState(
        name: name,
        showType: showType,
        children: [],
      ),
    ),
  );
}
