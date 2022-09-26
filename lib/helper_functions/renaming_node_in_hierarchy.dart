import 'package:deeply_nested_objects/bloc/collection/collection_state.dart';

CollectionState renameNodeInHierarchy(
    String newName, CollectionState nodeToChange, CollectionState currentNode) {
  return currentNode.copyWith(
      name: currentNode == nodeToChange ? newName : currentNode.name,
      children: [
        for (var child in currentNode.children)
          renameNodeInHierarchy(newName, nodeToChange, child)
      ]);
}