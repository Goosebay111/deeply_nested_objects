import 'package:deeply_nested_objects/bloc/collection_state.dart';
import 'package:equatable/equatable.dart';

abstract class CollectionEvents extends Equatable {
  @override
  List<Object> get props => [];
}

class AddToTopLayer extends CollectionEvents {
  AddToTopLayer({
    required this.newChild,
  });
  final CollectionState newChild;
}

class AddToNode extends CollectionEvents {
  AddToNode({
    required this.newChild,
    required this.parent,
  });

  final CollectionState newChild;
  final CollectionState parent;
}
