import 'package:deeply_nested_objects/bloc/collection_bloc.dart';
import 'package:deeply_nested_objects/bloc/collection_event.dart';
import 'package:deeply_nested_objects/bloc/collection_state.dart';
import 'package:deeply_nested_objects/naming_dialog_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void addToCollectionLogic({
  required CollectionState parentNode,
  required ShowType showType,
  required BuildContext context,
}) {
  switch (showType) {
    case ShowType.collection:
      addToTopLayer(
          name: 'Series ${parentNode.children.length + 1}',
          showType: ShowType.series,
          context: context);
      break;
    case ShowType.series:
      addToNodes(
          parent: parentNode,
          name: 'Season ${parentNode.children.length + 1}',
          showType: ShowType.season,
          context: context);
      break;
    case ShowType.season:
      addToNodes(
          parent: parentNode,
          name: 'Episode ${parentNode.children.length + 1}',
          showType: ShowType.episode,
          context: context);
      break;
    case ShowType.episode:
      break;
  }
}

void addToTopLayer({required name, required showType, required context}) async {

  String? newName = await namingDialogBox(
            context: context,
            currentText: name,
            newRequest: 'Rename Collection',
          );

  BlocProvider.of<CollectionBloc>(context).add(
    AddToTopLayer(
      newChild: CollectionState(
        name: newName ?? name,
        showType: showType,
        children: [],
      ),
    ),
  );
}

void addToNodes({
  required name,
  required parent,
  required showType,
  required context,
})  async {

  String? newName = await namingDialogBox(
            context: context,
            currentText: name,
            newRequest: 'Rename Collection',
          );

  BlocProvider.of<CollectionBloc>(context).add(
    AddToNode(
      newChild: CollectionState(
        name: newName ?? name,
        showType: showType,
        children: [],
      ),
      parent: parent,
    ),
  );
}
