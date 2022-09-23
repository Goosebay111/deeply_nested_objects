import 'package:deeply_nested_objects/bloc/collection_event.dart';
import 'package:deeply_nested_objects/bloc/collection_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CollectionBloc extends Bloc<CollectionEvents, CollectionState> {
  CollectionBloc() : super(CollectionState.initial()) {
    on<AddToTopLayer>((event, emit) =>
        emit(state.copyWith(children: [...state.children, event.newChild])));

    on<AddToNode>(
      (event, emit) {
        final CollectionState parent = event.parent;

        parent.children.add(event.newChild);

        emit(state.copyWith(children: [...state.children]));
      },
    );

    on<RenameTopLayer>(
      (event, emit) {
        final CollectionState parent = event.parent;
        // print('state: ${state.name}');
        // print('parent: ${parent.name}');
        // print('child: ${event.child.name}');

        if (event.parent.showType == ShowType.series) {
          emit(
            state.copyWith(
              children: state.children
                  .map((e) => e == parent ? e.copyWith(name: event.newName) : e)
                  .toList(),
            ),
          );
        } else if (event.parent.showType == ShowType.season) {
          emit(
            state.copyWith(
              children: state.children
                  .map((e) => e.copyWith(
                        children: e.children
                            .map(
                              (e) => e == event.parent
                                  ? e.copyWith(name: event.newName)
                                  : e,
                            )
                            .toList(),
                      ))
                  .toList(),
            ),
          );
        } else if (event.parent.showType == ShowType.episode) {
          emit(
            state.copyWith(
              children: state.children
                  .map((e) => e.copyWith(
                        children: e.children
                            .map((e) => e.copyWith(
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
        }
      },
    );
  }
}
