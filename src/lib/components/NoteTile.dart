import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_treeview/flutter_treeview.dart';
import 'package:src/model/Note.dart';

import '../services/cache/Cache.dart';

class NoteTile extends StatefulWidget {
  NoteTile({Key? key, required this.node, required this.updateTreeController})
      : super(key: key);

  Node<dynamic> node;
  Function(String, List<Node<Note>>) updateTreeController;
  @override
  State<NoteTile> createState() => _NoteTileState();
}

class _NoteTileState extends State<NoteTile> {
  bool _isLoadingChildren = false;
  bool _childrenLoaded = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Padding(
          padding: EdgeInsets.all(8),
          child: Row(children: [
            widget.node.data.childNoteIds.isNotEmpty
                ? widget.node.expanded
                    ? const Icon(Icons.arrow_drop_down)
                    : const Icon(Icons.arrow_right)
                : SizedBox(width: 10),
            Text(widget.node.data.title),
            _isLoadingChildren
                ? const CircularProgressIndicator(
                    strokeWidth: 4,
                  )
                : Container()
          ])),
      onTap: widget.node.data.childNoteIds.isNotEmpty &&
              widget.node.children.isEmpty
          ? () {
              loadChildren();
            }
          : null
    );
  }

  void loadChildren() async {
    if (!_isLoadingChildren) {
      setState(() {
        _isLoadingChildren = true;
      });
      List<Node<Note>> children = [];
      for (String element in widget.node.data.childNoteIds) {
        Note noteFound = await CacheService().getNote(element);
        children.add(Node<Note>(
            label: noteFound.title, key: noteFound.noteId, data: noteFound));
      }
      widget.updateTreeController(widget.node.key, children);
      setState(() {
        _isLoadingChildren = false;
        _childrenLoaded = true;
      });
    }
  }
}
