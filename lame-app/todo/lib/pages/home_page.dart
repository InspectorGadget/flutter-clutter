import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/services/db_service.dart';
import 'package:todo/services/theme_service.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    ThemeChanger _themeChanger = Provider.of<ThemeChanger>(context);
    final dbHelper = Databasehelper.instance;
    final TextEditingController _textEditingController =
        TextEditingController();

    bool validated = true;
    String errorText = '';
    String todoEdited = '';
    var myTasks = List();
    List<Widget> _children = List<Widget>();

    void addTodo() async {
      Map<String, dynamic> row = {Databasehelper.columnName: todoEdited};

      final id = await dbHelper.insert(row);
      Navigator.of(context).pop();
      todoEdited = '';
      setState(() {
        validated = true;
        errorText = '';
      });
    }

    Future<bool> query() async {
      myTasks = [];
      _children = [];

      var allRows = await dbHelper.queryall();
      allRows.forEach((row) {
        myTasks.add(row.toString());
        _children.add(Card(
          elevation: 5.0,
          margin: EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 5.0,
          ),
          child: Container(
            padding: EdgeInsets.all(5.0),
            child: ListTile(
              title: Text(
                row['todo'],
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
              onLongPress: () {
                dbHelper.deletedata(row['id']);
                setState(() {});
              },
            ),
          ),
        ));
      });

      return Future.value(true);
    }

    void showAlertDialog() {
      _textEditingController.text = '';

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                title: Text("Add Task"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextField(
                      controller: _textEditingController,
                      onChanged: (value) {
                        setState(() {
                          todoEdited = value;
                        });
                      },
                      autofocus: true,
                      autocorrect: false,
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                      decoration: InputDecoration(
                        errorText: validated ? null : errorText,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                            top: 10.0,
                          ),
                          child: RaisedButton(
                            onPressed: () {
                              if (_textEditingController.text.isEmpty) {
                                setState(() {
                                  errorText = "Can't be Empty!";
                                  validated = false;
                                });
                              } else if (_textEditingController.text.length >
                                  512) {
                                setState(() {
                                  errorText = "Too many chars!";
                                  validated = false;
                                });
                              } else {
                                addTodo();
                              }
                            },
                            child: Text("Add"),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              );
            },
          );
        },
      );
    }

    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.hasData == null) {
          return Center(
            child: Text(
              'No Data!',
            ),
          );
        } else {
          if (myTasks.length == 0) {
            return Scaffold(
              appBar: AppBar(
                title: Text('My Tasks by Raeveen'),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              floatingActionButton: FloatingActionButton.extended(
                icon: Icon(Icons.add),
                label: Text("Add"),
                onPressed: showAlertDialog,
              ),
              bottomNavigationBar: BottomAppBar(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Switch(
                      value: _themeChanger.getTheme() == ThemeData.dark()
                          ? true
                          : false,
                      onChanged: (value) {
                        _themeChanger.setTheme(
                          value ? ThemeData.dark() : ThemeData.light(),
                        );
                      },
                    )
                  ],
                ),
              ),
              body: Center(
                child: Text(
                  'No Task available!',
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ),
            );
          } else {
            return Scaffold(
              appBar: AppBar(
                title: Text('My Tasks by Raeveen'),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              floatingActionButton: FloatingActionButton.extended(
                icon: Icon(Icons.add),
                label: Text("Add"),
                onPressed: showAlertDialog,
              ),
              bottomNavigationBar: BottomAppBar(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Switch(
                      value: _themeChanger.getTheme() == ThemeData.dark()
                          ? true
                          : false,
                      onChanged: (value) {
                        _themeChanger.setTheme(
                          value ? ThemeData.dark() : ThemeData.light(),
                        );
                      },
                    )
                  ],
                ),
              ),
              body: Padding(
                padding: EdgeInsets.all(5.0),
                child: Column(
                  children: _children,
                ),
              ),
            );
          }
        }
      },
      future: query(),
    );
  }
}
