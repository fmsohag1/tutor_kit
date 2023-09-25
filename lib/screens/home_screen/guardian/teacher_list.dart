import 'package:tutor_kit/const/consts.dart';

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
        child: GridView.builder(
          itemCount: 6,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisSpacing: 5,crossAxisSpacing: 5),
            itemBuilder: (context,index){
              return Container(
                height: MediaQuery.of(context).size.height*0.350,
                width: MediaQuery.of(context).size.width*0.350,
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage("assets/images/bgImage.jpg"),fit: BoxFit.cover),
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
                                Flexible(child: Text("Faisal Mahmud Sohag",style: TextStyle(color: Colors.white),))
                              ],
                            ),
                            SizedBox(height: 10,),
                            Row(
                              children: [
                                SizedBox(width: 2,),
                                Image.asset(icGender,width: 20,color: Colors.white,),
                                SizedBox(width: 5,),
                                Text("Male",style: TextStyle(color: Colors.white),)
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
            }),
      ),
    );
  }
}