import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/model/todo_data.dart';

String locale = 'English';
List<String> list = ['English','Spanish','Hindi','Gujarati'];
class LocalizationController extends GetxController {
  String getTranslatedString(String key) {
    return _localizedStrings[locale]![key] ?? key;
  }
  static final Map<String, Map<String, String>> _localizedStrings = {
    'English': {
      'appTitle': 'Todo List',
      'darkTheme': 'Dark theme',
      'setting': 'Settings',
      'addTask': 'Add Task',
      'task':"Task",
      'add':'ADD',
      'lang':'Language',
    },
    'Spanish': {
      'appTitle': 'Lista de quehaceres',
      'darkTheme': 'Tema Oscuro',
      'setting': 'configuración',
      'addTask': 'Agregar tarea',
      'task':"Tarea",
      'add':'Agregar',
      'lang':'idioma',
    },
    'Hindi': {
      'appTitle': 'कार्य करने की सूची',
      'darkTheme': 'डार्क थीम',
      'setting': 'सेटिंग',
      'addTask': 'कार्य जोड़ें',
      'task':"कार्य",
      'add':'जोड़ें',
      'lang':'भाषा',
    },
    'Gujarati': {
      'appTitle': 'યાદી કરવા માટે',
      'darkTheme': 'ડાર્ક થીમ',
      'setting': 'સેટિંગ્સ',
      'addTask': 'કાર્ય ઉમેરો',
      'task':"કાર્ય",
      'add':'ઉમેરો',
      'lang':'ભાષા',

    },
  };
}
class TodoScreen extends StatefulWidget {
  TodoScreen({Key? key}) : super(key: key);

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  TextEditingController _task = TextEditingController();
  final localizationController = Get.put(LocalizationController());
  late List<TodoList> todos;

  @override
  void initState() {
    todos = [];
    super.initState();
  }
  bool darkTheme = false;
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: darkTheme?ThemeMode.dark:ThemeMode.light,
      home: Scaffold(
        backgroundColor: darkTheme?Color.fromRGBO(50, 50, 50, 100):Colors.grey[300],
        drawer: SafeArea(
          child: Drawer(
            width: 250,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.horizontal(right: Radius.circular(30))),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  SizedBox(height: 20,),
                  Text(localizationController.getTranslatedString('setting'),style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(localizationController.getTranslatedString('darkTheme')+" : ",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold)),
                      Switch(
                        value: darkTheme,
                        onChanged: (value) {
                          setState(() {
                            darkTheme = value;
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
              Row(
                children: [
                  Text(localizationController.getTranslatedString('lang')+" : ",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold)),
                  SizedBox(width: 10,),
                  Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: darkTheme?Colors.black:Colors.grey[300],),
                    width: 110,
                    child: Center(
                      child: DropdownButton<String>(
                        borderRadius: BorderRadius.circular(10),
                        value: locale,
                        onChanged: (String? value) {
                          // This is called when the user selects an item.
                          setState(() {
                            locale = value!;
                          });
                        },
                        items: list.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  )
                ],
              ),

                ],
              ),
            ),
          ),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(10.0),
          child: FloatingActionButton(onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                title: Center(child: Text(localizationController.getTranslatedString('addTask'))),
                content: TextField(
                  controller: _task,
                  decoration: InputDecoration(hintText: localizationController.getTranslatedString('task')),
                ),
                actions: [
                  Center(
                    child: Container(
                      width: 100,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_task.text.isNotEmpty) {
                            todos.add(TodoList(todos.length + 1, _task.text, false));
                            setState(() {});
                            _task.clear();
                            Navigator.of(context).pop();
                          }
                        },
                        child: Text(localizationController.getTranslatedString('add')),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
            child: Icon(Icons.add),
            focusColor: Colors.orange,
          ),
        ),

        appBar: AppBar(
          title: Text(localizationController.getTranslatedString('appTitle')),
          centerTitle: true,
        ),
        body: ListView.builder(
          itemCount: todos.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 2,
                child: CheckboxListTile(
                  checkboxShape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                  selectedTileColor: Colors.grey,
                  controlAffinity: ListTileControlAffinity.leading,
                  secondary: IconButton(
                      onPressed: ()  {
                        //logic for delete
                        todos.removeAt(index);
                        setState(() {});
                      },
                      icon: Icon(Icons.delete)),
                  onChanged: (v)  {
                    //logic to toggle isCompleted
                    todos[index].completed = v!;
                    setState(() {});
                  },
                  value: todos[index].completed,
                  title: Text(todos[index].task,
                      style: todos[index].completed
                          ? TextStyle(
                        decoration: TextDecoration.lineThrough,
                        color: Color(0xffff5500),
                      )
                          : TextStyle()),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
