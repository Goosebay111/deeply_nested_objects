enum ShowType { collection, series, season, episode }

class CollectionState {
  const CollectionState(
    {
    required this.name,
    required this.webAddress,
    required this.children,
    required this.showType,
  });
  final String name;
  final String? webAddress;
  final List<CollectionState> children;
  final ShowType showType;

  factory CollectionState.initial() {
    return const CollectionState(
      name: "Collection",
      webAddress: null,
      showType: ShowType.collection,
      children: [],
    );
  }

  CollectionState copyWith({
    String? name,
    String? webAddress,
    List<CollectionState>? children,
    ShowType? showType,
  }) {
    return CollectionState(
      name: name ?? this.name,
      webAddress: webAddress ?? webAddress,
      children: children ?? this.children,
      showType: showType ?? this.showType,
    );
  }
}
