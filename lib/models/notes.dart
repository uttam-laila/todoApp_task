class Notes {
  int _id;
  String _title;
  String _description;
  String _date;

  Notes(this._title, this._description, this._date);
  Notes.withId(this._id, this._description, this._date, [this._title]);

  int get id => _id;
  String get title => _title;
  String get description => _description;
  String get date => _date;

  set title(String newTitle){
    this._title = newTitle;
  }
  set description(String newDescription){
    this._description = newDescription;
  }
  set date(String newDate){
    this._date = newDate;
  }

  Map<String, dynamic> toMap(){
    var map = Map<String, dynamic>();
    if(id != null){
      map['id'] = _id;
    }
    map['title'] = _title;
    map['description'] = _description;
    map['date'] = _date;

    return map;
  }

  Notes.fromMapObject(Map<String, dynamic> map){
    _id = map['id'];
    _title = map['title'];
    _description = map['description'];
    _date = map['date'];
  }
}
