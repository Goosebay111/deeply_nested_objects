abstract class CollectionEvent {}

class AddSeries extends CollectionEvent {
  AddSeries({required this.index});
  final int index;
}

class AddSeason extends CollectionEvent {
  AddSeason({required this.index});
  final int index;
}

class AddEpisode extends CollectionEvent {
  AddEpisode({required this.index, required this.index2});
  final int index;
  final int index2;
}


