import 'package:deeply_nested_objects/enums/show_type_enum.dart';

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

  // return a json representation of the object
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'webAddress': webAddress,
      'children': children,
      'showType': showType.toString(),
    };
  }

  // return a new object from a json representation
  factory CollectionState.fromJson(Map<String, dynamic> json) {
    return CollectionState(
      name: json['name'],
      webAddress: json['webAddress'],
      children: json['children'],
      showType: json['showType'] as ShowType,
    );
  }
}
