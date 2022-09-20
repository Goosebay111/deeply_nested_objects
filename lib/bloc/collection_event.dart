import 'package:deeply_nested_objects/bloc/collection_state.dart';

abstract class CollectionEvents {}

class AddItem extends CollectionEvents {
  AddItem(this.child, this.index);
  final CollectionState child;
  final int index;
}
