import 'package:deeply_nested_objects/bloc/collection_state.dart';
import 'package:equatable/equatable.dart';

abstract class CollectionEvents extends Equatable {
  @override
  List<Object> get props => [];
}

class AddInfo extends CollectionEvents {
  AddInfo({required this.index, required this.child});

  final int index;
  final CollectionState child;
}
