import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data_fetcher.dart';
import 'home.dart';
import 'task.dart';

class taskk extends StatelessWidget {
  final List<minuppgift> list;

  taskk(this.list);

  final textkontroll = new TextEditingController();
  DataFetcher _dbHelper = DataFetcher();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children:
          list.map((minuppgift note) => _todoItem(context, note)).toList(),
    );
  }

  Widget _todoItem(context, minuppgift note) {
    var state = Provider.of<MyState>(context, listen: false);
    return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 15,
        ),
        margin: EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(width: 3.5, color: Colors.black),
            borderRadius: BorderRadius.circular(20)),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          IconButton(
            icon: note.done
                ? Icon(Icons.check_box)
                : Icon(Icons.check_box_outline_blank),
            iconSize: 40,
            onPressed: () {
              state.updatenote(note);
            },
          ),
          Padding(padding: EdgeInsets.only(right: 10)),
          Expanded(
            child: TextButton(
                onPressed: null,
                child: Text(
                  note.title,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: note.done ? Colors.red : Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    decoration: note.done ? TextDecoration.lineThrough : null,
                  ),
                )),
          ),
          GestureDetector(
            child: IconButton(
              icon: Icon(Icons.clear),
              padding: EdgeInsets.only(left: 10),
              iconSize: 40,
              onPressed: () {
                showDialog<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                          title: const Text('Do you want to delete this task?'),
                          actions: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                    child: const Text('No'),
                                    onPressed: (() {
                                      Navigator.pop(context);
                                    })),
                                GestureDetector(
                                  child: TextButton(
                                    child: const Text('Yes'),
                                    onPressed: () async {
                                      print("radera task");
                                      /*  var state = Provider.of<MyState>(context,
                                        listen: false);*/
                                      state.delete(note);
                                      // await DataFetcher.deleteNote();
                                      //    Navigator.pop(context);
                                      Navigator.pop(
                                        context,
                                      );
                                    },
                                  ),
                                ),
                              ],
                            )
                          ]);
                    });
              },
            ),
          )
        ]));
  }
}

final textkontroll = new TextEditingController();
