import 'package:deeply_nested_objects/bloc/collection/collection_event.dart';
import 'package:deeply_nested_objects/bloc/collection/collection_state.dart';
import 'package:deeply_nested_objects/helper_functions/add_to_top_layer.dart';
import 'package:deeply_nested_objects/helper_functions/delete_child_from_parent_node.dart';
import 'package:deeply_nested_objects/helper_functions/delete_node_from_hierarchy.dart';
import 'package:deeply_nested_objects/helper_functions/renaming_node_in_hierarchy.dart';
import 'package:deeply_nested_objects/helper_functions/renaming_web_address_in_hierarchy.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class CollectionBloc extends HydratedBloc<CollectionEvents, CollectionState> {
  CollectionBloc() : super(CollectionState.initial()) {
    ///
    on<AddToTopLayerData>(
        (event, emit) => emit(addToTopLayerData(state, event)));

    on<AddToDeeplyNestedData>(
      (event, emit) {
        event.parent.children.add(event.newChild);
        emit(state.copyWith(children: [...state.children]));
      },
    );

    on<DeleteFromParentNode>(
      ((event, emit) => emit(deleteChildFromParentNode(state, event))),
    );

    on<DeleteFromNestedNode>(
      (event, emit) => emit(deleteNodeFromHierarchy(state, event)),
    );

    on<UpdateNodeName>(
      ((event, emit) => emit(renameNodeInHierarchy(state, event))),
    );

    on<UpdateNodeWebAddress>(
      (event, emit) => emit(renameWebAddressInHierarchy(state, event)),
    );
  }

  @override
  CollectionState? fromJson(Map<String, dynamic> json) {
    try {
      return CollectionState.fromJson(json);
    } catch (e) {
      print(e);
    }
    return null;
  }

  @override
  Map<String, dynamic>? toJson(CollectionState state) {
    return state.toJson();
  }
}
