import 'package:deeply_nested_objects/bloc/collection_state.dart';
import 'package:equatable/equatable.dart';

abstract class CollectionEvents extends Equatable {
  @override
  List<Object> get props => [];
}

class AddToTopLayerData extends CollectionEvents {
  AddToTopLayerData({
    required this.newChild,
  });
  final CollectionState newChild;
}

class AddToDeeplyNestedData extends CollectionEvents {
  AddToDeeplyNestedData({
    required this.newChild,
    required this.parent,
  });

  final CollectionState newChild;
  final CollectionState parent;
}

class UpdateNode extends CollectionEvents {
  UpdateNode({
    required this.newName,
    required this.parent,
  });

  final CollectionState parent;
  final String newName;
}

class DeleteNode extends CollectionEvents {
  DeleteNode({
    required this.parent,
  });

  final CollectionState parent;
}
