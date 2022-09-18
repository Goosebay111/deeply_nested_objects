// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:deeply_nested_objects/models/collection_model.dart';

class InitialState extends Shows {
  InitialState()
      : super(
          name: "Collection 1",
          showType: ShowType.collection,
          children: [],
        ) {
    // TODO: need to streamline this in order to use it for the bloc copyWith approach.

    Shows series1 = Shows(
      name: "Series 1",
      showType: ShowType.series,
      children: [],
    );
    Shows season1 = Shows(
      name: "Season 1",
      showType: ShowType.season,
      children: [],
    );
    Shows season2 = Shows(
      name: "Season 2",
      showType: ShowType.season,
      children: [],
    );
    Shows season3 = Shows(
      name: "Season 3",
      showType: ShowType.season,
      children: [],
    );
    Shows episode1 = Shows(
      name: "Episode 1",
      showType: ShowType.episode,
      children: [],
    );
    Shows episode2 = Shows(
      name: "Episode 2",
      showType: ShowType.episode,
      children: [],
    );
    Shows episode3 = Shows(
      name: "Episode 3",
      showType: ShowType.episode,
      children: [],
    );
    Shows episode4 = Shows(
      name: "Episode 4",
      showType: ShowType.episode,
      children: [],
    );

    // todo: This looks like an example of a tree structure.
    // todo: I am betting that the composite design pattern can be used here.

    super.addDetail(null, series1);
    super.addDetail(series1, season1);
    super.addDetail(series1, season2);
    super.addDetail(series1, season3);
    super.addDetail(season1, episode1);
    super.addDetail(season1, episode2);
    super.addDetail(season1, episode3);
    super.addDetail(season1, episode4);
  }
}

abstract class BLoCEvents {}

class AddItem extends BLoCEvents {
  AddItem(
    this.parent,
    this.child,
  );
  final Shows? parent;
  final Shows child;
}

class CollectionBloc extends Bloc<BLoCEvents, InitialState> {
  CollectionBloc() : super(InitialState()) {
    on<AddItem>(
        (event, emit) => emit(state..addDetail(event.parent, event.child)));
  }
}
