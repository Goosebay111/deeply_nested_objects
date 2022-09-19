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

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
                  // setState(() {
                    if (state.allHierarchy(state)[index].showType ==
                        ShowType.collection) {
                      BlocProvider.of<CollectionBloc>(context).add(AddItem(
                          null,
                          Shows(
                            name:
                                "Series ${state.getChildren(state.allHierarchy(state)[index]).length + 1}",
                            parent: state.allHierarchy(state)[index].name,
                            showType: ShowType.series,
                            children: [],
                          )));
                    }
                  // });
                  if (state.allHierarchy(state)[index].showType ==
                      ShowType.series) {
                    BlocProvider.of<CollectionBloc>(context).add(AddItem(
                        state.allHierarchy(state)[index],
                        Shows(
                          name:
                              'Season ${state.getChildren(state.allHierarchy(state)[index]).length + 1}',
                          parent: state.allHierarchy(state)[index].name,
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
                              "Episode ${state.getChildren(state.allHierarchy(state)[index]).length + 1}",
                          parent: state.allHierarchy(state)[index].name,
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
            onPressed: () {
              // todo: the getShow will allow us to access the Shows that we need for the addDetail function.
              // todo: this will be necessary for the copyWith approach when updating the state.
              // todo: the approach is to use the parent name to get the parent show.
              // todo: then use the parent show in conjunction with the addDetail method to add the new show.

              // InitialState copiedState = copyState(state);
              // copiedState.allHierarchy(copiedState).forEach(
              //   (element) {
              //     print(element.name);
              //   },
              // );
              //  BlocProvider.of<CollectionBloc>(context).add(CopyWith(copiedState));
              //   var toJson = state.toJson();
              //   var fromJson = Shows.fromJson(toJson);
            },
          ),
        );
      },
    );
  }
}

// InitialState copyState(state) {
//   InitialState initState = InitialState();
//   List<Shows> items = state.allHierarchy(state);
//   for (var element in items) {
//     Shows itemModel = state.getShow(element.name, items);
//     if (element.parent == null) {
//       print('name: ${itemModel.name} has a null parent');
//     } else {
//       Shows parentModel = state.getShow(element.parent, items);
//       Shows childModel = Shows(
//         name: element.name,
//         parent: element.parent,
//         showType: element.showType,
//         children: [],
//       );
//       initState.addDetail(parentModel, childModel);
//     }
//   }
//   return initState;
// }

class TextWidget extends StatelessWidget {
  const TextWidget({super.key, required this.name});
  final String name;

  @override
  Widget build(BuildContext context) {
    return Text(name);
  }
}
