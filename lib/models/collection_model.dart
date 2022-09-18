enum ShowType { collection, series, season, episode }

class Shows {
  Shows({required this.name, required this.showType, required this.children});
  final String name;
  final List<Shows> children;
  final ShowType showType;

  void addDetail(Shows? parent, Shows child) {
    if (parent == null) {
      children.add(child);
    } else {
      parent.children.add(child);
    }
  }

  List<Shows> allHierarchy(Shows node) {
    List<Shows> list = [];
    list.add(node);
    for (Shows child in node.children) {
      list.addAll(allHierarchy(child));
    }
    return list;
  }

  // return the children of a node that might be a series, season, or episode
  List<Shows> getChildren(Shows node) {
    List<Shows> list = [];
    for (Shows child in node.children) {
      list.add(child);
    }
    return list;
  }

  toJson() {
    return {
      'name': name,
      'showType': showType,
      'children': children.map((child) => child.toJson()).toList(),
    };
  }

  factory Shows.fromJson(Map<String, dynamic> json) {
    return Shows(
        name: json['name'],
        showType: json['showType'],
        children: json['children']
            .map<Shows>((child) => Shows.fromJson(child))
            .toList());
  }
}
