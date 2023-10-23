import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:tutor_kit/const/consts.dart';
import 'package:tutor_kit/drafts/darft1.dart';

class TeacherList extends StatelessWidget {
  TeacherList({super.key});

  var userphoto = FirebaseAuth.instance.currentUser?.photoURL;

  @override
  Widget build(BuildContext context) {
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
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context,index){
                    return Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                        height: 220,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Colors.brown.shade100)
                        ),
                        child: Column(
                          children: [
                            Container(
                                height: 80,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15)),
                                    color: Colors.brown.shade100
                                ),
                                child: Row(
                                  children: [
                                    Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(100),
                                          //side: BorderSide(color: Colors.black)
                                        ),
                                        child: CircleAvatar(backgroundImage: AssetImage("assets/icons/display-pic.png"),radius: 30,)
                                    ),
                                    SizedBox(width: 5,),
                                    Flexible(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text("${snapshot.data!.docs[index]["name"]}",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w600),maxLines: 2,),
                                        ],
                                      ),
                                    ),
                                  ],
                                )),
                            Container(
                              height: 120,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15),bottomRight: Radius.circular(15)),
                              ),
                              child: Column(
                                children: [
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
                        ),
                      ),
                    );
                  });
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
