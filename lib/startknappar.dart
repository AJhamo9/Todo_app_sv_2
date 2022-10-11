import 'package:flutter/material.dart';
import 'home.dart';
import 'taskpage.dart';
import 'data_fetcher.dart';

class knapp extends StatefulWidget {
  @override
  State<knapp> createState() => _knappState();
}

class _knappState extends State<knapp> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 30.0,
        ),
        child: Stack(
          children: [
            Positioned(
              bottom: 0.0,
              right: 10.0,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => uppgift(),
                      ));
                },
                child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        border: Border.all(width: 3, color: Colors.black),
                        shape: BoxShape.rectangle,
                        color: Colors.pinkAccent,
                        borderRadius: BorderRadius.circular(20)),
                    child: Icon(Icons.add, color: Colors.black)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
