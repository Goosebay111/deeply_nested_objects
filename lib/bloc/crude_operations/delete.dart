import 'package:deeply_nested_objects/bloc/collection_bloc.dart';
import 'package:deeply_nested_objects/bloc/collection_event.dart';
import 'package:deeply_nested_objects/bloc/collection_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void deleteNode({
  required parent,
  required context,
}) async {
  BlocProvider.of<CollectionBloc>(context).add(
    DeleteNode(parent: parent),
  );
}

 void deleteFromParentNode(CollectionState object, CollectionState node) {
        if (node.children.contains(object)) {
          node.children.remove(object);
        } else {
          for (CollectionState child in node.children) {
            deleteFromParentNode(object, child);
          }
        }
      }