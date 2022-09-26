// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:deeply_nested_objects/enums/show_type_enum.dart';
import 'package:deeply_nested_objects/helper_functions/get_show_type.dart';

class CollectionState {
  const CollectionState({
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

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'webAddress': webAddress,
      'children': children.map((e) => e.toJson()).toList(),
      'showType': showType.toString(),
    };
  }

  factory CollectionState.fromJson(Map<String, dynamic> json) {
    return CollectionState(
      name: json['name'] as String,
      webAddress:
          json['webAddress'] != null ? json['webAddress'] as String : null,
      children: List<CollectionState>.from(
        (json['children']).map<CollectionState>(
          (child) => CollectionState.fromJson(child as Map<String, dynamic>),
        ),
      ),
      showType: getShowType(json['showType']) as ShowType,
    );
  }
}
