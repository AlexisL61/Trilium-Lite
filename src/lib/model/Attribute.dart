class Attribute {
  String attributeId;
  String noteId;
  String type;
  String name;
  String value;
  int position;
  bool isInheritable;
  DateTime utcDateModified;

  Attribute({
    required this.attributeId,
    required this.noteId,
    required this.type,
    required this.name,
    required this.value,
    required this.position,
    required this.isInheritable,
    required this.utcDateModified,
  });

  factory Attribute.fromJson(Map<String, dynamic> json) {
    return Attribute(
      attributeId: json['attributeId'],
      noteId: json['noteId'],
      type: json['type'],
      name: json['name'],
      value: json['value'],
      position: json['position'],
      isInheritable: json['isInheritable'],
      utcDateModified: DateTime.parse(json['utcDateModified']),
    );
  }
}
