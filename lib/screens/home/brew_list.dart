import 'package:brew_crew/models/brew.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'brew_tile.dart';

class BrewList extends StatefulWidget {
  const BrewList({ Key? key }) : super(key: key);

  @override
  _BrewListState createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {
    final brews = Provider.of<List<Brew>?>(context);

    if (brews == null){
      return Text('No brews available');
    }else{
      return ListView.builder(
        itemCount: brews.length,
        itemBuilder: (context,index){
          return BrewTile(brew: brews[index]);
      });
    }
  }
}