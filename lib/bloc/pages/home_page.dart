import 'package:deeply_nested_objects/bloc/collection/collection_bloc.dart';
import 'package:deeply_nested_objects/bloc/collection/collection_state.dart';
import 'package:deeply_nested_objects/bloc/logic_crude_operations/create.dart';
import 'package:deeply_nested_objects/bloc/logic_crude_operations/delete.dart';
import 'package:deeply_nested_objects/bloc/logic_crude_operations/read.dart';
import 'package:deeply_nested_objects/bloc/logic_crude_operations/update.dart';
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
            title: const Text('Deeply Nested Objects and BLoC'),
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
                        createNode(
                          parentNode: state,
                          showType: state.showType,
                          context: context,
                        );
                      },
                    ),
                  ],
                );
              }
              var nodes =
                  getAllNodesOfParentExcludingParent(parentNode: state)[index];
              Color textColor = getColor(nodes);
              double distance = getPaddingDistance(nodes);
              return Padding(
                padding: EdgeInsets.only(left: distance),
                child: ListTile(
                  onTap: () => createNode(
                    parentNode: nodes,
                    showType: nodes.showType,
                    context: context,
                  ),
                  onLongPress: () {
                    updateNodeName(
                      name: nodes.name,
                      parent: nodes,
                      showType: nodes.showType,
                      context: context,
                    );
                  },
                  leading: Card(
                    child: Text(
                      nodes.name,
                      style: TextStyle(color: textColor),
                    ),
                  ),
                  trailing: nodes.showType == ShowType.collection
                      ? null
                      : IconButton(
                          icon: const Icon(
                            Icons.remove_circle_outline_outlined,
                          ),
                          onPressed: () =>
                              deleteNode(parent: nodes, context: context),
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
