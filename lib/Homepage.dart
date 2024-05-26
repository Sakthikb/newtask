import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:newtask/Edit&DeleteScreen.dart';

class SetTaskScreen extends StatefulWidget {
  const SetTaskScreen({Key? key}) : super(key: key);

  @override
  State<SetTaskScreen> createState() => _SetTaskScreenState();
}

class _SetTaskScreenState extends State<SetTaskScreen> {
  // late List<bool> b;
  List b = [];
  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Color(0xff1560bc);
      }
      return Color(0xff95c0f4);
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff84b6f4),
        title: Text(
          "Go Task",
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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditTaskScreen(),
                    ));
              },
              icon: Icon(
                Icons.add_circle_outline_sharp,
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
      body: SingleChildScrollView(
        clipBehavior: Clip.hardEdge,
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  colors: [
                    Color(0xffFFFFFF),
                    Color(0xffD6E8FF),
                  ],
                ),
              ),
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance.collection("new").snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      print(snapshot.data!.docs.length);
                      final tasks = snapshot.data!.docs;
                      b = List<bool>.filled(tasks.length, false);
                      int length = snapshot.data!.docs.length;
                      return ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            print(snapshot.data!.docs.length);
                            print(snapshot.data!.docs[index].id);
                            final task = tasks[index];
                            return Card(
                              color: Colors.white,
                              margin: EdgeInsets.all(10),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Card(
                                      color: Color(0xff95c0f4),
                                      child: Container(
                                        height: 90,
                                        width: 90,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(
                                              "images/pad.png",
                                            ),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        task['taskname'],
                                        // snapshot.data!.docs[index]["taskname"],
                                        style: TextStyle(
                                            color: Color(0xff1560bc),
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(
                                            child: Text(
                                              "Priority Level : ",
                                              style: TextStyle(
                                                  color: Color(0xff95c0f4),
                                                  fontWeight: FontWeight.w300),
                                            ),
                                          ),
                                          Text(
                                            task['prioritylevel'],
                                            // snapshot.data!.docs[index]
                                            //     ["prioritylevel"],
                                            style: TextStyle(color: Colors.red),
                                          ),
                                          SizedBox(width: 30),
                                          Transform.scale(
                                            scale: 2.0,
                                            child: Checkbox(
                                                tristate: b[index],
                                                checkColor: Colors.white,
                                                fillColor: MaterialStateProperty
                                                    .resolveWith(getColor),
                                                value: b[index],
                                                onChanged: (bool? value) {
                                                  b = [false];
                                                  setState(() {
                                                    b[index] = !b[index];
                                                  });
                                                }),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        "Date:${task['setdate']}",
                                        // "Date:${snapshot.data!.docs[index]["setdate"]}",
                                        style: TextStyle(
                                            color: Color(0xff95c0f4),
                                            fontWeight: FontWeight.w300),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          });
                    } else {
                      return CircularProgressIndicator();
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
