enum ShowType { collection, series, season, episode }

class CollectionState {
  const CollectionState({
    required this.name,
    required this.children,
    required this.showType,
  });
  final String name;
  final List<CollectionState> children;
  final ShowType showType;

  factory CollectionState.initial() {
    return const CollectionState(
      name: "Collection",
      showType: ShowType.collection,
      children: [],
    );
  }

  CollectionState copyWith({
    String? name,
    List<CollectionState>? children,
    ShowType? showType,
  }) {
    return CollectionState(
      name: name ?? this.name,
      children: children ?? this.children,
      showType: showType ?? this.showType,
    );
  }
}
