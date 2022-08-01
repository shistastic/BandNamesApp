import 'dart:io';

import 'package:band_names/models/band.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Band> bands = [
    Band(id: "1", name: "Metallica", votes: 3),
    Band(id: "2", name: "Queen", votes: 2),
    Band(id: "3", name: "Héroes del Silencio", votes: 1),
    Band(id: "4", name: "Bon Jovi", votes: 5),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text(
          "BandNames",
          style: TextStyle(
            color: Colors.black87,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: bands.length,
        itemBuilder: (BuildContext context, int index) =>
            _bandTile(bands[index]),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        elevation: 1,
        onPressed: _addNewBand,
      ),
    );
  }

  Widget _bandTile(Band band) => Dismissible(
        direction: DismissDirection.startToEnd,
        key: Key(band.id!),
        onDismissed: (DismissDirection direction) =>
            print("direction: $direction"),
        background: Container(
          padding: EdgeInsets.only(left: 8),
          color: Colors.red,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Delete Band",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
        child: ListTile(
          leading: CircleAvatar(
            child: Text(
              band.name!.substring(0, 2),
            ),
            backgroundColor: Colors.blue[100],
          ),
          title: Text(band.name!),
          trailing: Text(
            "${band!.votes}",
            style: TextStyle(fontSize: 20),
          ),
          onTap: () {
            print(band.name!);
          },
        ),
      );

  _addNewBand() {
    final TextEditingController _textController = TextEditingController();

    if (Platform.isAndroid) {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text("New band name:"),
          content: TextField(
            controller: _textController,
          ),
          actions: <Widget>[
            MaterialButton(
              child: Text("Add"),
              elevation: 5,
              textColor: Colors.blue,
              onPressed: () => _addBandToList(_textController.text),
            )
          ],
        ),
      );
    } else {
      showCupertinoDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: Text("New band name:"),
          content: CupertinoTextField(
            controller: _textController,
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              isDefaultAction: true,
              child: Text("Add"),
              onPressed: () => _addBandToList(_textController.text),
            ),
            CupertinoDialogAction(
              isDestructiveAction: true,
              child: Text("Dismiss"),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
    }
  }

  void _addBandToList(String name) {
    if (name.length > 1) {
      this.bands.add(
            Band(id: DateTime.now().toString(), name: name, votes: 0),
          );
      setState(() {});
    }
    Navigator.of(context).pop();
  }
}
