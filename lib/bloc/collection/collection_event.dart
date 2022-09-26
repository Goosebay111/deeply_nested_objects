import 'package:deeply_nested_objects/bloc/collection/collection_state.dart';
import 'package:equatable/equatable.dart';

abstract class CollectionEvents extends Equatable {
  @override
  List<Object> get props => [];
}

class AddToTopLayerData extends CollectionEvents {
  AddToTopLayerData({required this.newChild});

  final CollectionState newChild;
}

class AddToDeeplyNestedData extends CollectionEvents {
  AddToDeeplyNestedData({required this.newChild, required this.parent});

  final CollectionState newChild;
  final CollectionState parent;
}

class UpdateNodeName extends CollectionEvents {
  UpdateNodeName({required this.newName, required this.parent});

  final String newName;
  final CollectionState parent;
}

class UpdateNodeWebAddress extends CollectionEvents {
  UpdateNodeWebAddress({required this.newWebAddress, required this.parent});

  final String? newWebAddress;
  final CollectionState parent;
}

class DeleteFromNestedNode extends CollectionEvents {
  DeleteFromNestedNode({required this.parent});

  final CollectionState parent;
}

class DeleteFromParentNode extends CollectionEvents {
  DeleteFromParentNode({required this.parent});

  final CollectionState parent;
}
