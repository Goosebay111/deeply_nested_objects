import 'package:deeply_nested_objects/bloc/collection_state.dart';

abstract class CollectionEvents {}

class AddInfo extends CollectionEvents {
  AddInfo({required this.child, required this.index});

  final CollectionState child;
  final int index;
}
