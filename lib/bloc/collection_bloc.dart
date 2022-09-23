import 'package:deeply_nested_objects/bloc/collection_event.dart';
import 'package:deeply_nested_objects/bloc/collection_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CollectionBloc extends Bloc<CollectionEvents, CollectionState> {
  CollectionBloc() : super(CollectionState.initial()) {
    on<AddToTopLayer>((event, emit) =>
        emit(state.copyWith(children: [...state.children, event.child])));

    on<AddToNode>(
      (event, emit) {
        final CollectionState parent = event.parent;

        parent.children.add(event.child);

        emit(state.copyWith(children: [...state.children]));
      },
    );
  }
}
