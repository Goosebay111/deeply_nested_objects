import 'package:deeply_nested_objects/bloc/collection/collection_event.dart';
import 'package:deeply_nested_objects/bloc/collection/collection_state.dart';

CollectionState renameNodeInHierarchy(
    CollectionState state, UpdateNodeName event) {
  return state.copyWith(
      name: state == event.parent ? event.newName : state.name,
      children: [
        for (var child in state.children)
          renameNodeInHierarchy(child, event)
      ]);
}