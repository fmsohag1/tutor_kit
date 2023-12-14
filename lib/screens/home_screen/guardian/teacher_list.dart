import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tutor_kit/bloc/lite_api.dart';
import 'package:tutor_kit/const/consts.dart';
import 'package:tutor_kit/drafts/darft1.dart';
import 'package:tutor_kit/screens/home_screen/guardian/teacher_details_screen.dart';

class TeacherList extends StatelessWidget {
  TeacherList({super.key});
  
  var userPhoto = FirebaseAuth.instance.currentUser?.photoURL;
  bool isImage=false;
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
      backgroundColor: bgColor2,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: bgColor2,
        title: Text("Teachers List"),
      ),
      body: SafeArea(
        child: FutureBuilder<QuerySnapshot>(
            future: FirebaseFirestore.instance.collection("userInfo").where("role", isEqualTo: "tt").where('updated',isEqualTo: true).get(),
            builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
              if(snapshot.connectionState == ConnectionState.done){
                if(snapshot.data!.docs.isEmpty){
                  return Center(child: Text("No teachers to show"),);
                }
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: AnimationLimiter(
                    child: GridView.builder(
                        itemCount: snapshot.data!.docs.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 7,
                            mainAxisSpacing: 7),
                        itemBuilder: (context, index) {
                          return AnimationConfiguration.staggeredGrid(
                            position: index,
                            duration: const Duration(milliseconds: 300),
                            columnCount: 2,
                            child: ScaleAnimation(
                              child: FadeInAnimation(
                                child: GestureDetector(
                                  onTap: (){
                                    Get.to(()=>TeacherDetailsScreen(),arguments: snapshot.data!.docs[index]["email"]);
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.grey.shade300
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
                                                  borderRadius: BorderRadius.only(topRight: Radius.circular(10),topLeft: Radius.circular(10),bottomLeft: Radius.circular(5),bottomRight: Radius.circular(5)),
                                                  color: bgColor2
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(4.0),
                                                  child: CircleAvatar(child: isImage?CircleAvatar(backgroundImage: NetworkImage(userPhoto!),radius: 35,):Text("${snapshot.data!.docs[index]["name"][0]}",style: TextStyle(fontSize: 30),),radius: 30,backgroundColor: Colors.brown.shade50,)
                                              )
                                          ),
                                          //SizedBox(height: 5,),
                                          Flexible(child: Text("${snapshot.data!.docs[index]["name"]}",style: TextStyle(fontWeight: FontWeight.w600,),maxLines: 1,overflow: TextOverflow.ellipsis,)),
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
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                );
              }
              return Center(child: CircularProgressIndicator(color: Colors.black12,strokeAlign: -1,));
            }
        ),
      ),

    );
  }
}

