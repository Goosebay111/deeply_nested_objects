import 'package:flutter/material.dart';

enum ShowType { collection, series, season, episode }

class Collection {
  Collection(
      {required this.name, 
      // required this.widget, 
      required this.showType});
  final String name;
  List<Collection> children = [];
  //final Widget widget;
  final ShowType showType;

  void addSeries({required Collection series}) => children.add(series);

  void addSeason({required Collection series, required Collection season}) =>
      series.children.add(season);

  void addEpisode({required Collection season, required Collection episode}) =>
      season.children.add(episode);

  List<Collection> allHierarchy(Collection node) {
    List<Collection> list = [];
    list.add(node);
    for (Collection child in node.children) {
      list.addAll(allHierarchy(child));
    }
    return list;
  }

  // return the children of a node that might be a series, season, or episode
  List<Collection> getChildren(Collection node) {
    List<Collection> list = [];
    for (Collection child in node.children) {
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

  factory Collection.fromJson(Map<String, dynamic> json) {
    return Collection(
      name: json['name'],
     
      showType: json['showType'],
    )..children = json['children']
        .map<Collection>((child) => Collection.fromJson(child))
        .toList();
  }
}
