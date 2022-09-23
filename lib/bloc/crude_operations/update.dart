import 'package:deeply_nested_objects/bloc/collection/collection_bloc.dart';
import 'package:deeply_nested_objects/bloc/collection/collection_event.dart';
import 'package:deeply_nested_objects/bloc/collection/collection_state.dart';
import 'package:deeply_nested_objects/naming_dialog_box.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void updateNode({
  required String name,
  required CollectionState parent,
  required ShowType showType,
  required context,
}) async {
  if (showType == ShowType.collection) {
    return;
  }

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
