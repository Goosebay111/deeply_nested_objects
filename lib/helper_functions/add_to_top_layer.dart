import 'package:deeply_nested_objects/bloc/collection/collection_event.dart';
import 'package:deeply_nested_objects/bloc/collection/collection_state.dart';

CollectionState addToTopLayerData(
  CollectionState state,
  AddToTopLayerData event,
) {
  return state.copyWith(children: [...state.children, event.newChild]);
}