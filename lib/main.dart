import 'package:deeply_nested_objects/bloc/collection/collection_bloc.dart';
import 'package:deeply_nested_objects/bloc/pages/home_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CollectionBloc(),
      child: MaterialApp(
        title: 'ToVo App',
        theme: ThemeData(
          brightness: Brightness.light,
          colorScheme: const ColorScheme.light(background: Colors.white),
          primaryColor: Colors.white,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            titleTextStyle:
                TextStyle(color: Colors.black87, fontWeight: FontWeight.w700),
          ),
        ),
        home: const MyHomePage(),
      ),
    );
  }
}
