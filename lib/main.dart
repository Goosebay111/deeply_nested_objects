import 'package:deeply_nested_objects/bloc/add_to_collection_logic.dart';
import 'package:deeply_nested_objects/bloc/collection_bloc.dart';
import 'package:deeply_nested_objects/bloc/collection_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CollectionBloc(),
      child: const MaterialApp(
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CollectionBloc, CollectionState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Deeply nested data and Bloc 8.0.0+'),
          ),
          body: ListView.builder(
            itemCount: state.getAllNodesOfParent(parent: state).length,
            itemBuilder: (context, index) {
              var nodes = state.getAllNodesOfParent(parent: state)[index];
              Color textColor = getColor(nodes);
              double distance = getPaddingDistance(nodes);
              return Padding(
                padding: EdgeInsets.only(left: distance),
                child: ListTile(
                  onTap: () => addToCollectionLogic(
                    parentNode: nodes,
                    showType: nodes.showType,
                    context: context,
                  ),
                  leading: Card(
                    child: Text(
                      nodes.name,
                      style: TextStyle(color: textColor),
                    ),
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
