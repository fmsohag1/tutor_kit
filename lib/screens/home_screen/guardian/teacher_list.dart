import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tutor_kit/bloc/lite_api.dart';
import 'package:tutor_kit/const/consts.dart';
import 'package:tutor_kit/drafts/darft1.dart';
import 'package:tutor_kit/screens/home_screen/guardian/teacher_details_screen.dart';

class TeacherList extends StatelessWidget {
  TeacherList({super.key});

  var userphoto = FirebaseAuth.instance.currentUser?.photoURL;
  var box = GetStorage();
  List trTotalList = [];
  List trNewList = [];
  int trTotal = 0;
  int trNew = 0;

  @override
  Widget build(BuildContext context) {
    // FirebaseFirestore.instance.collection("posts").where("userEmail",isEqualTo: FirebaseAuth.instance.currentUser!.email).get().then((pSnap) {
    //   FirebaseFirestore.instance.collection("teacherRequest").where("postID",isEqualTo: pSnap.docs.first.id).where("isRead", isEqualTo: false).get().then((trSnap) {
    //     LiteApi.trTotal = trSnap.docs.length;
    //   });
    // });
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Text("Teachers List"),
      ),
      body: FutureBuilder<QuerySnapshot>(
          future: FirebaseFirestore.instance.collection("userInfo").where("role", isEqualTo: "tt").get(),
          builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
            if(snapshot.connectionState == ConnectionState.done){
              if(snapshot.data!.docs.isEmpty){
                return Center(child: Text("No teachers to show"),);
              }
              return Padding(
                padding: const EdgeInsets.all(16),
                child: GridView.builder(
                    itemCount: snapshot.data!.docs.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 7,
                        mainAxisSpacing: 7),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: (){
                          Get.to(()=>TeacherDetailsScreen(),arguments: snapshot.data!.docs[index]["email"]);
                        },
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: primary
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    height: 80,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(topRight: Radius.circular(10),topLeft: Radius.circular(10)),
                                        color: secondary
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: CircleAvatar(child: Image.network("https://cdn-icons-png.flaticon.com/512/9187/9187475.png",width: 50,),backgroundColor: primary,),
                                    )
                                ),
                                SizedBox(height: 5,),
                                Flexible(child: Text("${snapshot.data!.docs[index]["name"]}",style: TextStyle(fontWeight: FontWeight.w800,color: buttonColor),maxLines: 1,overflow: TextOverflow.ellipsis,)),
                                SizedBox(height: 5,),
                                Row(
                                  children: [
                                    SvgPicture.asset(icDepartment,width: 20,),
                                    SizedBox(width: 5,),
                                    Flexible(child: Text("${snapshot.data!.docs[index]["department"]}",style: TextStyle(fontSize: 12),maxLines: 1,overflow: TextOverflow.ellipsis,))
                                  ],
                                ),
                                SizedBox(height: 5,),
                                Row(
                                  children: [
                                    SvgPicture.asset(icInstitute,width: 20,),
                                    SizedBox(width: 5,),
                                    Flexible(child: Text("${snapshot.data!.docs[index]["institute"]}",style: TextStyle(fontSize: 12),maxLines: 1,overflow: TextOverflow.ellipsis,))
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              );
            }
            return Center(child: CircularProgressIndicator());
          }
      ),

    );
  }
}

/*Card(
elevation: 0,
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(15),
side: BorderSide(color: Colors.black)
),
color: Colors.brown.shade50,
child: Padding(
padding: const EdgeInsets.all(10),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Container(

child: Row(
children: [
Card(
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(100),
//side: BorderSide(color: Colors.black)
),
child: CircleAvatar(backgroundImage: AssetImage("assets/icons/display-pic.png"),radius: 30,)
),
Container(
padding: EdgeInsets.all(5),

child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text("${snapshot.data!.docs[index]["name"]}",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
],
),
),
],
),
),
Container(
padding: EdgeInsets.all(5),
width: double.infinity,
decoration: BoxDecoration(
borderRadius: BorderRadius.circular(10),
color: Colors.white
),
child: Column(
children: [
Container(

child: Row(
children: [
Card(
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(100),
side: BorderSide(color: Colors.black)
),
child: Padding(
padding: const EdgeInsets.all(8.0),
child: Image.asset(icInstitute,width: 25,),
)),
SizedBox(width: 5,),
Flexible(
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text("Institute",style: TextStyle(fontSize: 16,fontFamily: roboto_bold),),
Text("${snapshot.data!.docs[index]["institute"]}",style: TextStyle(fontFamily: roboto_regular)),
],
),
)
],
),
),
SizedBox(height: 5,),
Container(

child: Row(
children: [
Card(
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(100),
side: BorderSide(color: Colors.black)
),
child: Padding(
padding: const EdgeInsets.all(8.0),
child: Image.asset(icDepartment,width: 25,),
)),
SizedBox(width: 5,),
Flexible(
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text("Department",style: TextStyle(fontSize: 16,fontFamily: roboto_bold),),
Text("${snapshot.data!.docs[index]["department"]}",style: TextStyle(fontFamily: roboto_regular)),
],
),
)
],
),
),
],
),
),

],
)

),
);*/
