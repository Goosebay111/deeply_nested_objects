import 'package:deeply_nested_objects/bloc/collection_state.dart';

abstract class CollectionEvents {}

class AddItem extends CollectionEvents {
  AddItem(this.child);
  final CollectionState child;
}

class CopyWith extends CollectionEvents {
  CopyWith(this.newState);
  final CollectionState newState;
}
