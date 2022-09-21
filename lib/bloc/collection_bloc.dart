import 'package:deeply_nested_objects/bloc/collection_event.dart';
import 'package:deeply_nested_objects/bloc/collection_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CollectionBloc extends Bloc<CollectionEvents, CollectionState> {
  CollectionBloc() : super(CollectionState.initial()) {
    on<AddInfo>((event, emit) {
      if (event.child.showType == ShowType.series) {
        emit(state.copyWith(children: [...state.children, event.child]));
      }
      if (event.child.showType == ShowType.season ||
          event.child.showType == ShowType.episode) {
      //TODO: Here is the problem. This code does not work properly when I make the CollectionState class Equatable.
        // get the list of all nodes
        List<CollectionState> list = state.getAllNodes(state);
        // find the parent node while still in the list
        CollectionState parent = list[event.index];
        // add the child to the parent
        parent.children.add(event.child);
        // update the state
        emit(state.copyWith(children: [...state.children]));
      }
    });
  }
}
