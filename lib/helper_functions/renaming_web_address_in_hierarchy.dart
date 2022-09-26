import 'package:deeply_nested_objects/bloc/collection/collection_state.dart';

CollectionState renameWebAddressInHierarchy(String newWebAddress,
    CollectionState nodeToChange, CollectionState currentNode) {
  return currentNode.copyWith(
      webAddress:
          currentNode == nodeToChange ? newWebAddress : currentNode.webAddress,
      children: [
        for (var child in currentNode.children)
          renameWebAddressInHierarchy(newWebAddress, nodeToChange, child)
      ]);
}