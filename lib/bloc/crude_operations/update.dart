import 'package:deeply_nested_objects/bloc/collection_bloc.dart';
import 'package:deeply_nested_objects/bloc/collection_event.dart';
import 'package:deeply_nested_objects/bloc/collection_state.dart';
import 'package:deeply_nested_objects/naming_dialog_box.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void updateNode({
  required String name,
  required CollectionState parent,
  required context,
}) async {
  
  String? newName = await namingDialogBox(
    context: context,
    currentText: name,
    newRequest: 'Rename Collection',
  );

  BlocProvider.of<CollectionBloc>(context).add(
    UpdateNode(
      newName: newName ?? name,
      parent: parent,
    ),
  );
}
