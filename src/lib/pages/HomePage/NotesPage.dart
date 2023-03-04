import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_treeview/flutter_treeview.dart';
import 'package:src/components/NoteTile.dart';
import 'package:src/model/Note.dart';
import 'package:src/services/cache/Cache.dart';
import 'package:src/services/logger/Logger.dart';

class NotesPage extends StatefulWidget {
  NotesPage({Key? key}) : super(key: key);

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  bool rootLoading = true;
  late List<Node<Note>> nodes;
  late TreeViewController treeController;

  @override
  void initState() {
    nodes = [];
    treeController = TreeViewController(children: nodes);
    loadRootNote();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Notes'),
        ),
        body: rootLoading
            ? Center(child: CircularProgressIndicator())
            : TreeView(
                nodeBuilder: (context, Node<dynamic> node) {
                  return NoteTile(node: node, updateTreeController:updateTreeController);
                },
                controller: treeController,
                theme: TreeViewTheme(
                  expanderTheme: ExpanderThemeData(
                    size:0
                  )
                ),
              ));
  }

  void loadRootNote() {
    CacheService().getNote("root").then((value) {
      setState(() {
        rootLoading = false;
        nodes.add(Node<Note>(label: value.title, key: "root", data: value));
      });
    });
  }

  void updateTreeController(String key, List<Node<Note>> children) {
    Logger().log("updateTreeController " + key + " " + children.length.toString());
    Node node = treeController.getNode(key)!;
      List<Node> updated = treeController.updateNode(
          node.key, node.copyWith(children: children, expanded: true));
    setState(() {
        treeController =
            treeController.copyWith(children: updated);
    });
  }
}
