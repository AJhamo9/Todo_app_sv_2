import 'package:flutter/material.dart';
import 'package:nyttprojektlen/data_fetcher.dart';
import 'package:nyttprojektlen/home.dart';
import 'data_fetcher.dart';
import 'package:provider/provider.dart';

void main() {
  var state = MyState();
  state.getnotes();
  runApp(ChangeNotifierProvider(
    create: (context) => state,
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To-do',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: Hemma(),
    );
  }
}
