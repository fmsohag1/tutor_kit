import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:tutor_kit/screens/home_screen/guardian_post_history.dart';

class CrudDb {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  CollectionReference posts = FirebaseFirestore.instance.collection("posts");
  addPost(
      String gender, String level, String salary, String dayPerWeek, String location, String curriculum, String subjects, String userPhone, FieldValue timestamp, String student, String time, String deviceToken)async {
    try{
      posts.doc().set({
        'gender' : gender,
        'class' : level,
        'salary' : salary,
        'dayPerWeek' : dayPerWeek,
        'location' : location,
        'curriculum' : curriculum,
        'subjects' : subjects,
        'userPhone' : userPhone,
        'timestamp' : timestamp,
        'student' : student,
        'time' : time,
        'deviceToken' : deviceToken,
      }).whenComplete(() => Get.snackbar("Attention", "Added Successfully",colorText: Colors.black,backgroundColor: Colors.black12)).then((value) => Get.to(()=>GuardianPostHistory()));
    } catch (e) {
      Get.snackbar("Attention", "Error Occurred",colorText: Colors.black,backgroundColor: Colors.black12,);
    }

  }
  readPost()async {
    await posts.get().then((event) {
      for (var doc in event.docs){
        print(doc["salary"]);
      }
    });
  }
  deletePost(String docId){
    try{
      posts.doc(docId).delete().whenComplete(() => Get.snackbar("Attention", "Deleted Successfully",colorText: Colors.black,backgroundColor: Colors.black12));
    } catch (e) {
      Get.snackbar("Attention", "Error Occurred",colorText: Colors.black,backgroundColor: Colors.black12);
    }
  }

  updatePost(String gender, String level, String salary, String dayPerWeek, String location, String curriculum, String subjects,String student,String time, String docId){
    try{
      posts.doc(docId).update({
        'gender' : gender,
        'class' : level,
        'salary' : salary,
        'dayPerWeek' : dayPerWeek,
        'location' : location,
        'curriculum' : curriculum,
        'subjects' : subjects,
        'student' : student,
        'time' : time
      }).whenComplete(() => Get.snackbar("Attention", "Updated Successfully",colorText: Colors.black,backgroundColor: Colors.black12)).then((value) => Get.off(()=>GuardianPostHistory()));
    } catch (e) {
      Get.snackbar("Attention", "Error Occurred",colorText: Colors.black,backgroundColor: Colors.black12);
    }
  }

  CollectionReference teacherRequest = FirebaseFirestore.instance.collection("teacherRequest");
  addTeacherRequest(String mobile, String postID, String deviceToken, FieldValue timestamp){
    teacherRequest.doc().set({
      "mobile" : mobile,
      "postID" : postID,
      "deviceToken" : deviceToken,
      "timestamp" : timestamp
    });
  }
}