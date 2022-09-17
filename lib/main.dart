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
                  // TODO: setState function is here.
                  setState(() {
                    if (showType == ShowType.collection) {
                      BlocProvider.of<CollectionBloc>(context).add(AddSeries(
                          series: Collection(
                        name:
                            "Series ${state.getChildrenOfNode(state.hierarchy(state)[index]).length + 1}",
                        showType: ShowType.series,
                        children: [],
                      )));
                      BlocProvider.of<CollectionBloc>(context).add(UpdateBloc(collection: state));
                    }
                  
                  if (showType == ShowType.series) {
                    BlocProvider.of<CollectionBloc>(context).add(AddSeason(
                        series: state.hierarchy(state)[index],
                        season: Collection(
                          name:
                              'Season ${state.getChildrenOfNode(state.hierarchy(state)[index]).length + 1}',
                          showType: ShowType.season,
                          children: [],
                        )));
                  }
                  if (showType == ShowType.season) {
                    BlocProvider.of<CollectionBloc>(context).add(AddEpisode(
                        season: state.hierarchy(state)[index],
                        episode: Collection(
                          name:
                              "Episode ${state.getChildrenOfNode(state.hierarchy(state)[index]).length + 1}",
                          showType: ShowType.episode,
                          children: [],
                        )));
                  }
                  });
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

/// BLoC

class InitialState extends Collection {
  InitialState(collection)
      : super(
          name: collection.name,
          showType: collection.showType,
          children: collection.children,
        );
}

abstract class BLoCEvents {}

class AddSeries extends BLoCEvents {
  AddSeries({required this.series});
  final Collection series;
}

class AddSeason extends BLoCEvents {
  AddSeason({required this.series, required this.season});
  final Collection series;
  final Collection season;
}

class AddEpisode extends BLoCEvents {
  AddEpisode({required this.season, required this.episode});
  final Collection season;
  final Collection episode;
}

class UpdateBloc extends BLoCEvents {
  UpdateBloc({required this.collection});
  final Collection collection;
}

class CollectionBloc extends Bloc<BLoCEvents, InitialState> {
  CollectionBloc()
      : super(InitialState(Collection(
            name: 'Collection', showType: ShowType.collection, children: []))) {
    on<AddSeries>(
        ((event, emit) => emit(state..addSeries(series: event.series))));
    on<AddSeason>(((event, emit) =>
        emit(state..addSeason(series: event.series, season: event.season))));
    on<AddEpisode>(((event, emit) =>
        emit(state..addEpisode(season: event.season, episode: event.episode))));
    ///todo: update bloc here.
    on<UpdateBloc>(((event, emit) => print(state.toJson())));
  }
}

/// Model

enum ShowType { collection, series, season, episode }

class Collection {
  Collection(
      {required this.name, required this.showType, required this.children});
  final String name;
  final ShowType showType;
  List<Collection> children = [];

  void addSeries({required Collection series}) => children.add(series);

  void addSeason({required Collection series, required Collection season}) =>
      series.children.add(season);

  void addEpisode({required Collection season, required Collection episode}) =>
      season.children.add(episode);

  List<Collection> hierarchy(Collection node) {
    List<Collection> list = [];
    list.add(node);
    for (Collection child in node.children) {
      list.addAll(hierarchy(child));
    }
    return list;
  }

  List<Collection> getChildrenOfNode(Collection node) {
    List<Collection> list = [];
    for (Collection child in node.children) {
      list.add(child);
    }
    return list;
  }

  toJson() {
    return {
      'name': name,
      'showType': showType,
      'children': children.map((child) => child.toJson()).toList(),
    };
  }

  factory Collection.fromJson(Map<String, dynamic> json) {
    return Collection(
        name: json['name'],
        showType: json['showType'],
        children: json['children']
            .map<Collection>((child) => Collection.fromJson(child))
            .toList());
  }

  @override
  String toString() {
    return 'Collection{name: $name, showType: $showType, children: $children}';
  }
}