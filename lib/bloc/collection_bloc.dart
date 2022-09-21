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
        
        List<CollectionState> list = List.from(state.getAllNodes(state));
        CollectionState parent = list[event.index];
        parent.children.add(event.child);
        emit(state.copyWith(children: [...list[0].children]));
      }
    });
  }
}
