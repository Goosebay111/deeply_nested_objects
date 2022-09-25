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
      if (event.parent.showType == ShowType.season ||
          event.parent.showType == ShowType.episode) {
        deleteNodeFromHierarchy(event.parent, state);
        emit(state.copyWith(children: [...state.children]));
      }
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

CollectionState renameNodeInHierarchy(
    String newName, CollectionState nodeToChange, CollectionState currentNode) {
  return currentNode.copyWith(
      name: currentNode == nodeToChange ? newName : currentNode.name,
      children: [
        for (var child in currentNode.children)
          renameNodeInHierarchy(newName, nodeToChange, child)
      ]);
}

CollectionState renameWebAddressInHierarchy(String newWebAddress,
    CollectionState nodeToChange, CollectionState currentNode) {
  return currentNode.copyWith(
      webAddress:
          currentNode == nodeToChange ? newWebAddress : currentNode.webAddress,
      children: [
        for (var child in currentNode.children)
          renameWebAddressInHierarchy(newWebAddress, nodeToChange, child)
      ]);
}

void deleteNodeFromHierarchy(CollectionState object, CollectionState node) {
  if (node.children.contains(object)) {
    node.children.remove(object);
  } else {
    for (CollectionState child in node.children) {
      deleteNodeFromHierarchy(object, child);
    }
  }
}
