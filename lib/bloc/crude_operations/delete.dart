import 'package:deeply_nested_objects/bloc/collection/collection_bloc.dart';
import 'package:deeply_nested_objects/bloc/collection/collection_event.dart';
import 'package:deeply_nested_objects/bloc/collection/collection_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void deleteNode({
  required parent,
  required context,
}) async {
  // add dialog box here asking if the user is sure they want to delete the node
  showDialog(
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
              (parent.showType == ShowType.series)
                  ? DeleteFromParentNode(parent: parent)
                  : DeleteFromNestedNode(parent: parent),
            );
          },
          child: const Text('Yes'),
        ),
      ],
    ),
  );
}
