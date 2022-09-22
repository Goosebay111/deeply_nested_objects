import 'package:deeply_nested_objects/bloc/collection_event.dart';
import 'package:deeply_nested_objects/bloc/collection_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CollectionBloc extends Bloc<CollectionEvents, CollectionState> {
  CollectionBloc() : super(CollectionState.initial()) {
    on<AddToTopLayer>((event, emit) =>
        emit(state.copyWith(children: [...state.children, event.child])));

    on<AddToNode>(
      (event, emit) {
        /// makes a copy of all of the nodes contained in the state.
        List<CollectionState> list = state.getAllNodes(state);

        /// Expose the parent node.
        CollectionState parent = list[event.index];

        /// add to the children of the parent, which changes the nested state of the data.
        parent.children.add(event.child);

        /// adds the updated data to the state to a black list.
        emit(state.copyWith(children: []..addAll(state.children)));
        /// OR
        ///emit(state.copyWith(children: [...state.children]));
        /// OR
        /// emit(state.copyWith(children: [...list[0].children]));
      },
    );
  }
}
