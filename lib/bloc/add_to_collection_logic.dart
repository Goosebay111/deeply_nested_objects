// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:deeply_nested_objects/bloc/collection_bloc.dart';
import 'package:deeply_nested_objects/bloc/collection_event.dart';
import 'package:deeply_nested_objects/bloc/collection_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void addToCollectionLogic(
    ShowType showType, int index, int count, BuildContext context) {
  switch (showType) {
    case ShowType.collection:
      addToTopLayer('Series $count', index, ShowType.series, context);
      break;
    case ShowType.series:
      addToNodes('Season $count', index, ShowType.season, context);
      break;
    case ShowType.season:
      addToNodes('Episode $count', index, ShowType.episode, context);
      break;
    case ShowType.episode:
      break;
  }
}

void addToTopLayer(name, index, showType, context) {
  BlocProvider.of<CollectionBloc>(context).add(
    AddToTopLayer(
      index: index,
      child: CollectionState(
        name: name,
        showType: showType,
        children: [],
        heartbeats: 0
      ),
    ),
  );
}

void addToNodes(name, index, showType, context) {
  BlocProvider.of<CollectionBloc>(context).add(
    AddToNode(
      index: index,
      child: CollectionState(
        name: name,
        showType: showType,
        children: [],
        heartbeats: 0
      ),
    ),
  );
}
