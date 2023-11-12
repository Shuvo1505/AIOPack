import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const TODOScreen());
}

class TODOScreen extends StatelessWidget {
  const TODOScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AIOPack',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: false,
      ),
      home: const TODOPage(title: 'TODO List'),
    );
  }
}

class TODOPage extends StatefulWidget {
  const TODOPage({super.key, required this.title});

  final String title;

  @override
  State<TODOPage> createState() => _TODOPageState();
}

class _TODOPageState extends State<TODOPage> {
  final displayList = <TODO>[];
  final inputControl = TextEditingController();
  final searchControl = TextEditingController();
  late String savedStatus = "";
  late bool showAlert = true;
  late bool showSearchIcon = true;
  late bool showSearchBar = false;
  List<TODO> found = [];

  static const String listKey = "list_key_tod";

  @override
  void initState() {
    loadTaskList().then((loadedTaskList) {
      setState(() {
        displayList.addAll(loadedTaskList);
        found = displayList;
        savedStatus =
            displayList.isEmpty ? "No saved tasks yet" : "Your saved tasks";
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    inputControl.dispose();
    searchControl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 236, 237, 244),
        appBar: AppBar(
          leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_sharp,
                  color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              }),
          backgroundColor: HexColor("#050A0C"),
          centerTitle: true,
          title: const Text("TODO List",
              style: TextStyle(fontWeight: FontWeight.w300)),
          toolbarHeight: 90,
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: HexColor("#050A0C"),
          child: Stack(
            children: [
              Container(
                  color: HexColor("#050A0C"),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  margin: const EdgeInsets.symmetric(vertical: 70.0),
                  child: Column(children: [
                    displayList.isNotEmpty ? searchbox() : Container(),
                    Expanded(
                        child: ListView(children: [
                      Container(
                          color: HexColor("#050A0C"),
                          margin: const EdgeInsets.symmetric(vertical: 46.0),
                          child: Visibility(
                            visible: true,
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Center(
                                    child: Text(savedStatus,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white70)),
                                  )
                                ]),
                          )),
                      for (TODO picker in found.reversed)
                        TodoItem(
                          todo: picker,
                          onTodoChange: handleChange,
                          onDeleteItem: handleDelete,
                        ),
                    ]))
                  ])),
              bottomEdit()
            ],
          ),
        ));
  }

  void handleChange(TODO todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
    saveTaskList(displayList);
  }

  void handleDelete(String id) {
    setState(() {
      displayList.removeWhere((item) => item.id == id);
      found = displayList;
      if (displayList.isEmpty) {
        savedStatus = "No saved tasks yet";
      } else {
        savedStatus = "Your saved tasks";
      }
    });
    saveTaskList(displayList); // Save the updated task list
  }

  void addTask(String task) {
    setState(() {
      displayList.add(TODO(
          id: DateTime.now().millisecondsSinceEpoch.toString(), text: task));
      if (displayList.isEmpty) {
        savedStatus = "No saved tasks yet";
      } else {
        savedStatus = "Your saved tasks";
      }
    });
    inputControl.clear();
    saveTaskList(displayList); // Save the updated task list
  }

  void runFilter(String keyword) {
    List<TODO> results = [];
    if (keyword.isEmpty) {
      results = displayList;
    } else {
      results = displayList
          .where((item) =>
              item.text!.toLowerCase().contains(keyword.toLowerCase()))
          .toList();
    }
    setState(() {
      found = results;
      if (found.isEmpty) {
        savedStatus = "No results found";
      } else {
        if (keyword.isNotEmpty) {
          savedStatus = "Results for \"$keyword\" ";
        } else {
          savedStatus = "Your saved tasks";
        }
      }
    });
  }

  Future<List<TODO>> loadTaskList() async {
    final prefs = await SharedPreferences.getInstance();
    final taskListJson = prefs.getString(listKey);
    if (taskListJson != null) {
      final List<dynamic> taskListData = json.decode(taskListJson);
      return taskListData.map((taskData) => TODO.fromJson(taskData)).toList();
    }
    return [];
  }

  Future<void> saveTaskList(List<TODO> taskList) async {
    final prefs = await SharedPreferences.getInstance();
    final taskListJson = taskList.map((task) => task.toJson()).toList();
    await prefs.setString(listKey, json.encode(taskListJson));
  }

  throwError() {
    Fluttertoast.showToast(
        msg: "✕ Minimum 35 characters are allowed !",
        gravity: ToastGravity.TOP,
        toastLength: Toast.LENGTH_SHORT,
        fontSize: 16.0,
        backgroundColor: HexColor("#AF002A"),
        textColor: Colors.white);
  }

  throwException() {
    Fluttertoast.showToast(
        msg: "✕ Task shouldn't be empty !",
        gravity: ToastGravity.TOP,
        toastLength: Toast.LENGTH_SHORT,
        fontSize: 16.0,
        backgroundColor: HexColor("#AF002A"),
        textColor: Colors.white);
  }

  throwSuccess() {
    Fluttertoast.showToast(
        msg: "✓ Task added",
        gravity: ToastGravity.TOP,
        toastLength: Toast.LENGTH_SHORT,
        fontSize: 16.0,
        backgroundColor: Colors.green,
        textColor: Colors.white);
  }

  Widget searchbox() {
    return Card(
        color: HexColor("#1f1f1f"),
        elevation: 15.0,
        shape: const ContinuousRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(30.0))),
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            decoration: BoxDecoration(
                color: HexColor("#1f1f1f"),
                borderRadius: BorderRadius.circular(20)),
            child: TextField(
                style: const TextStyle(color: Colors.white),
                cursorOpacityAnimates: true,
                cursorColor: Colors.white,
                onChanged: (value) {
                  runFilter(value);
                  setState(() {
                    if (searchControl.value.text.isEmpty) {
                      showSearchIcon = true;
                    } else {
                      showSearchIcon = false;
                    }
                  });
                },
                controller: searchControl,
                decoration: InputDecoration(
                    prefixIcon: Visibility(
                        visible: showSearchIcon,
                        child: const Icon(Icons.search,
                            color: Colors.grey, size: 20)),
                    prefixIconConstraints:
                        const BoxConstraints(maxHeight: 20, minWidth: 25),
                    border: InputBorder.none,
                    hintText: "Search your task",
                    hintStyle: const TextStyle(color: Colors.grey)))));
  }

  Widget bottomEdit() {
    return Align(
        alignment: Alignment.bottomCenter,
        child: Row(children: [
          Expanded(
              child: Container(
                  margin: const EdgeInsets.only(
                      bottom: 16.0, right: 20.0, left: 20.0),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  decoration: BoxDecoration(
                    color: HexColor("#1f1f1f"),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                      style: const TextStyle(color: Colors.white),
                      autofocus: false,
                      cursorColor: Colors.white,
                      cursorOpacityAnimates: true,
                      textInputAction: TextInputAction.done,
                      onEditingComplete: () {
                        FocusScope.of(context).unfocus();
                      },
                      controller: inputControl,
                      decoration: InputDecoration(
                          hintText: "Tap to type",
                          hintStyle: const TextStyle(color: Colors.grey),
                          filled: true,
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(20.0)),
                          fillColor: HexColor("#1f1f1f"))))),
          Container(
              margin: const EdgeInsets.only(bottom: 16, right: 20),
              child: ElevatedButton(
                  onPressed: () {
                    if (inputControl.text.length > 35) {
                      throwError();
                    } else if (inputControl.text.isEmpty) {
                      throwException();
                    } else {
                      addTask(inputControl.text);
                      throwSuccess();
                      FocusScope.of(context).unfocus();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: HexColor("#e50914"),
                      minimumSize: const Size(60.0, 60.0),
                      elevation: 10,
                      shadowColor: HexColor("#e50914"),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      )),
                  child: const Text("+",
                      style: TextStyle(fontSize: 40, color: Colors.white))))
        ]));
  }
}

