import 'package:deeply_nested_objects/bloc/collection/collection_bloc.dart';
import 'package:deeply_nested_objects/bloc/collection/collection_event.dart';
import 'package:deeply_nested_objects/bloc/collection/collection_state.dart';
import 'package:deeply_nested_objects/enums/show_type_enum.dart';
import 'package:deeply_nested_objects/helper_functions/naming_dialog_box.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



void updateNodeName({required CollectionState parent, required context}) async {
  if (parent.showType == ShowType.collection) {
    return;
  }

  String? newName = await namingDialogBox(
    context: context,
    currentText: parent.name,
    newRequest: 'Rename Collection',
  );

  BlocProvider.of<CollectionBloc>(context).add(
    UpdateNodeName(
      newName: newName ?? parent.name,
      parent: parent,
    ),
  );
}

void updateNodeWebAddress(
    {required String? webAddress,
    required CollectionState parent,
    required ShowType showType,
    required context}) async {
  if (showType == ShowType.collection) {
    return;
  }

  String? newWebAddress = await namingDialogBox(
    context: context,
    currentText: webAddress ?? '',
    newRequest: 'Add YouTube Link',
    youTube: true,
  );

  BlocProvider.of<CollectionBloc>(context).add(
    UpdateNodeWebAddress(
      newWebAddress: newWebAddress ?? webAddress,
      parent: parent,
    ),
  );
}
