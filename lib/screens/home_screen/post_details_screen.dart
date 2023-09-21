
import 'dart:convert';
import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:tutor_kit/bloc/crud_db.dart';
import 'package:tutor_kit/screens/home_screen/teacher_offer_screen.dart';
import 'package:tutor_kit/widgets/custom_button.dart';
import 'package:http/http.dart' as http;

import '../../const/colors.dart';
import '../../const/images.dart';
import '../../const/styles.dart';

class PostDetailesScreen extends StatefulWidget {
   PostDetailesScreen({super.key});

  @override
  State<PostDetailesScreen> createState() => _PostDetailesScreenState();
}

class _PostDetailesScreenState extends State<PostDetailesScreen> {
  var docId = Get.arguments;
  String? mtoken = "";
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    requestPermission();
    getToken();
    initInfo();
  }

  initInfo(){
    var android = const AndroidInitializationSettings('@mipmap/ic_launcher');
    //IOS
    final InitializationSettings initializationSettings = InitializationSettings(android: android);
    flutterLocalNotificationsPlugin.initialize(initializationSettings, onDidReceiveNotificationResponse: (NotificationResponse notificationResponse){
      switch (notificationResponse.notificationResponseType){
        case NotificationResponseType.selectedNotification:
          Get.to(()=>TeacherOfferScreen());
          print("Get.to");
          break;
        case NotificationResponseType.selectedNotificationAction:
          if(notificationResponse.actionId == "id"){
            print("Get.to");
          }
          break;
      }
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async{
      print("onMessage");
      print("onMessage: ${message.notification?.title}/${message.notification?.body}");
      BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
        message.notification!.body.toString(),
        htmlFormatContent: true,
        contentTitle: message.notification!.title.toString(),
        htmlFormatContentTitle: true,
      );
      AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails('tutor-kit', 'tutor-kit', importance: Importance.high,
      styleInformation: bigTextStyleInformation, priority: Priority.high, playSound: true);
      NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails);
      await flutterLocalNotificationsPlugin.show(0, message.notification?.title, message.notification?.body,notificationDetails,payload: message.data['body']);
    });
  }

  void getToken()async{
    await FirebaseMessaging.instance.getToken().then((token) {
      setState(() {
        mtoken = token;
        print('token : $mtoken');
      });
    });
  }

  void requestPermission()async{
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: false,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true

    );

    if(settings.authorizationStatus == AuthorizationStatus.authorized){
      print('User granted permission');
    } else if(settings.authorizationStatus == AuthorizationStatus.provisional){
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }

  void sendPushMessage(String token, String body, String title)async{
    try {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers:  {
          'Content-Type': 'application/json',
          'Authorization': 'key=AAAAxNs3MRQ:APA91bGmvCxjjPiL4EryQl_aCAZkvduQYna7Uy-NPTFwwdckWCy1-870TA00xsmrV8qSxvljmczhPB4bEH7wBunO-a3vRQZ0owzhZYMAOIblgMfEtBDfM2owCM0W-DS_LLH7ylRCgGGi'
        },
        body: jsonEncode(
           {
            "priority": "high",
            'data': {
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'status': 'done',
              'body': body,
              'title': title
            },
             'notification': {
              "title": title,
               "body": body,
               "android_channel_id": "tutor-kit"
             },
             "to": token
          }
        )
      );
    } catch (e){
      if(kDebugMode){
        print("error push notification");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference posts = FirebaseFirestore.instance.collection("posts");
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: FutureBuilder<DocumentSnapshot>(
              future: posts.doc(docId).get(),
              builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot){
                if(snapshot.hasError){
                  return const Text("Something went wrong");
                }
                if(snapshot.hasData && !snapshot.data!.exists){
                  return const Text("Document does not exist");
                }
                if(snapshot.connectionState == ConnectionState.done) {
                  Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                  Timestamp timestamp = data["timestamp"];
                  return Padding(
                    padding: const EdgeInsets.only(left: 10,right: 10,top: 8),
                    child: Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          //side: BorderSide(color: Colors.black)
                      ),
                      color: bgColor,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(5),
                                  width: MediaQuery.of(context).size.width*0.410,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white
                                  ),
                                  child: Row(
                                    children: [
                                      Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(100),
                                              side: BorderSide(color: Colors.black)
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Image.asset(icGender,width: 25,),
                                          )),
                                      SizedBox(width: 5,),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("Gender",style: TextStyle(fontSize: 16,fontFamily: roboto_bold),),
                                          Text("${data["gender"]}",style: TextStyle(fontFamily: roboto_regular)),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(5),
                                  width: MediaQuery.of(context).size.width*0.410,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white
                                  ),
                                  child: Row(
                                    children: [
                                      Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(100),
                                              side: BorderSide(color: Colors.black)
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Image.asset(icClass,width: 25,),
                                          )),
                                      SizedBox(width: 5,),
                                      Flexible(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("Class",style: TextStyle(fontSize: 16,fontFamily: roboto_bold),),
                                            Text("${data["class"]}",style: TextStyle(fontFamily: roboto_regular),),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5,),
                            Container(
                              padding: EdgeInsets.all(5),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white
                              ),
                              child: Row(
                                children: [
                                  Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(100),
                                          side: BorderSide(color: Colors.black)
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Image.asset(icSubjects,width: 25,),
                                      )),
                                  SizedBox(width: 5,),
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Subjects",style: TextStyle(fontSize: 16,fontFamily: roboto_bold),),
                                        Text("${data["subjects"]}",style: TextStyle(fontFamily: roboto_regular)),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 5,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(5),
                                  width: MediaQuery.of(context).size.width*0.410,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white
                                  ),
                                  child: Row(
                                    children: [
                                      Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(100),
                                              side: BorderSide(color: Colors.black)
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Image.asset(icDay,width: 25,),
                                          )),
                                      SizedBox(width: 5,),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("Day/Week",style: TextStyle(fontSize: 16,fontFamily: roboto_bold),),
                                          Text("${data["dayPerWeek"]}",style: TextStyle(fontFamily: roboto_regular)),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(5),
                                  width: MediaQuery.of(context).size.width*0.410,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white
                                  ),
                                  child: Row(
                                    children: [
                                      Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(100),
                                              side: BorderSide(color: Colors.black)
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Image.asset(icSalary,width: 25,),
                                          )),
                                      SizedBox(width: 5,),
                                      Flexible(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("Salary",style: TextStyle(fontSize: 16,fontFamily: roboto_bold),),
                                            Text("${data["salary"]}",style: TextStyle(fontFamily: roboto_regular,color: Colors.green)),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),

                              ],
                            ),
                            SizedBox(height: 5,),
                            Container(
                              padding: EdgeInsets.all(5),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white
                              ),
                              child: Row(
                                children: [
                                  Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(100),
                                          side: BorderSide(color: Colors.black)
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Image.asset(icLocation,width: 25,),
                                      )),
                                  SizedBox(width: 5,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Location",style: TextStyle(fontSize: 16,fontFamily: roboto_bold),),
                                      Text("${data["location"]}",style: TextStyle(fontFamily: roboto_regular)),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 5,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(5),
                                  width: MediaQuery.of(context).size.width*0.410,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white
                                  ),
                                  child: Row(
                                    children: [
                                      Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(100),
                                              side: BorderSide(color: Colors.black)
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Image.asset(icStudent,width: 25,),
                                          )),
                                      SizedBox(width: 5,),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("Students",style: TextStyle(fontSize: 16,fontFamily: roboto_bold),),
                                          Text("${data["student"]}",style: TextStyle(fontFamily: roboto_regular)),
                                        ],
                                      ),
                                      // Text("${snapshot.data!.docs[index]["salary"]}",style: TextStyle(fontFamily: roboto_regular,color: Colors.green)),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(5),
                                  width: MediaQuery.of(context).size.width*0.410,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white
                                  ),
                                  child: Row(
                                    children: [
                                      Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(100),
                                              side: BorderSide(color: Colors.black)
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Image.asset(icTime,width: 25,),
                                          )),
                                      SizedBox(width: 5,),
                                      Flexible(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("Time",style: TextStyle(fontSize: 16,fontFamily: roboto_bold),),
                                            Text("${data["time"]}",style: TextStyle(fontFamily: roboto_regular)),
                                          ],
                                        ),
                                      ),
                                      // Text("${snapshot.data!.docs[index]["salary"]}",style: TextStyle(fontFamily: roboto_regular,color: Colors.green)),
                                    ],
                                  ),
                                ),

                              ],
                            ),
                            SizedBox(height: 5,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(5),
                                  // width: double.infinity,
                                  width: MediaQuery.of(context).size.width*0.410,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white
                                  ),
                                  child: Row(
                                    children: [
                                      Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(100),
                                              side: BorderSide(color: Colors.black)
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Image.asset(icCurriculum,width: 25,),
                                          )),
                                      SizedBox(width: 5,),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("Curriculum",style: TextStyle(fontSize: 16,fontFamily: roboto_bold),),
                                          Text("${data["curriculum"]}",style: TextStyle(fontFamily: roboto_regular)),
                                        ],
                                      ),
                                      // Text("${snapshot.data!.docs[index]["salary"]}",style: TextStyle(fontFamily: roboto_regular,color: Colors.green)),
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Center(child: Text(timeago.format(DateTime.parse(timestamp.toDate().toString())),style: TextStyle(fontFamily: roboto_regular,color: Colors.blueGrey),)),
                                ),
                              ],
                            ),
                            SizedBox(height: 30,),
                            CustomButton(onPress: (){
                              var auth = FirebaseAuth.instance;
                              CrudDb().addTeacherRequest(auth.currentUser!.phoneNumber.toString(), docId, mtoken.toString(), FieldValue.serverTimestamp());
                              sendPushMessage(data["deviceToken"].toString(), "A tutor requested for your post", "New Request");
                              showDialog(context: context, builder: (BuildContext context){
                                return Dialog(
                                  child: Container(
                                    height: 350,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Lottie.asset(height: 200,"assets/icons/animation_lmej1fs8.json"),
                                        const Text("Request Sent"),
                                        CustomButton(onPress: (){Get.back();}, text: const Text("Okay"), color: Colors.green)
                                      ],
                                    ),
                                  ),
                                );
                              });
                            }, text: Text("Request Tution"), color: Colors.white),
                            // ElevatedButton(onPressed: (){
                            //   var token = "dDK1C6pWQP-drmsl377kTM:APA91bFxeD2KPEsL1uBiVxZtPX3tibjCUYt9zsm5QAALXmphzmpa67ud0AbdPxmCF3FBsmuBoLwAwZ9WcF3v0RfMKUr10MbmRI5aytMfrfEsyw0YS59NlYMtJFnAorrscFhG6--0Sego";
                            //   // await FirebaseFirestore.instance.collection(collectionPath)
                            //   sendPushMessage(data["deviceToken"].toString(), "A tutor requested for your post", "New Request");
                            // }, child: Text("Send"))
                          ],
                        ),
                      ),),
                  );
                }
                return CircularProgressIndicator();
              }
          ),
        ),
      ),
    );
  }
}
