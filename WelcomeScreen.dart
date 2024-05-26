import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 30),
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              colors: [
                Colors.white,
                Colors.white,
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 100,
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height: 25,
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
                height: 50,
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
                        borderSide:
                        BorderSide(color: Color(0xffcfe4fe), width: 2),
                      )),
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(
                height: 20,
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
                        borderSide:
                        BorderSide(color: Color(0xffcfe4fe), width: 2),
                      )),
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () async{
                    if (email.text.isNotEmpty && pass.text.isNotEmpty) {
                      try {
                        var login = await FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                            email: email.text,
                            password: pass.text)
                            .then((value) => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TaskScreen(),
                            )));
                        SharedPreferences pref =
                        await SharedPreferences.getInstance();
                        await pref.setBool('logstatus', true);
                        email.clear();
                        pass.clear();
                      } catch (e) {
                        print(e.toString());
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(e.toString())));
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Please Fill the above fields')));
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
                    fixedSize: const Size(200, 60),
                    backgroundColor: Colors.blue,
                    side: BorderSide(
                        width: 2,
                        color: Color(0xff1560bc),
                        style: BorderStyle.values[1]),
                    padding: const EdgeInsets.all(10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: Colors.green, width: 2),
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
