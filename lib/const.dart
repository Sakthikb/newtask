import 'package:flutter/material.dart';

class Constbar extends StatefulWidget {
  const Constbar({Key? key}) : super(key: key);

  @override
  State<Constbar> createState() => _ConstbarState();
}

class _ConstbarState extends State<Constbar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("9:41",style: TextStyle(fontWeight:FontWeight.w500,color: Color(0xff2e3641)),),
        backgroundColor: Color(0xffb7d6ff),
        actions: [
          Icon(Icons.signal_cellular_alt,color:Color(0xff2e3641),),
          SizedBox(width: 5,),
          Icon(Icons.wifi,color: Color(0xff2e3641),),
          SizedBox(width: 5,),
          RotatedBox(quarterTurns: 1,
              child: Icon(Icons.battery_6_bar_rounded,color: Color(0xff2e3641),)),
        ],
        toolbarOpacity: 0.8,
        toolbarHeight: 30,
      ),
    );
  }
}
