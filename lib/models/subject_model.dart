class Subject {
  final int? id;
  final String subname;
  final String subcode;

  Subject({this.id, required this.subname, required this.subcode});

  factory Subject.fromMap(Map<String, dynamic> json) {
    return Subject(id: json['id'],subname: json['subname'], subcode: json['subcode']);
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'subname': subname,
      'subcode': subcode
    };
  }


}


