import 'dart:math';

import 'package:deeply_nested_objects/bloc/collection_bloc.dart';
import 'package:deeply_nested_objects/bloc/collection_event.dart';
import 'package:deeply_nested_objects/bloc/collection_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void addToCollectionLogic(ShowType showType, int index, int count, BuildContext context) {
  if (showType == ShowType.collection) {
    BlocProvider.of<CollectionBloc>(context).add(AddInfo(
      child: CollectionState(
        name: "Series $count",
        showType: ShowType.series,
        children: [],
      ),
      index: index,
    ));
  }
  if (showType == ShowType.series) {
    BlocProvider.of<CollectionBloc>(context).add(AddInfo(
      child: CollectionState(
        name: 'Season $count',
        showType: ShowType.season,
        children: [],
      ),
      index: index,
    ));
  }
  if (showType == ShowType.season) {
    BlocProvider.of<CollectionBloc>(context).add(AddInfo(
      child: CollectionState(
        name: "Episode $count",
        showType: ShowType.episode,
        children: [],
      ),
      index: index,
    ));
  }
}
