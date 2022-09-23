import 'package:deeply_nested_objects/bloc/collection_bloc.dart';
import 'package:deeply_nested_objects/bloc/collection_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void deleteNode({
  required parent,
  required context,
}) async {
  BlocProvider.of<CollectionBloc>(context).add(
    DeleteNode(parent: parent),
  );
}
