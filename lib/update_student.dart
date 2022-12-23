import 'package:database/db_helper.dart';
import 'package:database/student_model.dart';
import 'package:flutter/material.dart';

class UpdateStudent extends StatefulWidget {
  const UpdateStudent({Key? key, this.student}) : super(key: key);
  final Student? student;

  @override
  State<UpdateStudent> createState() => _UpdateStudentState();
}

class _UpdateStudentState extends State<UpdateStudent> {

  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final courseController = TextEditingController();

  @override
  void initState() {
    if (widget.student != null) {
      nameController.text = widget.student!.name;
      courseController.text = widget.student!.course;
    }
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    courseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Edit Student Form'),
          leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.of(context).pop(false);
              }
          ),
        ),
        body: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child:Container(
            padding: const EdgeInsets.all(15),
            child: ListView(
              padding: const EdgeInsets.all(15),
              children: <Widget>[
                TextFormField(
                    controller: nameController,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                        icon: Icon(Icons.account_circle_rounded),
                        hintText: 'Name',
                        labelText: 'Name'
                    ),
                    validator: (name) {
                      if(name!.isEmpty || !RegExp(r'[a-z A-Z]+$').hasMatch(name)) {
                        return 'Please enter your Name.';
                      } else {
                        return null;
                      }
                    }
                ),
                const SizedBox(height: 20),
                TextFormField(
                    controller: courseController,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                        icon: Icon(Icons.school_rounded),
                        hintText: 'Course',
                        labelText: 'Course'
                    ),
                    validator: (course) {
                      if(course!.isEmpty || !RegExp(r'[a-zA-Z0-9]+$').hasMatch(course)) {
                        return 'Please enter your Course.';
                      } else {
                        return null;
                      }
                    }
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      await DBHelper.updateStudent(
                          Student(
                            id: widget.student!.id,
                            name: nameController.text,
                            course: courseController.text,
                          ));
                      Navigator.of(context).pop(true);
                    } else {
                      return;
                    }
                  },
                  child: const Text('UPDATE'),
                ),
              ],
            ),
          ),
        )
    );
  }
}