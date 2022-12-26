final String tableSubjects = 'subjects';

class SubjectFields {
  static final List<String> values = [subid, subcode, subname];

  static final String subid = '_id';
  static final String subcode = 'subcode';
  static final String subname = 'subname';
}

class Subject {
  final int? id;
  final int subcode;
  final String subname;

  const Subject({
    this.id,
    required this.subcode,
    required this.subname,
  });

  Subject copy({
    int? id,
    bool? isImportant,
    int? subcode,
    String? subname,
    String? description,
    DateTime? createdTime,
  }) =>
      Subject(
        id: id ?? this.id,
        subcode: subcode ?? this.subcode,
        subname: subname ?? this.subname,
      );

  static Subject fromJson(Map<String, Object?> json) => Subject(
        id: json[SubjectFields.subid] as int?,
        subcode: json[SubjectFields.subcode] as int,
        subname: json[SubjectFields.subname] as String,
      );

  Map<String, Object?> toJson() => {
        SubjectFields.subid: id,
        SubjectFields.subname: subname,
        SubjectFields.subcode: subcode,
      };
}
