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
      name: "Collection 1",
      showType: ShowType.collection,
      children: [],
    );
  }

  List<CollectionState> allHierarchy(CollectionState node) {
    List<CollectionState> list = [];
    list.add(node);
    for (CollectionState child in node.children) {
      list.addAll(allHierarchy(child));
    }
    return list;
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
