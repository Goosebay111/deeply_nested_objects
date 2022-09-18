// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:deeply_nested_objects/models/collection_model.dart';

class InitialState extends Shows {
  InitialState()
      : super(
          name: "Collection 1",
          showType: ShowType.collection,
        ) {
    Shows series1 = Shows(
      name: "Series 1",
      showType: ShowType.series,
    );
    Shows season1 = Shows(
      name: "Season 1",
      showType: ShowType.season,
    );
    Shows season2 = Shows(
      name: "Season 2",
      showType: ShowType.season,
    );
    Shows season3 = Shows(
      name: "Season 3",
      showType: ShowType.season,
    );
    Shows episode1 = Shows(
      name: "Episode 1",
      showType: ShowType.episode,
    );
    Shows episode2 = Shows(
      name: "Episode 2",
      showType: ShowType.episode,
    );
    Shows episode3 = Shows(
      name: "Episode 3",
      showType: ShowType.episode,
    );
    Shows episode4 = Shows(
      name: "Episode 4",
      showType: ShowType.episode,
    );

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

// class AddSeries extends BLoCEvents {
//   AddSeries(this.series);
//   final Shows series;
// }

// class AddSeason extends BLoCEvents {
//   AddSeason({required this.series, required this.season});
//   final Shows series;
//   final Shows season;
// }

// class AddEpisode extends BLoCEvents {
//   AddEpisode({required this.season, required this.episode});
//   final Shows season;
//   final Shows episode;
// }

class CollectionBloc extends Bloc<BLoCEvents, InitialState> {
  CollectionBloc() : super(InitialState()) {
    on<AddItem>((event, emit) => emit(state..addDetail(event.parent, event.child)));
    // on<AddSeries>(
    //     ((event, emit) => emit(state..addDetail(null, event.series))));
    // on<AddSeason>(
    //     ((event, emit) => emit(state..addDetail(event.series, event.season))));
    // on<AddEpisode>(
    //     ((event, emit) => emit(state..addDetail(event.season, event.episode))));
  }
}
