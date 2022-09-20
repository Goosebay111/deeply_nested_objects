enum ShowType { collection, series, season, episode }

class Shows {
  const Shows({
    required this.name,
    required this.children,
    required this.showType,
  });
  final String name;
  final List<Shows> children;
  final ShowType showType;

  factory Shows.initial() {
    return const Shows(
      name: "Collection 1",
      showType: ShowType.collection,
      children: [],
    );
  }

  List<Shows> allHierarchy(Shows node) {
    List<Shows> list = [];
    list.add(node);
    for (Shows child in node.children) {
      list.addAll(allHierarchy(child));
    }
    return list;
  }

  Shows copyWith({
    String? name,
    List<Shows>? children,
    ShowType? showType,
  }) {
    return Shows(
      name: name ?? this.name,
      children: children ?? this.children,
      showType: showType ?? this.showType,
    );
  }
}
