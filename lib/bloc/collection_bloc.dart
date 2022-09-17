import 'package:deeply_nested_objects/bloc/collection_event.dart';
import 'package:deeply_nested_objects/bloc/collection_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CollectionBloc extends Bloc<CollectionEvent, BaseState> {
  CollectionBloc() : super(CollectionInitial(ShowType.collection)) {
    ///
    on<AddSeries>((event, emit) {
      var newChildren = state.addChild(BaseState(
        index: state.children.length - 1,
        counter: state.counter + 1,
        children: [],
      ));
      emit(BaseState(
        index: 0,
        counter: state.counter + 1,
        children: newChildren,
      ));
    });

    ///
    on<AddSeason>(((event, emit) {
      var newChildren = state.addChildToChild(
          event.index,
          BaseState(
            index: event.index,
            counter: state.counter + 1,
            children: [],
          ));
      emit(
        BaseState(
          index: 0,
          counter: state.counter + 1,
          children: newChildren,
        ),
      );

      //
      on<AddEpisode>((event, emit) {
        var newChildren = state.addChildToChildToChild(
            event.index,
            event.index2,
            BaseState(
              index: event.index,
              counter: state.counter + 1,
              children: [],
            ));
        emit(
          BaseState(
            index: 0,
            counter: state.counter + 1,
            children: newChildren,
          ),
        );
      });
    }));
  }
}
