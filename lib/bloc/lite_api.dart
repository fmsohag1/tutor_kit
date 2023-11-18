import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LiteApi {
  static int trTotal = 0;
  //
  static void readRequest() {
    FirebaseFirestore.instance.collection("posts").where("userEmail",isEqualTo: FirebaseAuth.instance.currentUser!.email).get().then((pSnap) {
      if(pSnap.docs.isNotEmpty){
        FirebaseFirestore.instance.collection("teacherRequest").where("postID",isEqualTo: pSnap.docs.first.id).where("isRead", isEqualTo: false).get().then((trSnap) {
          trSnap.docs.forEach((doc) {
            FirebaseFirestore.instance.collection("teacherRequest").doc(doc.id).update({
              "isRead" : true
            });
          });
        });
      }
    });
  }

  static void readResponse() {
    FirebaseFirestore.instance.collection("guardianResponse").where("tEmail",isEqualTo: FirebaseAuth.instance.currentUser!.email).where("isRead",isEqualTo: false).get().then((pSnap) {
      if(pSnap.docs.isNotEmpty){
        pSnap.docs.forEach((doc) {
          FirebaseFirestore.instance.collection("guardianResponse").doc(doc.id).update({
            "isRead" : true,
          });
        });
      }
    });
  }
}

