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
            itemCount: state.getAllNodes(state).length,
            itemBuilder: (context, index) {
              var nodes = state.getAllNodes(state)[index];
              Color textColor = getColor(nodes);
              double distance = getPaddingDistance(nodes);
              return Padding(
                padding: EdgeInsets.only(left: distance),
                child: ListTile(
                  onTap: () =>
                      addToCollectionLogic(nodes.showType, index, nodes.children.length + 1, context),
                  leading: Card(
                    child: Text(nodes.name, style: TextStyle(color: textColor)),
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
    double distance = nodes.showType == ShowType.collection
        ? 0.0
        : nodes.showType == ShowType.series
            ? 20
            : nodes.showType == ShowType.season
                ? 40
                : 60;
    return distance;
  }

  Color getColor(CollectionState nodes) {
    Color textColor = nodes.showType == ShowType.collection
        ? Colors.black87
        : nodes.showType == ShowType.series
            ? Colors.blue
            : nodes.showType == ShowType.season
                ? Colors.orange
                : Colors.green;
    return textColor;
  }
}
