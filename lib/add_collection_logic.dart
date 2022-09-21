import 'dart:math';

import 'package:deeply_nested_objects/bloc/collection_bloc.dart';
import 'package:deeply_nested_objects/bloc/collection_event.dart';
import 'package:deeply_nested_objects/bloc/collection_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void addToCollection(ShowType showType, int index, BuildContext context) {
  if (showType == ShowType.collection) {
    BlocProvider.of<CollectionBloc>(context).add(AddInfo(
      child: CollectionState(
        name: "Series ${(1000 + Random().nextInt(9000))}",
        showType: ShowType.series,
        children: [],
      ),
      index: index,
    ));
  }
  if (showType == ShowType.series) {
    BlocProvider.of<CollectionBloc>(context).add(AddInfo(
      child: CollectionState(
        name: 'Season ${(1000 + Random().nextInt(9000))}',
        showType: ShowType.season,
        children: [],
      ),
      index: index,
    ));
  }
  if (showType == ShowType.season) {
    BlocProvider.of<CollectionBloc>(context).add(AddInfo(
      child: CollectionState(
        name: "Episode ${(1000 + Random().nextInt(9000))}",
        showType: ShowType.episode,
        children: [],
      ),
      index: index,
    ));
  }
}
