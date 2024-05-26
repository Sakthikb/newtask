
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newtask/taskscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  bool password =true;
  void check() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool? c = await pref.getBool('logstatus');
    if (c == true) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TaskScreen(),
          ));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    check();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("9:41",style: TextStyle(fontSize:20,fontWeight:FontWeight.w400,color: Color(0xff2e3641)),),
        backgroundColor: Color(0xffb7d6ff),
        actions: [
          Icon(Icons.signal_cellular_alt,size:20,color:Color(0xff2e3641),),
          SizedBox(width: 5,),
          Icon(Icons.wifi,size:20,color: Color(0xff2e3641),),
          SizedBox(width: 5,),
          RotatedBox(quarterTurns: 1,
          child: Icon(Icons.battery_6_bar_rounded,size:20,color: Color(0xff2e3641),)),
        ],
        toolbarOpacity: 0.8,
        toolbarHeight: 20,
      ),
      body:
        SingleChildScrollView(
          child: Container(
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
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 80,
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    height: 30,
                    width: 200,
                    child: Text(
                      "Welcome",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color(0xff1560BC),
                          fontSize: 25,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 25,
                    width: 200,
                    child: Text(
                      "Login to Continue",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color(0xff3787EB),
                          fontSize: 10,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w300),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 20,
                  ),
                  child: Text("Email / Phone",style: TextStyle(color: Color(0xff95c0f4)),),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: TextFormField(
                    controller: email,
                    decoration: InputDecoration(
                         filled: true,
                        fillColor: Color(0xffA6CBF8),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide:
                          BorderSide(color: Color(0xffcfe4fe), width: 2),
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
                  child: Text("Password",style: TextStyle(color: Color(0xff95c0f4))),
                ),
                SizedBox(height: 5,),
                Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: TextFormField(
                    controller: pass,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xffA6CBF8),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide:
                          BorderSide(color: Color(0xffcfe4fe), width: 2),
                        )),
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    onPressed: () async{
                      if (email.text.isNotEmpty && pass.text.isNotEmpty) {
                        try {
                          var creden = await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                              email: email.text, password: pass.text);
                        }
                        on FirebaseAuthException catch (e) {
                          if (e.code == 'weak-password') {
                            print('The password provided is too weak.');
                          } else if (e.code == 'email-already-in-use') {
                            print('The account already exists for that email.');
                          }
                        }
                        catch (e) {
                          print(e);
                        }
                        try {
                          var login = await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                              email: email.text, password: pass.text)
                              .then((value) => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TaskScreen(),
                              )));
                          check();
                          SharedPreferences pref =
                          await SharedPreferences.getInstance();
                          await pref.setBool('logstatus', true);
                          email.clear();
                          pass.clear();
                        } catch (e) {
                          print(e.toString());
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(content: Text(e.toString())));
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Please Fill the above fields')));
                      }
                    },
                    child: Text(
                      "Login",
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    style: TextButton.styleFrom(
                      splashFactory: NoSplash.splashFactory,
                      fixedSize: const Size(200, 50),
                      backgroundColor: Colors.blue,
                      // side: BorderSide(
                      //     width: 2,
                      //     color: Color(0xff1560bc),
                      //     style: BorderStyle.values[1]),
                      padding: const EdgeInsets.all(10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
          
                      ),
                      enableFeedback: true,
                      elevation: 5,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 50,
                    width: 200,
                    child: Text(
                      "Don't have a account? SignUp ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 10,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w300),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

    );
  }
}
