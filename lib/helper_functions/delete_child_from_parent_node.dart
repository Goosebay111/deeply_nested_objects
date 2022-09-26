import 'package:deeply_nested_objects/bloc/collection/collection_event.dart';
import 'package:deeply_nested_objects/bloc/collection/collection_state.dart';

CollectionState deleteChildFromParentNode(CollectionState state, DeleteFromParentNode event) {
  return state.copyWith(children: state.children.where((element) => element != event.parent).toList());
}