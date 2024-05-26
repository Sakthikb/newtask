import 'package:flutter/material.dart';
import 'package:newtask/AddScreen.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({Key? key}) : super(key: key);

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff84b6f4),
        title: Text(
          "Go Task",
          style:
          TextStyle(color: Color(0xff1560bc),fontWeight: FontWeight.w600,),
        ),
        actions: [
          SizedBox(width: 10,),
          CircleAvatar(
            radius: 30,
            backgroundColor: Color(0xff1560bc),
            child: IconButton(
              onPressed: () {
                Navigator.push(context,MaterialPageRoute(builder: (context)=>AddTaskpageScreen(),));
              },
              icon: Icon(
                Icons.add_circle_outline_sharp,
                color: Color(0xffFFFFFF),
              ),
            ),
          ),
          SizedBox(width: 20,),
        ],
        toolbarOpacity: 0.8,
        toolbarHeight: 100,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20),

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
        child: Column(
          children: [
            SizedBox(height: 200,),
            Align(
              alignment: Alignment.center,
              child: Container(
                child: Container(child: Text("No task found",
                  style: TextStyle(color: Color(0xff84b6f4),fontWeight: FontWeight.w300),)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
