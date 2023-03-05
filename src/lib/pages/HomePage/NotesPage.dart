import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_treeview/flutter_treeview.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
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
  Node<Note>? selectedNode;
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
        body: selectedNode != null
            ? Column(children: [Expanded(child: buildBody()), buildPanel()])
            : buildBody());
  }

  void loadRootNote() {
    CacheService().getNote("root").then((value) {
      setState(() {
        rootLoading = false;
        nodes.add(Node<Note>(label: value.title, key: "root", data: value));
      });
    });
  }

  void updateTreeControllerChildren(String key, List<Node<Note>> children) {
    Logger()
        .log("updateTreeController " + key + " " + children.length.toString());
    Node<Note> node = treeController.getNode(key)!;
    List<Node> updated = treeController.updateNode(
        node.key, node.copyWith(children: children, expanded: true));
    setState(() {
      selectedNode = node;
      treeController = treeController.copyWith(children: updated);
    });
  }

  void updateTreeControllerExpanded(String key) {
    Node node = treeController.getNode(key)!;
    List<Node> updated =
        treeController.updateNode(key, node.copyWith(expanded: !node.expanded));
    setState(() {
      treeController = treeController.copyWith(children: updated);
    });
  }

  Widget buildBody() {
    return rootLoading
        ? Center(child: CircularProgressIndicator())
        : TreeView(
            allowParentSelect: true,
            onNodeTap: (p0) {
              updateTreeControllerExpanded(p0);
              setState(() {
                selectedNode = treeController.getNode(p0)!;
              });
            },
            nodeBuilder: (context, Node<dynamic> node) {
              return NoteTile(
                  node: node,
                  updateTreeController: updateTreeControllerChildren);
            },
            controller: treeController,
            theme: TreeViewTheme(expanderTheme: ExpanderThemeData(size: 0)),
          );
  }

  Widget buildPanel() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24.0),
            topRight: Radius.circular(24.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 7,
              offset: const Offset(0, -3), // changes position of shadow
            ),
          ]),
      height: 50,
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              Expanded(
                  child: Text(selectedNode!.data!.title,
                      style: Theme.of(context).textTheme.titleLarge, overflow: TextOverflow.ellipsis,)),
              IconButton(onPressed: () {}, icon: Icon(Icons.article)),
              IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
              IconButton(onPressed: () {}, icon: Icon(Icons.delete)),
            ],
          )),
    );
  }
}
