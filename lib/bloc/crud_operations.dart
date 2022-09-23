import 'package:deeply_nested_objects/bloc/collection_bloc.dart';
import 'package:deeply_nested_objects/bloc/collection_event.dart';
import 'package:deeply_nested_objects/naming_dialog_box.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void updateNode({
  required name,
  required parent,
  required context,
}) async {
  String? newName = await namingDialogBox(
    context: context,
    currentText: name,
    newRequest: 'Rename Collection',
  );

  BlocProvider.of<CollectionBloc>(context).add(
    RenameNode(
      newName: newName ?? name,
      parent: parent,
    ),
  );
}
