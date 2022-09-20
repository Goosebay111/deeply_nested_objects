import 'dart:math';

import 'package:deeply_nested_objects/blocs/collection_bloc.dart';
import 'package:deeply_nested_objects/models/collection_model.dart';
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
    return BlocBuilder<CollectionBloc, Shows>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Flutter Demo Home Page'),
          ),
          body: ListView.builder(
            itemCount: state.allHierarchy(state).length,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {
                  if (state.allHierarchy(state)[index].showType ==
                      ShowType.collection) {
                    BlocProvider.of<CollectionBloc>(context).add(AddItem(
                        null,
                        Shows(
                          name:
                              "Series ${(1000 + Random().nextInt(9000))}",
                          showType: ShowType.series,
                          children: [],
                        )));
                  }

                  if (state.allHierarchy(state)[index].showType ==
                      ShowType.series) {
                    BlocProvider.of<CollectionBloc>(context).add(AddItem(
                        state.allHierarchy(state)[index],
                        Shows(
                          name:
                              'Season ${(1000 + Random().nextInt(9000))}',
                          showType: ShowType.season,
                          children: [],
                        )));
                  }
                  if (state.allHierarchy(state)[index].showType ==
                      ShowType.season) {
                    BlocProvider.of<CollectionBloc>(context).add(AddItem(
                        state.allHierarchy(state)[index],
                        Shows(
                          name:
                              "Episode ${(1000 + Random().nextInt(9000))}",
                          showType: ShowType.episode,
                          children: [],
                        )));
                  }
                },
                leading: Card(
                  child:
                      TextWidget(name: state.allHierarchy(state)[index].name),
                ),
              );
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
          ),
        );
      },
    );
  }
}

class TextWidget extends StatelessWidget {
  const TextWidget({super.key, required this.name});
  final String name;

  @override
  Widget build(BuildContext context) {
    return Text(name);
  }
}
