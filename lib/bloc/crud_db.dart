import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:tutor_kit/screens/home_screen/guardian/guardian_post_history.dart';

class CrudDb {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  CollectionReference posts = FirebaseFirestore.instance.collection("posts");
  addPost(
      String gender, String level, String salary, String dayPerWeek, String location, String curriculum, String subjects, String userEmail, FieldValue timestamp, String student, String time)async {
    try{
      posts.doc(_auth.currentUser!.uid).get().then((snap) {
        if(!snap.exists){
          posts.doc(_auth.currentUser!.uid).set({
            'gender' : gender,
            'class' : level,
            'salary' : salary,
            'dayPerWeek' : dayPerWeek,
            'location' : location,
            'curriculum' : curriculum,
            'subjects' : subjects,
            'userEmail' : userEmail,
            'timestamp' : timestamp,
            'student' : student,
            'time' : time,
          }).whenComplete(() => Get.snackbar("Attention", "Added Successfully",colorText: Colors.black,backgroundColor: Colors.black12)).then((value) => Get.to(()=>GuardianPostHistory()));
        } else {
          if (kDebugMode) {
            print(snap.exists);
          }
          Get.snackbar("Attention", "Max post limit 1");
        }
      });
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
  addTeacherRequest(String email, String postID, String gToken, String tToken,FieldValue timestamp){
    teacherRequest.doc().set({
      "email" : email,
      "postID" : postID,
      "gToken" : gToken,
      "tToken" : tToken,
      "timestamp" : timestamp
    });
  }
  //TeacherForm
  addTeacherInfo(String name, String gender, String dob, String address, String prefClass, String prefSubjects, String qualification, String institute, String department, String role){
    FirebaseFirestore.instance.collection("userInfo").doc(_auth.currentUser!.uid).update({
      "name": name,
      "gender": gender,
      "dob": dob,
      "address": address,
      "prefClass": prefClass,
      "prefSubjects": prefSubjects,
      "qualification": qualification,
      "institute": institute,
      "department": department,
      "role": role
    });
  }

  addGuardianResponse(String tName, String postId, FieldValue timestamp,String tEmail, String gEmail){
    FirebaseFirestore.instance.collection("guardianResponse").doc().set({
      "tName" : tName,
      "postId" : postId,
      "tEmail" : tEmail,
      "gEmail" : gEmail,
      "timestamp" : timestamp,
    });
  }

}