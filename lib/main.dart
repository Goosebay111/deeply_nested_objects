import 'package:deeply_nested_objects/blocs/collection_bloc.dart';
import 'package:deeply_nested_objects/models/collection_model.dart';
import 'package:deeply_nested_objects/text_widget.dart';
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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CollectionBloc, Collection>(
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
                  setState(() {
                    if (state.allHierarchy(state)[index].showType ==
                        ShowType.collection) {
                      BlocProvider.of<CollectionBloc>(context)
                          .add(AddSeries(Collection(
                        name: "Series ${state.getChildren(state.allHierarchy(state)[index]).length + 1}",
                        showType: ShowType.series,
                      )));
                    }
                  });
                  if (state.allHierarchy(state)[index].showType ==
                      ShowType.series) {
                    BlocProvider.of<CollectionBloc>(context).add(AddSeason(
                        series: state.allHierarchy(state)[index],
                        season: Collection(
                          name: 'Season ${state.getChildren(state.allHierarchy(state)[index]).length + 1}',
                          showType: ShowType.season,
                        )));
                  }
                  if (state.allHierarchy(state)[index].showType ==
                      ShowType.season) {
                    BlocProvider.of<CollectionBloc>(context).add(AddEpisode(
                        season: state.allHierarchy(state)[index],
                        episode: Collection(
                          name: "Episode ${state.getChildren(state.allHierarchy(state)[index]).length + 1}",
                          showType: ShowType.episode,
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
