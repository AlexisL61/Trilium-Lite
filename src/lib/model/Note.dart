import 'package:src/model/Attribute.dart';

class Note {
  String noteId;
  bool isProtected;
  String title;
  String type;
  String mime;
  DateTime dateCreated;
  DateTime dateModified;
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
    required this.type,
    required this.mime,
    required this.dateCreated,
    required this.dateModified,
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
      title: json["isProtected"]?"[protected]": json['title'],
      type: json['type'],
      mime: json['mime'],
      dateCreated: DateTime.parse(json['dateCreated']),
      dateModified: DateTime.parse(json['dateModified']),
      parentNoteIds: List<String>.from(json['parentNoteIds']),
      childNoteIds: List<String>.from(json['childNoteIds']),
      parentBranchIds: List<String>.from(json['parentBranchIds']),
      childBranchIds: List<String>.from(json['childBranchIds']),
      attributes: List<Attribute>.from(
          json['attributes'].map((x) => Attribute.fromJson(x))),
    );
  }
}
