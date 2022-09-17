enum ShowType { collection, season, series, episode }

abstract class CollectionState {}

class BaseState extends CollectionState {
  BaseState(
      {required this.counter, required this.children, required this.index});
  int counter;
  List<BaseState> children;

  int index;

  // add to children
  List<BaseState> addChild(BaseState series) {
    var result = children;
    result.add(series);
    return result;
  }


  addChildToChild(int index, BaseState child) {
    var result = children;
    result[index].children.add(child);
    return result;
  }

  //add child to child to child
  addChildToChildToChild(int index, int index2, BaseState child) {
    var result = children;
    result[index].children[index2].children.add(child);
    return result;
  }

  List<int> get allCounters {
    List<int> allCounters = [];
    allCounters.add(counter);
    for (var i = 0; i < children.length; i++) {
      allCounters.addAll(children[i].allCounters);
    }
    return allCounters;
  }
}

class CollectionInitial extends BaseState {
  CollectionInitial(ShowType showType)
      : super(
          index: 0,
          counter: 0,
          children: [
            BaseState(
              index: 0,
              counter: 0,
              children: [],
            )
          ],
        );
}
