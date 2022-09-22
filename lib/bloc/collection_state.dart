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

  List<CollectionState> getAllNodes(CollectionState node) {
    // create an empty list to store the result
    List<CollectionState> result = [];
    // add the current node
    result.add(node);
    // add the children too
    for (CollectionState child in node.children) {
      // composite design pattern seek and find
      // goes down the rabbit hole until it finds the bottom
      result.addAll(getAllNodes(child));
    }
    return result;
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
