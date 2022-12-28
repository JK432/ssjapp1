final String tableSubjects = 'subjects';

class SubjectFields {
  static final List<String> values = [subid, subcode, subname,totcls,totatd];

  static final String subid = '_id';
  static final String subcode = 'subcode';
  static final String subname = 'subname';
  static final String totcls = 'totcls';
  static final String totatd = 'totatd';

}

class Subject {
  final int? id;
  final int subcode;
  final String subname;
  final int totcls;
  final int totatd;

  const Subject({
    this.id,
    required this.subcode,
    required this.subname,
    required this.totcls,
    required this.totatd
  });

  Subject copy({
    int? id,
    int? subcode,
    String? subname,
    int? totcls,
    int? totatd
  }) =>
      Subject(
        id: id ?? this.id,
        subcode: subcode ?? this.subcode,
        subname: subname ?? this.subname,
        totcls: totcls ?? this.totcls,
        totatd: totatd?? this.totatd
      );

  static Subject fromJson(Map<String, Object?> json) => Subject(
        id: json[SubjectFields.subid] as int?,
        subcode: json[SubjectFields.subcode] as int,
        subname: json[SubjectFields.subname] as String,
        totcls:  json[SubjectFields.totcls] as int,
        totatd:  json[SubjectFields.totatd] as int,

      );

  Map<String, Object?> toJson() => {
        SubjectFields.subid: id,
        SubjectFields.subname: subname,
        SubjectFields.subcode: subcode,
        SubjectFields.totcls: totcls,
        SubjectFields.totatd: totatd,
      };
}