class TODO {
  String? id;
  String? text;
  bool isDone;

  TODO({required this.id, required this.text, this.isDone = false});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'isDone': isDone,
    };
  }

  factory TODO.fromJson(Map<String, dynamic> json) {
    return TODO(
      id: json['id'],
      text: json['text'],
      isDone: json['isDone'],
    );
  }
}

class TodoItem extends StatelessWidget {
  final TODO todo;
  final Function onTodoChange;
  final Function onDeleteItem;

  const TodoItem(
      {super.key,
      required this.todo,
      required this.onDeleteItem,
      required this.onTodoChange});

  notifyDone() {
    Fluttertoast.showToast(
        msg: "Mark as done",
        gravity: ToastGravity.TOP,
        toastLength: Toast.LENGTH_SHORT,
        fontSize: 16.0,
        backgroundColor: Colors.green,
        textColor: Colors.white);
  }

  notifyunDone() {
    Fluttertoast.showToast(
        msg: "Mark as undone",
        gravity: ToastGravity.TOP,
        toastLength: Toast.LENGTH_SHORT,
        fontSize: 16.0,
        backgroundColor: HexColor("#AF002A"),
        textColor: Colors.white);
  }

  @override
  Widget build(BuildContext context) {
    notifyDelete() {
      var snackbar = SnackBar(
          content: const Text("Task removed",
              style: TextStyle(fontSize: 16.0, color: Colors.white)),
          backgroundColor: HexColor("#AF002A"),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 1));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Card(
        color: HexColor("#4a4a4a"),
        shape: const ContinuousRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(24.0))),
        elevation: 10,
        shadowColor: HexColor("#e50914"),
        child: ListTile(
          onTap: () {
            onTodoChange(todo);
            todo.isDone ? notifyDone() : notifyunDone();
          },
          shape: const ContinuousRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(24.0))),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          tileColor: HexColor("#1f1f1"),
          leading: Icon(
            todo.isDone ? Icons.check_box : Icons.check_box_outline_blank,
            color: HexColor("#e50914"),
          ),
          title: Text(todo.text!,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
              )),
          trailing: Container(
            padding: const EdgeInsets.all(0.0),
            margin: const EdgeInsets.symmetric(vertical: 12),
            height: 35,
            width: 35,
            decoration: BoxDecoration(
                color: Colors.red, borderRadius: BorderRadius.circular(5)),
            child: IconButton(
                tooltip: "Remove task",
                onPressed: () {
                  onDeleteItem(todo.id);
                  notifyDelete();
                },
                icon: const Icon(Icons.delete),
                iconSize: 18,
                color: Colors.white),
          ),
        ),
      ),
    );
  }
}
