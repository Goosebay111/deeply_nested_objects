import 'package:deeply_nested_objects/bloc/collection/collection_state.dart';

CollectionState deleteChildFromParentNode(CollectionState state, CollectionState parent) {
  return state.copyWith(children: state.children.where((element) => element != parent).toList());
}