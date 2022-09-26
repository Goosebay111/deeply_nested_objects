import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:deeply_nested_objects/bloc/collection/collection_bloc.dart';
import 'package:deeply_nested_objects/bloc/collection/collection_event.dart';
import 'package:deeply_nested_objects/bloc/collection/collection_state.dart';
import 'package:deeply_nested_objects/pages/navigate_to_next_page.dart';
import 'package:deeply_nested_objects/helper_functions/naming_dialog_box.dart';

void createNode({
  required CollectionState parentNode,
  required BuildContext context,
}) {
  switch (parentNode.showType) {
    case ShowType.collection:
      addToTopLayer(
        name: 'Series ${parentNode.children.length + 1}',
        showType: ShowType.series,
        context: context,
      );
      break;
    case ShowType.series:
      addToNodes(
        parent: parentNode,
        name: 'Season ${parentNode.children.length + 1}',
        showType: ShowType.season,
        context: context,
        newRequest: 'Name Season',
        youTube: false,
      );
      break;
    case ShowType.season:
      addToNodes(
        parent: parentNode,
        name: 'Episode ${parentNode.children.length + 1}',
        showType: ShowType.episode,
        context: context,
        newRequest: 'Enter YouTube Link',
        youTube: true,
      );
      break;
    case ShowType.episode:
      navigateToNextPage(parentNode: parentNode, context: context);
      break;
  }
}

void addToTopLayer({required name, required showType, required context}) async {
  String? newName = await namingDialogBox(
    context: context,
    currentText: name,
    newRequest: 'Rename Collection',
  );

  if (newName == null) {
    return;
  }

  BlocProvider.of<CollectionBloc>(context).add(
    AddToTopLayerData(
      newChild: CollectionState(
        name: newName,
        webAddress: null,
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
  required newRequest,
  required bool youTube,
}) async {
  ///
  String? newName = await namingDialogBox(
    context: context,
    currentText: name,
    newRequest: newRequest,
    youTube: youTube,
  );
  ///
  if (showType == ShowType.season) {
    BlocProvider.of<CollectionBloc>(context).add(
      AddToDeeplyNestedData(
        newChild: CollectionState(
          name: newName ?? name,
          webAddress: null,
          showType: showType,
          children: [],
        ),
        parentNode: parent,
      ),
    );
  } else if (showType == ShowType.episode) {
    BlocProvider.of<CollectionBloc>(context).add(
      AddToDeeplyNestedData(
        newChild: CollectionState(
          name: 'Episode ${parent.children.length + 1}',
          webAddress: newName ?? name,
          showType: showType,
          children: [],
        ),
        parentNode: parent,
      ),
    );
  }
}
