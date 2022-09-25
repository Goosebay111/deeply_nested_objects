import 'package:deeply_nested_objects/bloc/collection/collection_event.dart';
import 'package:deeply_nested_objects/bloc/collection/collection_state.dart';
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

      void deleteNodeFromHierarchy(
          CollectionState object, CollectionState node) {
        if (node.children.contains(object)) {
          node.children.remove(object);
        } else {
          for (CollectionState child in node.children) {
            deleteNodeFromHierarchy(object, child);
          }
        }
      }

      // 2) erase a node from the deeply nested layers
      if (event.parent.showType == ShowType.season ||
          event.parent.showType == ShowType.episode) {
        deleteNodeFromHierarchy(event.parent, state);
        emit(state.copyWith(children: [...state.children]));
      }
    });

    CollectionState renameNodeInHierarchy(String newName,
        CollectionState nodeToChange, CollectionState currentNode) {
      return currentNode.copyWith(
          name: currentNode == nodeToChange ? newName : currentNode.name,
          children: [
            for (var child in currentNode.children)
              renameNodeInHierarchy(newName, nodeToChange, child)
          ]);
    }

    on<UpdateNodeName>(((event, emit) {
      emit(renameNodeInHierarchy(
        event.newName,
        event.parent,
        state,
      ));
    }));

    CollectionState renameWebAddressInHierarchy(String newWebAddress,
        CollectionState nodeToChange, CollectionState currentNode) {
      return currentNode.copyWith(
          webAddress: currentNode == nodeToChange
              ? newWebAddress
              : currentNode.webAddress,
          children: [
            for (var child in currentNode.children)
              renameWebAddressInHierarchy(newWebAddress, nodeToChange, child)
          ]);
    }

    on<UpdateNodeWebAddress>((event, emit) {
      emit(renameWebAddressInHierarchy(
        event.newWebAddress!,
        event.parent,
        state,
      ));
    });
  }
}
