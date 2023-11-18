
import 'dart:convert';
import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:tutor_kit/bloc/crud_db.dart';
import 'package:tutor_kit/screens/home_screen/guardian/requested_teacher_screen.dart';
import 'package:tutor_kit/screens/home_screen/teacher/guardian_response.dart';
import 'package:tutor_kit/screens/home_screen/teacher/teacher_offer_screen.dart';
import 'package:tutor_kit/widgets/custom_alert_dialog.dart';
import 'package:tutor_kit/widgets/custom_button.dart';
import 'package:http/http.dart' as http;

import '../../../const/colors.dart';
import '../../../const/images.dart';
import '../../../const/styles.dart';
import 'PostScreen/widget/postdata.dart';

class PostDetailesScreen extends StatefulWidget {
  PostDetailesScreen({super.key});

  @override
  State<PostDetailesScreen> createState() => _PostDetailesScreenState();
}

class _PostDetailesScreenState extends State<PostDetailesScreen> {

  var auth = FirebaseAuth.instance;

  var docId = Get.arguments;
  String? tToken = "";
  String? deviceToken;
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
          Get.to(()=>RequestedTeacherScreen());
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
        tToken = token;
        print('token : $tToken');
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
    bool? isGrContain;
    FirebaseFirestore.instance.collection("guardianResponse").where("tEmail",isEqualTo: FirebaseAuth.instance.currentUser!.email).where("postId",isEqualTo: docId).get().then((value) {
      if(value.docs.isNotEmpty){
        isGrContain = true;
      }
    });
    return Scaffold(
      backgroundColor: primary,
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
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            PostData(
                              icon: SvgPicture.asset(icGender),
                              width: MediaQuery.of(context)
                                  .size
                                  .width *
                                  0.410,
                              title: "Gender",
                              subtitle: "${data["gender"]}",
                            ),
                            PostData(
                              icon: SvgPicture.asset(icClass),
                              width: MediaQuery.of(context)
                                  .size
                                  .width *
                                  0.410,
                              title: "Class",
                              subtitle: "${data["class"]}",
                            ),
                          ],
                        ),
                        SizedBox(height: 5,),
                        PostData(
                          icon: SvgPicture.asset(icSubjects),
                          width: double.infinity,
                          title: "Subjects",
                          subtitle: "${data["subjects"]}",
                        ),
                        SizedBox(height: 5,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            PostData(
                              icon: SvgPicture.asset(icDay),
                              width: MediaQuery.of(context)
                                  .size
                                  .width *
                                  0.410,
                              title: "Day/Week",
                              subtitle: "${data["dayPerWeek"]}",
                            ),
                            PostData(
                              icon: SvgPicture.asset(icSalary,width: 20,),
                              width: MediaQuery.of(context)
                                  .size
                                  .width *
                                  0.410,
                              title: "Salary",
                              subtitle: "${data["salary"]} BDT",
                            ),

                          ],
                        ),
                        SizedBox(height: 5,),
                        PostData(
                          icon: SvgPicture.asset(icLocation),
                          width: double.infinity,
                          title: "Location",
                          subtitle: "${data["location"]}",
                        ),
                        SizedBox(height: 5,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            PostData(
                              icon: SvgPicture.asset(icStudent),
                              width: MediaQuery.of(context)
                                  .size
                                  .width *
                                  0.410,
                              title: "Students",
                              subtitle: "${data["student"]}",
                            ),
                            PostData(
                              icon: SvgPicture.asset(icTime),
                              width: MediaQuery.of(context)
                                  .size
                                  .width *
                                  0.410,
                              title: "Time",
                              subtitle: "${data["time"]}",
                            ),

                          ],
                        ),
                        SizedBox(height: 5,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            PostData(
                              icon: SvgPicture.asset(icCurriculum),
                              width: MediaQuery.of(context)
                                  .size
                                  .width *
                                  0.410,
                              title: "Curriculum",
                              subtitle: "${data["curriculum"]}",
                            ),
                            Container(
                              child: Center(child: Text(timeago.format(DateTime.parse(timestamp.toDate().toString())),style: TextStyle(fontFamily: roboto_regular,color: Colors.blueGrey),)),
                            ),
                          ],
                        ),
                        SizedBox(height: 30,),
                        data["isBooked"] == false ?
                        FutureBuilder<QuerySnapshot>(
                            future: FirebaseFirestore.instance.collection("teacherRequest").where("postID", isEqualTo: docId).where("email", isEqualTo: auth.currentUser!.email.toString()).get(),
                            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> btnSnap){
                              // Map<String, dynamic> btnData = snapshot.data!.data() as Map<String, dynamic>;
                              if(btnSnap.connectionState == ConnectionState.waiting){
                                return Center(child: CircularProgressIndicator());
                              }
                              if(btnSnap.connectionState == ConnectionState.done){
                                if(btnSnap.data!.docs.isNotEmpty){
                                  return Column(
                                    children: [
                                      CustomButton(onPress: (){
                                        Get.snackbar("Attention",
                                          "Request sent already, wait for guardian response",
                                          backgroundColor: Colors.orange.shade200,
                                          icon: Lottie.asset(
                                            "assets/icons/warning.json",
                                          ),
                                          animationDuration: Duration(
                                            seconds: 0,
                                          ),
                                          duration: Duration(seconds: 5),
                                        );
                                      }, text: "Wait for guardian response...", color: Colors.grey.shade400),
                                      IconButton(onPressed: (){
                                        FirebaseFirestore.instance.collection("teacherRequest").doc(btnSnap.data!.docs.first.id).delete();
                                        setState(() {
                                          
                                        });
                                      }, icon: Icon(Icons.cancel))
                                    ],
                                  );
                                }
                                if(btnSnap.data!.docs.isEmpty){
                                  if(isGrContain == true){
                                    return CustomButton(onPress: (){
                                      Get.to(()=>GuardianResponse());
                                    }, text: "Check Guardian Response", color: Colors.grey.shade600);
                                  } else {
                                    return CustomButton(onPress: ()async{
                                      var auth = FirebaseAuth.instance;
                                      await FirebaseFirestore.instance.collection("userInfo").where("email", isEqualTo: data["email"]).get().then((snap) {
                                        deviceToken = snap.docs.first["deviceToken"].toString();
                                        print(tToken);
                                      });
                                      print(data["email"]);
                                      print("deviceTok: $deviceToken" );
                                      sendPushMessage(deviceToken.toString(), "A tutor requested for your post", "New Request");
                                      await CrudDb().addTeacherRequest(auth.currentUser!.email.toString(), docId, tToken.toString(), deviceToken.toString(), FieldValue.serverTimestamp());
                                      setState(() {
                                      });
                                      await showDialog(context: context, builder: (BuildContext context){
                                        return CustomAlertDialog(text: "Request Sent Successfully", assets: "assets/icons/animation_lmej1fs8.json",onTap: (){
                                          Get.back();
                                        },);
                                      });
                                    }, text: "Send request", color: Colors.grey.shade600);
                                  }
                                }
                              }
                              return Center(child: CircularProgressIndicator());
                            }
                        ) :CustomButton(onPress: (){
                          Get.snackbar("Attention",
                            "This tuition is booked",
                            backgroundColor: Colors.orange.shade200,
                            icon: Lottie.asset(
                              "assets/icons/warning.json",
                            ),
                            animationDuration: Duration(
                              seconds: 0,
                            ),
                            duration: Duration(seconds: 5),
                          );
                        }, text: "Booked", color: Colors.red.shade200),

                        // ElevatedButton(onPressed: (){
                        //   var token = "dDK1C6pWQP-drmsl377kTM:APA91bFxeD2KPEsL1uBiVxZtPX3tibjCUYt9zsm5QAALXmphzmpa67ud0AbdPxmCF3FBsmuBoLwAwZ9WcF3v0RfMKUr10MbmRI5aytMfrfEsyw0YS59NlYMtJFnAorrscFhG6--0Sego";
                        //   // await FirebaseFirestore.instance.collection(collectionPath)
                        //   sendPushMessage(data["deviceToken"].toString(), "A tutor requested for your post", "New Request");
                        // }, child: Text("Send"))
                      ],
                    ),
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
