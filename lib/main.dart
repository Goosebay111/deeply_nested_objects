import 'package:deeply_nested_objects/bloc/collection_bloc.dart';
import 'package:deeply_nested_objects/bloc/collection_event.dart';
import 'package:deeply_nested_objects/bloc/collection_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(const MyApp());

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
    return BlocBuilder<CollectionBloc, BaseState>(
      builder: (context, state) {
        return Scaffold(
          body: ListView.builder(
            itemCount: state.children.length,
            itemBuilder: (context, index) {
              return Column(
                children: state.children[index].allCounters
                    .map((e) => ListTile(
                          onTap: () {
                            
                            context
                                .read<CollectionBloc>()
                                .add(AddSeries(index: index));
                          },
                          onLongPress: () {
                            context
                                .read<CollectionBloc>()
                                .add(AddSeason(index: index));
                          },
                          title: Text(
                            e.toString(),
                            style: const TextStyle(fontSize: 30),
                          ),
                        ))
                    .toList(),
              );
            },
          ),
        );
      },
    );
  }
}
