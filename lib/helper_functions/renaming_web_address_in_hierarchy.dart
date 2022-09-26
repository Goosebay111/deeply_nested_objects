import 'package:deeply_nested_objects/bloc/collection/collection_event.dart';
import 'package:deeply_nested_objects/bloc/collection/collection_state.dart';

CollectionState renameWebAddressInHierarchy(
    CollectionState state, UpdateNodeWebAddress event) {
  return state.copyWith(
    webAddress: state == event.parent ? event.newWebAddress : state.webAddress,
    children: [
      for (var child in state.children)
        renameWebAddressInHierarchy(child, event)
    ],
  );
}
