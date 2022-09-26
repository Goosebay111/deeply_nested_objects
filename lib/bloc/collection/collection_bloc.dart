import 'package:deeply_nested_objects/bloc/collection/collection_event.dart';
import 'package:deeply_nested_objects/bloc/collection/collection_state.dart';
import 'package:deeply_nested_objects/helper_functions/delete_node_from_hierarchy.dart';
import 'package:deeply_nested_objects/helper_functions/renaming_node_in_hierarchy.dart';
import 'package:deeply_nested_objects/helper_functions/renaming_web_address_in_hierarchy.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CollectionBloc extends Bloc<CollectionEvents, CollectionState> {
  CollectionBloc() : super(CollectionState.initial()) {
    on<AddToTopLayerData>((event, emit) =>
        emit(state.copyWith(children: [...state.children, event.newChild])));

    on<AddToDeeplyNestedData>(
      (event, emit) {
        event.parentNode.children.add(event.newChild);

        emit(state.copyWith(children: [...state.children]));
      },
    );

    on<DeleteFromParentNode>(((event, emit) {
      emit(
        state.copyWith(
          children: state.children
              .where((element) => element != event.parent)
              .toList(),
        ),
      );
    }));

    on<DeleteFromNestedNode>((event, emit) {
      deleteNodeFromHierarchy(event.parent, state);
      emit(state.copyWith(children: [...state.children]));
    });

    on<UpdateNodeName>(((event, emit) {
      emit(renameNodeInHierarchy(event.newName, event.parent, state));
    }));

    on<UpdateNodeWebAddress>((event, emit) {
      emit(renameWebAddressInHierarchy(
          event.newWebAddress!, event.parent, state));
    });
  }
}
