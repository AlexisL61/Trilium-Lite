import 'package:src/model/Attribute.dart';

class Note {
  String noteId;
  bool isProtected;
  String title;
  String mime;
  DateTime timeCreated;
  DateTime timeModified;
  List<String> parentNoteIds;
  List<String> childNoteIds;
  List<String> parentBranchIds;
  List<String> childBranchIds;
  List<Attribute> attributes;

  String? content;

  Note({
    required this.noteId,
    required this.isProtected,
    required this.title,
    required this.mime,
    required this.timeCreated,
    required this.timeModified,
    required this.parentNoteIds,
    required this.childNoteIds,
    required this.parentBranchIds,
    required this.childBranchIds,
    required this.attributes,
  });

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      noteId: json['noteId'],
      isProtected: json['isProtected'],
      title: json['title'],
      mime: json['mime'],
      timeCreated: DateTime.parse(json['timeCreated']),
      timeModified: DateTime.parse(json['timeModified']),
      parentNoteIds: List<String>.from(json['parentNoteIds']),
      childNoteIds: List<String>.from(json['childNoteIds']),
      parentBranchIds: List<String>.from(json['parentBranchIds']),
      childBranchIds: List<String>.from(json['childBranchIds']),
      attributes: List<Attribute>.from(
          json['attributes'].map((x) => Attribute.fromJson(x))),
    );
  }
}
