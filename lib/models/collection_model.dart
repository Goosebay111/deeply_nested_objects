// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

enum ShowType { collection, series, season, episode }


class Shows {
  const Shows({
    required this.name,
    required this.parent,
    required this.children,
    required this.showType,
  });
  final String name;
  final String? parent;
  final List<Shows> children;
  final ShowType showType;

  void addDetail(Shows? parent, Shows child) {
    if (parent == null) {
      children.add(child);
    } else {
      parent.children.add(child);
    }
  }

  List<String> getAllChildrenNames(Shows show) {
    List<String> allChildren = [];
    for (var element in show.children) {
      allChildren.add(element.name);
      allChildren.addAll(getAllChildrenNames(element));
    }
    return allChildren;
  }

  List<Shows> allHierarchy(Shows node) {
    List<Shows> list = [];
    list.add(node);
    for (Shows child in node.children) {
      list.addAll(allHierarchy(child));
    }
    return list;
  }

  Shows getShow(String name, List<Shows> shows) {
    
    return shows.firstWhere((element) => element.name == name);
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
      'parent': parent,
      'showType': showType,
      'children': children.map((child) => child.toJson()).toList(),
    };
  }

  factory Shows.fromJson(Map<String, dynamic> json) {
    return Shows(
        name: json['name'],
        parent: json['parent'],
        showType: json['showType'],
        children: json['children']
            .map<Shows>((child) => Shows.fromJson(child))
            .toList());
  }

  

  Shows copyWith({
    String? name,
    String? parent,
    List<Shows>? children,
    ShowType? showType,
  }) {
    return Shows(
      name: name ?? this.name,
      parent: parent ?? this.parent,
      children: children ?? this.children,
      showType: showType ?? this.showType,
    );
  }
}
