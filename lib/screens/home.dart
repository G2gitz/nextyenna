import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //bool value = false;
  List<String> tasks = [];
  final TextEditingController _controller = TextEditingController();
  void initState() {
    super.initState();
    _loadTasks();
  }

Future<void> _loadTasks() async {
  final prefs = await SharedPreferences.getInstance();
  setState(() {
    tasks = prefs.getStringList('tasks')?.cast<String>() ?? [];
  });
}


  Future<void> _saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('tasks', tasks);
  }

  void _addTask(String task) {
    setState(() {
      tasks.insert(0, task); // Adding the task to the beginning of the list
    });
    _saveTasks(); // Save tasks after adding
  }

  void _removeTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
    _saveTasks(); // Save tasks after removing
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    String data = 'Hello';
    String Task = _controller.text;
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 120.0,
          title: Center(
            child: Text(
              "N E X T Y E N N A ?",
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
          backgroundColor: Color(0xFFffb3c6),
        ),
        backgroundColor: Color(0xFFffe5ec),
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Dismissible(
                              key: Key(tasks[index]),
                              direction: DismissDirection.startToEnd,
                              onDismissed: (direction) {
                                setState(() {
                                  // tasks.removeAt(index);
                                  _removeTask(index);
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Task Removed")),
                                );
                              },
                              background: Container(
                                color: Colors.red,
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              child: Container(
                                constraints: BoxConstraints(minHeight: 100),
                                width: screenWidth,
                                decoration: BoxDecoration(
                                  color: Color(0xFFffc2d1),
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color.fromARGB(
                                              255, 255, 192, 240)
                                          .withOpacity(
                                              0.25), // Shadow color with opacity
                                      spreadRadius: 2, // The spread radius
                                      blurRadius: 5, // The blur radius
                                      offset: Offset(2,
                                          3), // Offset in the x and y direction
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          tasks[index],
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            )
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              right: 45,
              bottom: 55,
              child: FloatingActionButton(
                  backgroundColor: Color(0xFFffb3c6),
                  elevation: 2.5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Icon(
                    Icons.add,
                    size: 50.0,
                    color: Colors.white,
                  ),
                  splashColor: Color(0xFFffb3c6),
                  focusColor: Color(0xFFffb3c6),
                  focusElevation: 1.0,
                  hoverColor: Color(0xFFffb3c6),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("New Task"),
                            content: SizedBox(
                              width: 300,
                              child: TextField(
                                autocorrect: true,
                                controller: _controller,
                                decoration:
                                    InputDecoration(hintText: "Enter New Task"),
                              ),
                            ),
                            actions: [
                              SizedBox(
                                height: 35,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        foregroundColor: Colors.white,
                                        backgroundColor: const Color.fromARGB(
                                            255, 0, 120, 28),
                                        fixedSize: Size(100, 20),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          // tasks.add(_controller.text);
                                          // tasks.insert(0, _controller.text);
                                          _addTask(_controller.text);
                                        });
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(content: Text("Task Added")),
                                        );
                                        _controller.clear();
                                        Navigator.pop(context);
                                      },
                                      child: Text("Add")),
                                  SizedBox(
                                    width: 60,
                                  ),
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        foregroundColor: Colors.white,
                                        backgroundColor: const Color.fromARGB(
                                            255, 214, 3, 3),
                                        fixedSize: Size(100, 20),
                                      ),
                                      onPressed: () {
                                        print("no");
                                        _controller.clear();
                                        Navigator.pop(context);
                                      },
                                      child: Text("Cancel")),
                                ],
                              )
                            ],
                            elevation: 1.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                          );
                        });
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
