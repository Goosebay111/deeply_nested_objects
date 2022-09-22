import 'package:deeply_nested_objects/bloc/collection_state.dart';
import 'package:equatable/equatable.dart';

abstract class CollectionEvents extends Equatable {
  @override
  List<Object> get props => [];
}

class AddToTopLayer extends CollectionEvents {
  AddToTopLayer({required this.index, required this.child});

  final int index;
  final CollectionState child;
}

class AddToNode extends CollectionEvents {
  AddToNode({required this.index, required this.child});

  final int index;
  final CollectionState child;
}
