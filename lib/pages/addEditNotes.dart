import 'package:flutter/material.dart';
import '../logics/logics.dart';
import '../models/notes.dart';
import '../pages/home.dart';
import '../utils/databaseHelper.dart';

class EditNote extends StatefulWidget {
  final Notes notes;
  final String appBarTitle;

  const EditNote({this.notes, this.appBarTitle});
  @override
  EditNoteState createState() => EditNoteState(this.notes, this.appBarTitle);
}

class EditNoteState extends State<EditNote> {
  TextEditingController titleText = TextEditingController();
  TextEditingController notesText = TextEditingController();

  DatabaseHelper databaseHelper = DatabaseHelper();

  var notes;
  var appBarTitle;

  EditNoteState(this.notes, this.appBarTitle);
  @override
  Widget build(BuildContext context) {
    titleText.text = notes.title;
    notesText.text = notes.description;

    return WillPopScope(
      key: ValueKey("addNotesPage"),
      onWillPop: () {
        Navigator.pop(context);
        return null;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Center(
            child: Text(appBarTitle),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 30,
              ),
              Text(
                titleText.text,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    key: ValueKey('titleField'),
                    controller: titleText,
                    decoration: InputDecoration(
                        hintText: "Title",
                        labelText: "Title",
                        alignLabelWithHint: true,
                        border: OutlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(const Radius.circular(12)),
                        )),
                    onChanged: (value) {
                      updateTitle();
                    },
                    validator: Logics.validateFormFields,
                  ),
                ),
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    key: ValueKey('noteField'),
                    controller: notesText,
                    decoration: InputDecoration(
                        hintText: "Notes",
                        labelText: "Description",
                        alignLabelWithHint: true,
                        border: OutlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(const Radius.circular(12)),
                        )),
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    minLines: 10,
                    onChanged: (value) {
                      updateDescription();
                    },
                  ),
                ),
              ),
              FlatButton(
                color: Colors.blueAccent,
                child: Text("Save",key: ValueKey('saveButton'),),
                onPressed: () {
                  _save();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void updateTitle() {
    notes.title = titleText.text;
  }

  void updateDescription() {
    notes.description = notesText.text;
  }

  void _save() async {
    var result;
    if (notes.id != null) {
      result = await databaseHelper.updateNote(notes);
    } else {
      result = await databaseHelper.insertNote(notes);
    }
    if (result != 0) {
      Navigator.of(context).popUntil((route) => route.isFirst);
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return NotekeeperHome();
      }));
    }
  }
}