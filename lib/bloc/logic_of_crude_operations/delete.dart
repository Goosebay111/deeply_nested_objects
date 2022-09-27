import 'package:deeply_nested_objects/bloc/collection/collection_bloc.dart';
import 'package:deeply_nested_objects/bloc/collection/collection_event.dart';
import 'package:deeply_nested_objects/enums/show_type_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void deleteNode({
  required parent,
  required context,
}) async {
  switch (parent.showType) {
    case ShowType.collection:
      return;
    case ShowType.series:
      deleteFromParentNode(context, parent);
      return;
    case ShowType.season:
      deleteFromNestedNode(context, parent);
      return;
    case ShowType.episode:
      deleteFromNestedNode(context, parent);
      return;
  }
 // deleteFromParentNode(context, parent);
}

Future<dynamic> deleteFromParentNode(context, parent) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Are you sure you want to delete this node?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('No'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            BlocProvider.of<CollectionBloc>(context).add(
              DeleteFromParentNode(parent: parent),
            );
          },
          child: const Text('Yes'),
        ),
      ],
    ),
  );
}

Future<dynamic> deleteFromNestedNode(context, parent) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Are you sure you want to delete this node?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('No'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            BlocProvider.of<CollectionBloc>(context).add(
              DeleteFromNestedNode(parent: parent),
            );
          },
          child: const Text('Yes'),
        ),
      ],
    ),
  );
}
