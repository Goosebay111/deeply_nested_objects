import 'package:deeply_nested_objects/models/collection_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InitialState extends Collection {
  InitialState()
      : super(
          name: "Collection 1",
          showType: ShowType.collection,
        ) {
    // TODO: implement collection here during initialization.
    // Collection series1 = Collection(
    //     name: "Series 1",
    //     showType: ShowType.series,
    //     widget: const TextWidget(name: 'Series 1'));
    // Collection season1 = Collection(
    //     name: "Season 1",
    //     showType: ShowType.season,
    //     widget: const TextWidget(name: 'Season 1'));
    // Collection season2 = Collection(
    //     name: "Season 2",
    //     showType: ShowType.season,
    //     widget: const TextWidget(name: 'Season 2'));
    // Collection season3 = Collection(
    //     name: "Season 3",
    //     showType: ShowType.season,
    //     widget: const TextWidget(name: 'Season 3'));
    // Collection episode1 = Collection(
    //     name: "Episode 1",
    //     showType: ShowType.episode,
    //     widget: const TextWidget(name: 'Episode 1'));
    // Collection episode2 = Collection(
    //     name: "Episode 2",
    //     showType: ShowType.episode,
    //     widget: const TextWidget(name: 'Episode 2'));
    // Collection episode3 = Collection(
    //     name: "Episode 3",
    //     showType: ShowType.episode,
    //     widget: const TextWidget(name: 'Episode 3'));
    // Collection episode4 = Collection(
    //     name: "Episode 4",
    //     showType: ShowType.episode,
    //     widget: const TextWidget(name: 'Episode 4'));

    // super.addSeries(series: series1);
    // super.addSeason(series: series1, season: season1);
    // super.addSeason(series: series1, season: season2);
    // super.addSeason(series: series1, season: season3);
    // super.addEpisode(season: season1, episode: episode1);
    // super.addEpisode(season: season1, episode: episode2);
    // super.addEpisode(season: season1, episode: episode3);
    // super.addEpisode(season: season1, episode: episode4);
  }
}

abstract class BLoCEvents {}

class AddSeries extends BLoCEvents {
  AddSeries({required this.series});
  final Collection series;
}

class AddSeason extends BLoCEvents {
  AddSeason({required this.series, required this.season});
  final Collection series;
  final Collection season;
}

class AddEpisode extends BLoCEvents {
  AddEpisode({required this.season, required this.episode});
  final Collection season;
  final Collection episode;
}

class CollectionBloc extends Bloc<BLoCEvents, InitialState> {
  CollectionBloc() : super(InitialState()) {
    on<AddSeries>(
        ((event, emit) => emit(state..addSeries(series: event.series))));
    on<AddSeason>(((event, emit) =>
        emit(state..addSeason(series: event.series, season: event.season))));
    on<AddEpisode>(((event, emit) =>
        emit(state..addEpisode(season: event.season, episode: event.episode))));
  }
}
