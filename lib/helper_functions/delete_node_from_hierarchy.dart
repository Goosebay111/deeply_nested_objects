import 'package:deeply_nested_objects/bloc/collection/collection_state.dart';

void deleteNodeFromHierarchy(CollectionState object, CollectionState node) {
  if (node.children.contains(object)) {
    node.children.remove(object);
  } else {
    for (CollectionState child in node.children) {
      deleteNodeFromHierarchy(object, child);
    }
  }
}
