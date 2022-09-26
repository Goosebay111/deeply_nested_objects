import 'package:deeply_nested_objects/enums/show_type_enum.dart';

getShowType(String showType) {
    switch (showType) {
      case 'ShowType.collection':
        return ShowType.collection;
      case 'ShowType.series':
        return ShowType.series;
      case 'ShowType.season':
        return ShowType.season;
      case 'ShowType.episode':
        return ShowType.episode;
      default:
        return ShowType.collection;
    }
  }