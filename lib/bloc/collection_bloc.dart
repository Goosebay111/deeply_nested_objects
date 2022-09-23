import 'package:deeply_nested_objects/bloc/collection_event.dart';
import 'package:deeply_nested_objects/bloc/collection_state.dart';
import 'package:deeply_nested_objects/bloc/crude_operations/delete.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CollectionBloc extends Bloc<CollectionEvents, CollectionState> {
  CollectionBloc() : super(CollectionState.initial()) {
    on<AddToTopLayerData>((event, emit) =>
        emit(state.copyWith(children: [...state.children, event.newChild])));

    on<AddToDeeplyNestedData>(
      (event, emit) {
        final CollectionState parent = event.parent;

        parent.children.add(event.newChild);

        emit(state.copyWith(children: [...state.children]));
      },
    );

    on<DeleteNode>((event, emit) {
      // erase in the top layer
      if (event.parent.showType == ShowType.series) {
        emit(
          state.copyWith(
              children: state.children
                  .where((element) => element != event.parent)
                  .toList()),
        );
      }

      // erase in the deeply nested layers
      if (event.parent.showType == ShowType.season ||
          event.parent.showType == ShowType.episode) {
        final CollectionState nodeTree = state;
        deleteFromParentNode(event.parent, nodeTree);
        emit(state.copyWith(children: [...state.children]));
      }
    });

    on<UpdateNode>((event, emit) {
      emit(
        state.copyWith(
          children: state.children
              .map((e) => e.copyWith(
                    name: e == event.parent ? event.newName : e.name,
                    children: e.children
                        .map((e) => e.copyWith(
                              name: e == event.parent ? event.newName : e.name,
                              children: e.children
                                  .map(
                                    (e) => e == event.parent
                                        ? e.copyWith(name: event.newName)
                                        : e,
                                  )
                                  .toList(),
                            ))
                        .toList(),
                  ))
              .toList(),
        ),
      );
    });
  }
}
