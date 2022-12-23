import 'package:database/add_student.dart';
import 'package:database/db_helper.dart';
import 'package:database/student_model.dart';
import 'package:database/update_student.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Information'),
      ),
      body: FutureBuilder<List<Student>>(
        future: DBHelper.readStudent(),
        builder: (BuildContext context, AsyncSnapshot<List<Student>> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 20,
                  ),
                  Text('Loading...'),
                ],
              ),
            );
          }
          return snapshot.data!.isEmpty ?
          const Center(
            child: Text('The List is Empty.'),
          )
              : ListView(
            children: snapshot.data!.map((students) {
              return Dismissible(
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Colors.red,
                    padding: const EdgeInsets.only(right: 20.0),
                    alignment: Alignment.centerRight,
                    child: const Icon(Icons.delete_sweep_rounded,
                    ),
                  ),
                  key: UniqueKey(),
                  onDismissed: (dismiss) {
                    setState(() {
                      DBHelper.deleteStudent(students.id!);
                    });
                  },
                  child:Card(
                      elevation: 10,
                      shadowColor: Colors.blueAccent,
                      child: ListTile(
                        leading: const Icon(Icons.account_box_rounded),
                        title: Text(students.name),
                        subtitle: Text(students.course),
                        trailing: IconButton(
                          icon: const Icon(Icons.edit_rounded),
                          onPressed: () async {
                            final updateDetails = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UpdateStudent(
                                        student: Student(
                                          id: students.id,
                                          name: students.name,
                                          course: students.course,
                                        )
                                    )
                                )
                            );
                            if (updateDetails) {
                              setState(() {
                              });
                            }
                          },
                        ),
                      )
                  )
              );
            }).toList(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final getDetails = await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AddStudent()
              )
          );
          if (getDetails) {
            setState(() {
            });
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}