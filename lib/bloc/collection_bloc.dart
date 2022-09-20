import 'package:deeply_nested_objects/bloc/collection_event.dart';
import 'package:deeply_nested_objects/bloc/collection_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CollectionBloc extends Bloc<CollectionEvents, CollectionState> {
  CollectionBloc() : super(CollectionState.initial()) {
    on<AddItem>((event, emit) {
      if (
          event.child.showType == ShowType.series) {
        emit(state.copyWith(children: [...state.children, event.child]));
      }
      if (event.child.showType == ShowType.season ||
          event.child.showType == ShowType.episode) {
        // add the child to the parent
        List<CollectionState> list = state.allHierarchy(state);
        CollectionState parent = list[event.index];
        parent.children.add(event.child);
        emit(state.copyWith(children: [...state.children]));
      }
      
    });
  }
}
