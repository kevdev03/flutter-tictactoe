import 'package:flutter/material.dart';

class MoveList extends StatelessWidget {
  final List<Map> moveList;
  MoveList({this.moveList});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: (BuildContext context, int index){
      return Text('entry $index');
    },);
  }
}
