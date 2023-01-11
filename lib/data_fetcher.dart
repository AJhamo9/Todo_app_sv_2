import 'dart:async';
import 'package:flutter/foundation.dart';
import 'task.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'task.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class DataFetcher with ChangeNotifier {
  static String url_key = "key=1c10b6e7-0c81-46e2-97f8-1464dab1e6cd";

  static Future<List<minuppgift>?> getNotes(bool? doneList) async {
    List<minuppgift> notes = [];
    List<minuppgift> doneNotes = [];
    List<minuppgift> notDoneNotes = [];

    var url = Uri.parse('https://todoapp-api.apps.k8s.gu.se/todos?$url_key');

    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body) as List;

      print('All notes from internet json: $jsonResponse');

      notes = List<minuppgift>.from(
          jsonResponse.map<minuppgift>((dynamic i) => minuppgift.fromJson(i)));
      for (int i = 0; i < notes.length; i++) {
        if (notes[i].done) {
          doneNotes.add(notes[i]);
        } else {
          notDoneNotes.add(notes[i]);
        }
      }
      if (doneList == null) {
        return notes;
      }
      if (doneList) {
        return doneNotes;
      } else {
        return notDoneNotes;
      }
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return null;
    }
  }

  static Future<List<minuppgift>?> addNewNote(minuppgift note) async {
    var response = await http.post(
      Uri.parse('https://todoapp-api.apps.k8s.gu.se/todos?$url_key'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(minuppgift.toMap(note)),
    );
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body) as List;
      List<minuppgift> notes = List<minuppgift>.from(
          jsonResponse.map<minuppgift>((dynamic i) => minuppgift.fromJson(i)));
      return notes;
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return null;
    }
  }

  static Future<List<minuppgift>?> deleteNote(String todo) async {
    var response = await http.delete(
        Uri.parse("https://todoapp-api.apps.k8s.gu.se/todos/$todo?$url_key"));
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body) as List;
      List<minuppgift> notes = List<minuppgift>.from(
          jsonResponse.map<minuppgift>((dynamic i) => minuppgift.fromJson(i)));
      //  notifyListeners();
      return notes;
    } else {
      //   notifyListeners();
      print('Request failed with status: ${response.statusCode}.');
      return null;
    }
  }

  static Future<List<minuppgift>?> updateNote(
      minuppgift todo, bool done) async {
    todo.done = done;
    String todoId = todo.id!;
    Map<String, dynamic> obj = minuppgift.toJson(todo);
    var jsonString = jsonEncode(obj);

    print("Note to update::::" + jsonString);
    var response = await http.put(
      Uri.parse("https://todoapp-api.apps.k8s.gu.se/todos/$todoId?$url_key"),
      body: jsonString,
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body) as List;
      List<minuppgift> notes = List<minuppgift>.from(
          jsonResponse.map<minuppgift>((dynamic i) => minuppgift.fromJson(i)));
      print("update:...:" + response.body);
      return notes;
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return null;
    }
  }
}

class MyState extends ChangeNotifier {
  List<minuppgift> _list = [];
  List<minuppgift> get list => _list;

  int _filter = 0;
  int get filter => _filter;

  static String url_key = "key=875c02ff-b0b8-41e0-b7f9-53f951704372";

  var url = Uri.parse('https://todoapp-api.apps.k8s.gu.se/todos?$url_key');

  Future getnotes() async {
    List<minuppgift>? list = await DataFetcher.getNotes(null);
    _list = list!;
    notifyListeners();
  }
  //void checktask(minuppgift task)

  void addnote(minuppgift note) async {
    _list = (await DataFetcher.addNewNote(note))!;
    notifyListeners();
  }

  void filternotes(int filter) {
    this._filter = filter;
    notifyListeners();
  }

  void updatenote(minuppgift note) async {
    note.noteDone(note);
    _list = (await DataFetcher.updateNote(note, note.done))!;
    notifyListeners();
  }

  void delete(minuppgift note) async {
    _list = (await DataFetcher.deleteNote(note.id!))!;
    notifyListeners();
  }
}
