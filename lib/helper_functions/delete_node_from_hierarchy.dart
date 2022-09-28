import 'package:deeply_nested_objects/bloc/collection/collection_event.dart';
import 'package:deeply_nested_objects/bloc/collection/collection_state.dart';

CollectionState deleteNodeFromHierarchy(
    CollectionState state, DeleteFromNestedNode event) {
  if (state.children.contains(event.parent)) {
    state.children.remove(event.parent);
  } else {
    for (CollectionState child in state.children) {
      deleteNodeFromHierarchy(child, event);
    }
  }
  return state.copyWith(children: [...state.children]);
}
