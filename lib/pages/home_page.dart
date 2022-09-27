import 'package:deeply_nested_objects/bloc/collection/collection_bloc.dart';
import 'package:deeply_nested_objects/bloc/collection/collection_state.dart';
import 'package:deeply_nested_objects/bloc/logic_of_crude_operations/create.dart';
import 'package:deeply_nested_objects/bloc/logic_of_crude_operations/update.dart';
import 'package:deeply_nested_objects/logic_of_crude_operations/delete.dart';
import 'package:deeply_nested_objects/logic_of_crude_operations/read.dart';
import 'package:deeply_nested_objects/enums/show_type_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CollectionBloc, CollectionState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: false,
            leadingWidth: 0.0,
            title: const Text('ToView App with Bloc 8.0.0+'),
          ),
          body: ListView.separated(
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemCount:
                getAllNodesOfParentExcludingParent(parentNode: state).length +
                    1,
            itemBuilder: (context, index) {
              if (!(index <
                  getAllNodesOfParentExcludingParent(parentNode: state)
                      .length)) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.add_circle_outline,
                        size: 50,
                      ),
                      onPressed: () async {
                        createNode(parentNode: state, context: context);
                      },
                    ),
                  ],
                );
              }
              var node =
                  getAllNodesOfParentExcludingParent(parentNode: state)[index];
              Color textColor = getColor(node);
              double distance = getPaddingDistance(node);
              return Padding(
                padding: EdgeInsets.only(left: distance),
                child: ListTile(
                  onTap: () => createNode(
                    parentNode: node,
                    context: context,
                  ),
                  onLongPress: () {
                    updateNodeName(parent: node, context: context);
                  },
                  leading: Card(
                    child: Text(
                      node.name,
                      style: TextStyle(color: textColor),
                    ),
                  ),
                  trailing: node.showType == ShowType.collection
                      ? null
                      : IconButton(
                          icon: const Icon(
                            Icons.remove_circle_outline_outlined,
                          ),
                          onPressed: () =>
                              deleteNode(parent: node, context: context),
                        ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  double getPaddingDistance(CollectionState nodes) {
    switch (nodes.showType) {
      case ShowType.collection:
        return 0;
      case ShowType.series:
        return 20;
      case ShowType.season:
        return 40;
      case ShowType.episode:
        return 60;
    }
  }

  Color getColor(CollectionState nodes) {
    switch (nodes.showType) {
      case ShowType.collection:
        return Colors.black;
      case ShowType.series:
        return Colors.blue;
      case ShowType.season:
        return Colors.green;
      case ShowType.episode:
        return Colors.red;
    }
  }
}
