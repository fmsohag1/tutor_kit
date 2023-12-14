import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';
import 'package:tutor_kit/screens/home_screen/guardian/guardian_home.dart';
import 'package:tutor_kit/screens/home_screen/guardian/guardian_post_history.dart';
import 'package:tutor_kit/screens/home_screen/teacher/teacher_home.dart';

class CrudDb {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  CollectionReference posts = FirebaseFirestore.instance.collection("posts");
  addPost(
      String gender, String level, String salary, String dayPerWeek, String location, String curriculum, String subjects, String userEmail, FieldValue timestamp, String student, String time, String division, String district, String upazila, String union)async {
    try{
      //need to be fixed *****************************************
      posts.where("userEmail",isEqualTo: userEmail).get().then((snap) {
        if(snap.docs.isEmpty){
          posts.add({
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
            'isBooked' : false,
            'division' : division,
            'district' : district,
            'upazila' : upazila,
            'union' : union,
          }).whenComplete(() => Get.snackbar(
              "Attention",
              "Added Successfully",
              icon: Lottie.asset(
                "assets/icons/animation_lmej1fs8.json",
              ),
              animationDuration: Duration(
                seconds: 0,
              ),
              duration: Duration(seconds: 5),
              backgroundColor: Colors.green.shade100
          )).then((value) => Get.to(()=>GuardianPostHistory()));
        } else {
              if (kDebugMode) {
                print(snap.docs.isNotEmpty);
              }
              Get.snackbar(
                "Attention!",
                "Max post limit 1",
                backgroundColor: Colors.orange.shade100,
                icon: Lottie.asset(
                  "assets/icons/warning.json",
                ),
                animationDuration: Duration(
                  seconds: 0,
                ),
                duration: Duration(seconds: 5),
              );
            }
      });

      // posts.get().then((snap) {
      //   if(snap.docs.isEmpty){
      //     posts.add({
      //       'gender' : gender,
      //       'class' : level,
      //       'salary' : salary,
      //       'dayPerWeek' : dayPerWeek,
      //       'location' : location,
      //       'curriculum' : curriculum,
      //       'subjects' : subjects,
      //       'userEmail' : userEmail,
      //       'timestamp' : timestamp,
      //       'student' : student,
      //       'time' : time,
      //       'isBooked' : false,
      //     }).whenComplete(() => Get.snackbar("Attention", "Added Successfully",colorText: Colors.black,backgroundColor: Colors.black12)).then((value) => Get.to(()=>GuardianPostHistory()));
      //   } else {
      //     if (kDebugMode) {
      //       print(snap.docs.isNotEmpty);
      //     }
      //     Get.snackbar("Attention", "Max post limit 1");
      //   }
      // });
    } catch (e) {
      Get.snackbar(
        "Attention!",
        "Error Occurred",
        backgroundColor: Colors.red.shade100,
        icon: Lottie.asset(
          "assets/icons/wrong.json",
        ),
        animationDuration: Duration(
          seconds: 0,
        ),
        duration: Duration(seconds: 5),
      );
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
      posts.doc(docId).delete().whenComplete(() => Get.snackbar(
          "Attention",
          "Deleted Successfully",
          icon: Lottie.asset(
            "assets/icons/animation_lmej1fs8.json",
          ),
          animationDuration: Duration(
            seconds: 0,
          ),
          duration: Duration(seconds: 5),
          backgroundColor: Colors.green.shade100));
      FirebaseFirestore.instance.collection("teacherRequest").where("postID",isEqualTo: docId).get().then((trSnap) {
        FirebaseFirestore.instance.collection("teacherRequest").doc(trSnap.docs.first.id).delete();
      });
      FirebaseFirestore.instance.collection("guardianResponse").where("postId",isEqualTo: docId).get().then((grSnap) {
        FirebaseFirestore.instance.collection("guardianResponse").doc(grSnap.docs.first.id).delete();
      });
    } catch (e) {
      Get.snackbar(
        "Attention!",
        "Error Occurred",
        backgroundColor: Colors.red.shade100,
        icon: Lottie.asset(
          "assets/icons/wrong.json",
        ),
        animationDuration: Duration(
          seconds: 0,
        ),
        duration: Duration(seconds: 5),
      );
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
      }).whenComplete(() => Get.snackbar(
          "Attention",
          "Updated Successfully",
          icon: Lottie.asset(
            "assets/icons/animation_lmej1fs8.json",
          ),
          animationDuration: Duration(
            seconds: 0,
          ),
          duration: Duration(seconds: 5),
          backgroundColor: Colors.green.shade100)).then((value) => Get.off(()=>GuardianPostHistory()));
    } catch (e) {
      Get.snackbar(
        "Attention!",
        "Error Occurred",
        backgroundColor: Colors.red.shade100,
        icon: Lottie.asset(
          "assets/icons/wrong.json",
        ),
        animationDuration: Duration(
          seconds: 0,
        ),
        duration: Duration(seconds: 5),
      );
    }
  }

  CollectionReference teacherRequest = FirebaseFirestore.instance.collection("teacherRequest");
  addTeacherRequest(String email, String postID, String gToken, String tToken,FieldValue timestamp){
    teacherRequest.doc().set({
      "email" : email,
      "postID" : postID,
      "gToken" : gToken,
      "tToken" : tToken,
      "timestamp" : timestamp,
      "isRead" : false
    });
  }
  //TeacherForm
  addTeacherInfo(String name,String number, String gender, String dob, String address, String prefClass, String prefSubjects, String qualification, String institute, String department, String role,String division, String district, String upazila, String union){
    FirebaseFirestore.instance.collection("userInfo").doc(_auth.currentUser!.uid).update({
      "name": name,
      "number": number,
      "gender": gender,
      "dob": dob,
      "address": address,
      "prefClass": prefClass,
      "prefSubjects": prefSubjects,
      "qualification": qualification,
      "institute": institute,
      "department": department,
      "role": role,
      'division' : division,
      'district' : district,
      'upazila' : upazila,
      'union' : union,
      "updated" : true
    });
  }

  addGuardianResponse(String tName, String postId, FieldValue timestamp,String tEmail, String gEmail){
    FirebaseFirestore.instance.collection("guardianResponse").doc().set({
      "tName" : tName,
      "postId" : postId,
      "tEmail" : tEmail,
      "gEmail" : gEmail,
      "timestamp" : timestamp,
      "isRead" : false,
    });
  }
  teacherTransactionStatus(String tEmail, String postId, String invoiceNumber, double amount, String trxId, String payerReference, String paymentId, String customerMsisdn, FieldValue timestamp){
    FirebaseFirestore.instance.collection("teacherTransactionStatus").doc().set({
      "tEmail" : tEmail,
      "postId" : postId,
      "invoiceNumber" : invoiceNumber,
      "amount" : amount,
      "timestamp" : timestamp,
      "status" : true,
      "trxId" : trxId,
      "payerReference" : payerReference,
      "paymentId" : paymentId,
      "customerMsisdn" : customerMsisdn,
    });
  }

  updateTeacherProfile(String name, String dob, String address, String prefClass, String prefSubjects, String qualification,String institute,String department){
    try{
      FirebaseFirestore.instance.collection("userInfo").doc(FirebaseAuth.instance.currentUser!.uid).update({
        'name' : name,
        'dob' : dob,
        'address' : address,
        'prefClass' : prefClass,
        'prefSubjects' : prefSubjects,
        'qualification' : qualification,
        'institute' : institute,
        'department' : department
      }).whenComplete(() => Get.snackbar(
          "Attention",
          "Updated Successfully",
          icon: Lottie.asset(
            "assets/icons/animation_lmej1fs8.json",
          ),
          animationDuration: Duration(
            seconds: 0,
          ),
          duration: Duration(seconds: 5),
          backgroundColor: Colors.green.shade100)).then((value) => Get.offAll(()=>TeacherHome(currentNavIndex: 1.obs,)));
    } catch (e) {
      Get.snackbar(
        "Attention!",
        "Error Occurred.",
        backgroundColor: Colors.red.shade100,
        icon: Lottie.asset(
          "assets/icons/wrong.json",
        ),
        animationDuration: Duration(
          seconds: 0,
        ),
        duration: Duration(seconds: 5),
      );
    }
  }

  updateGuardianProfile(String name, String address, String mobile){
    try{
      FirebaseFirestore.instance.collection("userInfo").doc(FirebaseAuth.instance.currentUser!.uid).update({
        'name' : name,
        'address' : address,
        'mobile' : mobile,
      }).whenComplete(() => Get.snackbar("Attention", "Updated Successfully",icon: Lottie.asset(
        "assets/icons/animation_lmej1fs8.json",
      ),
          animationDuration: Duration(
            seconds: 0,
          ),
          duration: Duration(seconds: 5),
          backgroundColor: Colors.green.shade100)).then((value) => Get.offAll(()=>GuardianHome(currentNavIndex: 2.obs,)));
    } catch (e) {
      Get.snackbar(
        "Attention!",
        "Error Occurred.",
        backgroundColor: Colors.red.shade100,
        icon: Lottie.asset(
          "assets/icons/wrong.json",
        ),
        animationDuration: Duration(
          seconds: 0,
        ),
        duration: Duration(seconds: 5),
      );
    }
  }

}


// trSnap.docs.forEach((doc) {
//   FirebaseFirestore.instance.collection("teacherRequest").doc(doc.id).delete();
// });