import 'package:flutter/material.dart';
import 'package:tutor_kit/bloc/crud_db.dart';
import 'package:tutor_kit/widgets/custom_textfield.dart';

class PostScreen extends StatelessWidget {
  PostScreen({super.key});
  final TextEditingController genderController = TextEditingController();
  final TextEditingController classController = TextEditingController();
  final TextEditingController salaryController = TextEditingController();
  final TextEditingController dayPerWeekController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController curriculumController = TextEditingController();
  final TextEditingController subjectController = TextEditingController();
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: genderController,
              decoration: InputDecoration(
                  hintText: "Gender",
                  fillColor: Colors.blue[200],
                  filled: true),
            ),
            TextField(
              controller: classController,
              decoration: InputDecoration(
                  hintText: "Class", fillColor: Colors.blue[200], filled: true),
            ),
            TextField(
              controller: salaryController,
              decoration: InputDecoration(
                  hintText: "Salary",
                  fillColor: Colors.blue[200],
                  filled: true),
            ),
            TextField(
              controller: dayPerWeekController,
              decoration: InputDecoration(
                  hintText: "Day/Week",
                  fillColor: Colors.blue[200],
                  filled: true),
            ),
            TextField(
              keyboardType: TextInputType.number,
              controller: locationController,
              decoration: InputDecoration(
                  hintText: "Location",
                  fillColor: Colors.blue[200],
                  filled: true),
            ),
            TextField(
              controller: curriculumController,
              decoration: InputDecoration(
                  hintText: "Curriculum",
                  fillColor: Colors.blue[200],
                  filled: true),
            ),
            TextField(
              controller: subjectController,
              decoration: InputDecoration(
                  hintText: "Subjects",
                  fillColor: Colors.blue[200],
                  filled: true),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  CrudDb().addPost(
                      genderController.text,
                      classController.text,
                      salaryController.text,
                      dayPerWeekController.text,
                      locationController.text,
                      curriculumController.text,
                      subjectController.text);
                },
                child: Text("Post"))
          ],
        ),
      )),
      floatingActionButton: FloatingActionButton(onPressed: (){
        CrudDb().readPost();
      }),
    );
  }
}
