class SavedNotes {
  int? _id;
  String? title;
  String? _content;

  SavedNotes({this.title = '', String? content = '', int? id = 0}) {
    _content = content;
  }


  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();

    map['title'] = title;
    map['content'] = _content;

    if (_id != null) {
      map['id'] = _id;
    }
    return map;
  }

  SavedNotes.fromObject(dynamic o) {
    if (o.containsKey('id') &&
        o.containsKey('title') &&
        o.containsKey('content')) {
      _id = o["id"] ?? 0;
      title = o["title"] ?? '';
      _content = o["content"] ?? '';
    } else {
      throw Exception("Required properties are missing in the object.");
    }
  }

  String get content => _content ?? '';

  set content(String value) {
    _content = value;
  }

  int get getId => _id ?? -1;

  set setId(int value) {
    _id = value;
  }

  toJson(){
    return {
      "body": _content
    };
  }
}
