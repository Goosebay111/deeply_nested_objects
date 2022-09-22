import 'package:equatable/equatable.dart';

enum ShowType { collection, series, season, episode }

class CollectionState extends Equatable {
  const CollectionState({
    required this.name,
    required this.children,
    required this.showType,
    required this.heartbeats, // hack to get Equatable to work
  });
  final String name;
  final List<CollectionState> children;
  final ShowType showType;
  final int heartbeats;

  factory CollectionState.initial() {
    return const CollectionState(
      name: "Collection",
      showType: ShowType.collection,
      children: [],
      heartbeats: 0,
    );
  }

  List<CollectionState> getAllNodes(CollectionState node) {
    // empty list to store the result
    List<CollectionState> result = [];
    // add the current node
    result.add(node);
    // add the children too
    for (CollectionState child in node.children) {
      // composite design pattern seek and find
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
      heartbeats: heartbeats + 1,
    );
  }

  @override
  List<Object> get props => [name, children, showType, heartbeats];
}
