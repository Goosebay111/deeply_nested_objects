import 'package:deeply_nested_objects/bloc/collection/collection_event.dart';
import 'package:deeply_nested_objects/bloc/collection/collection_state.dart';
import 'package:deeply_nested_objects/bloc/crude_operations/delete.dart';
import 'package:deeply_nested_objects/bloc/crude_operations/update.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CollectionBloc extends Bloc<CollectionEvents, CollectionState> {
  CollectionBloc() : super(CollectionState.initial()) {
    on<AddToTopLayerData>((event, emit) =>
        emit(state.copyWith(children: [...state.children, event.newChild])));

    on<AddToDeeplyNestedData>(
      (event, emit) {
        final CollectionState parentNode = event.parentNode;

        parentNode.children.add(event.newChild);

        emit(state.copyWith(children: [...state.children]));
      },
    );

    on<DeleteNode>((event, emit) {
      // 1) erase in the top layer node children.
      if (event.parent.showType == ShowType.series) {
        emit(
          state.copyWith(
            children: state.children
                .where((element) => element != event.parent)
                .toList(),
          ),
        );
      }

      // 2) erase a node from the deeply nested layers
      if (event.parent.showType == ShowType.season ||
          event.parent.showType == ShowType.episode) {
        deleteNodeFromHierarchy(event.parent, state);
        emit(state.copyWith(children: [...state.children]));
      }
    });

    on<UpdateNodeName>(((event, emit) {
      emit(renameNodeInHierarchy(
        event.newName,
        event.parent,
        state,
      ));
    }));

    on<UpdateNodeWebAddress>((event, emit) {
      emit(renameWebAddressInHierarchy(
        event.newWebAddress!,
        event.parent,
        state,
      ));
    });
  }
}
