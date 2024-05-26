import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newtask/Homepage.dart';

class EditTaskScreen extends StatefulWidget {
  const EditTaskScreen({Key? key}) : super(key: key);

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  TextEditingController taskname = TextEditingController();
  TextEditingController setdate = TextEditingController();
  TextEditingController description = TextEditingController();
  // bool value = false;
  bool value1 = true;
  List priority = [
    "Importance","None","Importance","None"
  ];
  List b = [false,false,false,false,];
  int currentindex = 0;

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState>states){
      const Set<MaterialState>interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.focused,
      };
      if(states.any(interactiveStates.contains)){
        return Color(0xff1560bc);
      }
      return Color(0xff95c0f4);
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff84b6f4),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios_new_sharp,
                color: Color(0xff1560bc),
              )),
          title: Text(
            "Edit Task",
            style: TextStyle(
              color: Color(0xff1560bc),
              fontWeight: FontWeight.w600,
            ),
          ),
          actions: [
            SizedBox(
              width: 10,
            ),
            CircleAvatar(
              radius: 30,
              backgroundColor: Color(0xff1560bc),
              child: IconButton(
                onPressed: () {
                  FirebaseFirestore.instance
                      .collection("new")
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .update({
                    "taskname": taskname.text,
                    "setdate": setdate.text,
                    "descripition":description.text,

                  }).then((value) {
                    taskname.clear();
                    setdate.clear();
                    description.clear();
                    Navigator.pop(context);
                  });
                },
                icon: Icon(
                  Icons.check,
                  color: Color(0xffFFFFFF),
                ),
              ),
            ),
            SizedBox(
              width: 20,
            ),
          ],
          toolbarOpacity: 0.8,
          toolbarHeight: 100,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              )),
        ),
        body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                colors: [
                  Color(0xffFFFFFF),
                  Color(0xffD6E8FF),
                ],
              ),
            ),

            child:StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("new")
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    SizedBox(height: 20,),
                Padding(
                padding: EdgeInsets.only(
                left: 20,
                ),
                  child: Row(

                    children: [
                      Text(
                        "Delete Task?",
                        style: TextStyle(color: Color(0xff1560bc),fontWeight: FontWeight.w600),
                      ),
                      SizedBox(width:180),
                      ElevatedButton(onPressed: () async {
                        await FirebaseFirestore.instance
                            .collection("new")
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .delete();
                      }, child: Text("Delete"),
                          style: TextButton.styleFrom(
                            splashFactory: NoSplash.splashFactory,
                            fixedSize: const Size(100, 50),
                            backgroundColor: Color(0xff1560bc),
                            padding: const EdgeInsets.all(10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),

                            ),
                            enableFeedback: true,
                            elevation: 5,
                          ),


                      ),
                    ],
                  ),
                ),

                        SizedBox(height: 20,),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 20,
                          ),
                          child: Text(
                            "Task Name",
                            style: TextStyle(color: Color(0xff95c0f4)),
                          ),
                        ),

                        SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: TextFormField(
                            controller: taskname,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(20),
                                filled: true,
                                fillColor: Color(0xffA6CBF8),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(
                                      color: Color(0xffcfe4fe), width: 2),
                                )),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 20,
                          ),
                          child: Text(
                              "Set Date", style: TextStyle(color: Color(0xff95c0f4))),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: TextFormField(
                            controller: setdate,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(20),
                                suffixIcon: IconButton(onPressed: () {},
                                  icon: Icon(
                                    Icons.calendar_month, color: Color(0xff1560bc),),
                                ),
                                filled: true,
                                fillColor: Color(0xffA6CBF8),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(
                                      color: Color(0xffcfe4fe), width: 2),
                                )),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        SizedBox(height: 10,),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 20,
                          ),
                          child: Text(
                              "Description", style: TextStyle(color: Color(0xff95c0f4))),
                        ),
                        SizedBox(height: 5,),
                        Padding(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: TextFormField(
                            controller: description,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(40),
                                filled: true,
                                fillColor: Color(0xffA6CBF8),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(
                                      color: Color(0xffcfe4fe), width: 2),
                                )),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        SizedBox(height: 10,),
                        const Padding(
                          padding: EdgeInsets.only(
                            left: 20,
                          ),
                          child: Text("Priority Level",
                              style: TextStyle(color: Color(0xff95c0f4))),
                        ),
                        SizedBox(height: 5,),
                        GridView.builder(shrinkWrap: true,
                          gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisExtent: 70,
                          ),
                          itemCount:priority.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              onTap: (){
                                currentindex=index;
                              },
                              leading: Transform.scale(
                                scale: 2.0,
                                child: Checkbox(
                                    tristate:b[index],
                                    checkColor:Colors.white,
                                    fillColor:MaterialStateProperty.resolveWith(getColor),
                                    value: b[index],
                                    onChanged:(bool ? value){
                                      b=[false,false,false,false];
                                      setState(() {
                                        b[index] = !b[index];
                                      });
                                    }
                                ),
                              ),
                              title:Text(priority[index],style: TextStyle(color: Color(0xff3787EB))) ,
                            );
                          },)
                      ]
                  );
                }
                else
                {
                  return CircularProgressIndicator();
                }
              },
            )
        )
    );
  }}
