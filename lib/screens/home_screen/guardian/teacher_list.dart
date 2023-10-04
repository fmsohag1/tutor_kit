import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:tutor_kit/const/consts.dart';
import 'package:tutor_kit/drafts/darft1.dart';

class TeacherList extends StatelessWidget {
  const TeacherList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Teachers List"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<QuerySnapshot>(
            future: FirebaseFirestore.instance.collection("userInfo").where("role", isEqualTo: "tt").get(),
            builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
              if(snapshot.connectionState == ConnectionState.done){
                return GridView.builder(
                    itemCount: snapshot.data!.docs.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisSpacing: 5,crossAxisSpacing: 5),
                    itemBuilder: (context,index){
                      return Container(
                        height: MediaQuery.of(context).size.height*0.350,
                        width: MediaQuery.of(context).size.width*0.350,
                        decoration: BoxDecoration(
                            image: DecorationImage(image: AssetImage("assets/images/img.png"),fit: BoxFit.cover),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              height: 80,
                              width: double.infinity,

                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10)),
                                color: Colors.black54,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset(icProfile,width: 20,color: Colors.white,),
                                        SizedBox(width: 5,),
                                        Flexible(child: Text(snapshot.data!.docs[index]["name"].toString(),style: TextStyle(color: Colors.white),))
                                      ],
                                    ),
                                    SizedBox(height: 10,),
                                    Row(
                                      children: [
                                        SizedBox(width: 2,),
                                        Image.asset(icGender,width: 20,color: Colors.white,),
                                        SizedBox(width: 5,),
                                        Text(snapshot.data!.docs[index]["gender"].toString(),style: TextStyle(color: Colors.white),)
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    });
              }
              return Center(child: CircularProgressIndicator());
            }
        )
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){

        // Get.to(()=>DemoPage());
      }),
    );
  }
}
