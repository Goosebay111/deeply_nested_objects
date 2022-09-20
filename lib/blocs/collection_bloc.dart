// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:deeply_nested_objects/models/collection_model.dart';

// class InitialState extends Shows {
//   InitialState()
//       : super(
//           name: "Collection 1",
//           parent: null,
//           showType: ShowType.collection,
//           children: [],
//         ) {
    // var series1 = Shows(
    //   name: "Series 1",
    //   parent: "Collection 1",
    //   showType: ShowType.series,
    //   children: [],
    // );
    // var season1 = Shows(
    //   name: "Season 1",
    //   parent: 'Series 1',
    //   showType: ShowType.season,
    //   children: [],
    // );
    // var episode1 = Shows(
    //   name: "Episode 1",
    //   parent: "Season 1",
    //   showType: ShowType.episode,
    //   children: [],
    // );
    // var episode2 = Shows(
    //   name: "Episode 2",
    //   parent: "Season 1",
    //   showType: ShowType.episode,
    //   children: [],
    // );
    // var episode3 = Shows(
    //   name: "Episode 3",
    //   parent: "Season 1",
    //   showType: ShowType.episode,
    //   children: [],
    // );
    // var episode4 = Shows(
    //   name: "Episode 4",
    //   parent: "Season 1",
    //   showType: ShowType.episode,
    //   children: [],
    // );

    // todo: This looks like an example of a tree structure.
    // todo: I am betting that the composite design pattern can be used here.

    // super.addDetail(null, series1);
    // super.addDetail(series1, season1);
    // super.addDetail(season1, episode1);
    // super.addDetail(season1, episode2);
    // super.addDetail(season1, episode3);
    // super.addDetail(season1, episode4);
//   }
// }

abstract class BLoCEvents {}

class AddItem extends BLoCEvents {
  AddItem(
    this.parent,
    this.child,
  );
  final Shows? parent;
  final Shows child;
}

class CopyWith extends BLoCEvents {
  CopyWith(this.newState);
  final Shows newState;
}

class CollectionBloc extends Bloc<BLoCEvents, Shows> {
  CollectionBloc() : super(Shows.initial()) {
    // TODO: to get this to work, we need to change the state here with a copyWith strategy...

    on<AddItem>((event, emit) {
      emit(state.copyWith(
        children: [
          ...state.children,
          event.child,
        ],
      ));
     //emit(state..addDetail(event.parent, event.child));
    });
    
  }
}
