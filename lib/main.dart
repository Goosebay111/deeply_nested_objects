import 'package:deeply_nested_objects/blocs/collection_bloc.dart';
import 'package:deeply_nested_objects/models/collection_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

main() {
  runApp(const MyApp());
}

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

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CollectionBloc, Collection>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Flutter Demo Home Page'),
          ),
          body: ListView.builder(
            itemCount: state.hierarchy(state).length,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {
                  var showType = state.hierarchy(state)[index].showType;
                  setState(() {
                    /// Determine which type of show is added to its parent.
                    /// The logic for the addition happens in the model.
                    /// The problem that I have here is that the setState is still being required to be used.
                    /// todo: research to see if a future/stream builder is needed here.
                    if (showType == ShowType.collection) {
                      BlocProvider.of<CollectionBloc>(context).add(AddSeries(
                          series: Collection(
                        name:
                            "Series ${state.nodeChildren(state.hierarchy(state)[index]).length + 1}",
                        showType: ShowType.series,
                      )));
                    }
                  });
                  if (showType == ShowType.series) {
                    BlocProvider.of<CollectionBloc>(context).add(AddSeason(
                        series: state.hierarchy(state)[index],
                        season: Collection(
                          name:
                              'Season ${state.nodeChildren(state.hierarchy(state)[index]).length + 1}',
                          showType: ShowType.season,
                        )));
                  }
                  if (showType == ShowType.season) {
                    BlocProvider.of<CollectionBloc>(context).add(AddEpisode(
                        season: state.hierarchy(state)[index],
                        episode: Collection(
                          name:
                              "Episode ${state.nodeChildren(state.hierarchy(state)[index]).length + 1}",
                          showType: ShowType.episode,
                        )));
                  }
                },
                leading: Card(
                  child: TextWidget(name: state.hierarchy(state)[index].name),
                ),
              );
            },
          ),
          floatingActionButton: FloatingActionButton(
            child: const Text('to json'),
            onPressed: () {
              var toJson = state.toJson();
              var fromJson = Collection.fromJson(toJson);
              print(fromJson);
            },
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
