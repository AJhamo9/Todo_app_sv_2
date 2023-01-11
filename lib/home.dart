import 'package:flutter/material.dart';
import 'package:nyttprojektlen/task.dart';
import 'package:nyttprojektlen/taskpage.dart';
import 'package:provider/provider.dart';
import 'data_fetcher.dart';
import '../textruta.dart';
import 'startknappar.dart';

class Hemma extends StatefulWidget {
  @override
  State<Hemma> createState() => _HemmaState();
}

class _HemmaState extends State<Hemma> {
  DataFetcher _dbHelper = DataFetcher();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('To DO'),
        iconTheme: IconThemeData(color: Colors.black),
        titleTextStyle: TextStyle(
            color: Colors.black, fontSize: 25, fontWeight: FontWeight.w500),
        actions: [
          PopupMenuButton(
            onSelected: (int value) {
              Provider.of<MyState>(context, listen: false).filternotes(value);
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text('All'),
                value: 1,
              ),
              PopupMenuItem(
                child: Text('Done'),
                value: 2,
              ),
              PopupMenuItem(
                child: Text('Undone'),
                value: 3,
              )
            ],
          )
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Consumer<MyState>(
              builder: (context, state, child) => taskk(
                _filterList(state.list, state.filter),
              ),
            ),
            Positioned(child: knapp())
          ],
        ),
      ),
    );
  }

  List<minuppgift> _filterList(list, value) {
    if (value == 1) return list;
    if (value == 2) {
      return list.where((note) => note.done == true).toList();
    } else if (value == 3) {
      return list.where((note) => note.done == false).toList();
    }
    return list;
  }
}
