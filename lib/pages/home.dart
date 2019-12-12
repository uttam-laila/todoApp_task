import 'package:flutter/material.dart';
import '../models/notes.dart';
import '../pages/addEditNotes.dart';
import '../utils/databaseHelper.dart';
import 'package:sqflite/sqlite_api.dart';
// import 'package:flutter/foundation.dart' show SynchronousFuture;

class NotekeeperHome extends StatefulWidget {
  @override
  _NotekeeperHomeState createState() => _NotekeeperHomeState();
}

class _NotekeeperHomeState extends State<NotekeeperHome> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Notes> noteList;
  var count = 0;
  @override
  Widget build(BuildContext context) {
    if (noteList == null) {
      noteList = List<Notes>();
      updateListView();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('TODO List'),
      ),
      body: ListView.builder(
        itemCount: count,
        itemBuilder: (BuildContext context, int position) {
          return Dismissible(
            child: Card(
              elevation: 5.0,
              color: Colors.white,
              child: ListTile(
                title: Center(child: Text(this.noteList[position].title, key: ValueKey('$position'),)),
                subtitle:
                    Center(child: Text(this.noteList[position].description)),
                // trailing: Icon(Icons.delete, color: Colors.blueGrey,),
                onLongPress: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return EditNote(
                        notes: this.noteList[position],
                        appBarTitle: 'Edit Note');
                  }));
                },
              ),
            ),
            key: Key(UniqueKey().toString()),
            onDismissed: (startToEnd) {
              var noteIs = noteList[position];
              _delete(context, noteList[position]);
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text("Item deleted"),
                  action: SnackBarAction(
                    label: "UNDO",
                    onPressed: () {
                      _undo(context, noteIs);  
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        key: ValueKey('addNotes'),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return EditNote(
                notes: Notes(
                  '',
                  '',
                  '',
                ),
                appBarTitle: "Add Notes");
          }));
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _delete(BuildContext context, Notes notes) async {
    int result = await databaseHelper.deleteNote(notes.id);
    if (result != null) {
      updateListView();
    }
  }

  void _undo(BuildContext context, Notes notes) async{
    int result = await databaseHelper.insertNote(notes);
    if (result != null) {
      _showSnakBar(context, "Deletion reverted");
      updateListView();
    }
  }


  void _showSnakBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      duration: const Duration(milliseconds: 500),
      content: Text(message),
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void updateListView() {
    final Future<Database> dbF = databaseHelper.initializeDatabase();
    dbF.then((database) {
      Future<List<Notes>> noteListF = databaseHelper.getNoteList();
      noteListF.then((noteList) {
        setState(() {
          this.noteList = noteList;
          this.count = noteList.length;
        });
      });
    });
  }
}