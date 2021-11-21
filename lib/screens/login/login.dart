import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  // FirebaseAuth _auth = FirebaseAuth.instance;

  final _formKey = GlobalKey<FormState>();

  final _auth = FirebaseAuth.instance;

  Map<String, dynamic> _userData = {
    'firstName': "",
    'lastName': "",
  };

  bool showSpinner = false, emailError = false, passwordError = false;

  Widget textFormFeild(controller, obscureText, feildName, errorText) {
    return TextFormField(
      textAlign: TextAlign.center,
      obscureText: obscureText,
      controller: controller,
      validator: (value) {
        if (value == null || value.isEmpty)
          return 'please Enter $feildName';
        else
          return null;
      },
      onChanged: (value) {
        _userData['$feildName'] = value;
      },
      //keyboardType: TextInputType.number,
      decoration: InputDecoration(
        focusColor: Colors.yellow,
        hintText: 'Enter $feildName',
        errorText: errorText ? 'Check $feildName' : null,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFF7C12B), width: 3.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFF7C12B), width: 3.0),
        ),
      ),
    );
  }

  getMobileFormWidget(context) {
    return Container(
      height: MediaQuery.of(context).size.height * 1,
      width: MediaQuery.of(context).size.width * 1,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                width: MediaQuery.of(context).size.width * 1,
                height: MediaQuery.of(context).size.height * 0.3,
                child: Image.asset('Images/top.jpeg',
                    height: 20, fit: BoxFit.fill)),
            Container(
              width: MediaQuery.of(context).size.width * 1,
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.02,
              ),
              child: Image.asset('Images/pic4.png'),
            ),

            Container(
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.05,
                ),
                width: MediaQuery.of(context).size.height * 0.5,
                height: MediaQuery.of(context).size.height * 0.18,
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      textFormFeild(
                          emailController, false, 'email', emailError),
                      textFormFeild(
                          passwordController, true, 'password', passwordError)
                    ],
                  ),
                )),

            Container(
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.04,
              ),
              width: MediaQuery.of(context).size.height * 0.5,
              height: MediaQuery.of(context).size.height * 0.1,
              child: ElevatedButton(
                onPressed: () async {
                  if (emailController.text == '' ||
                      passwordController.text == '') {
                    setState(() {
                      emailError = true;
                      passwordError = true;
                    });
                  } else {
                    setState(() {
                      showSpinner = true;
                      emailError = false;
                      passwordError = false;
                    });
                    try {
                      if (_formKey.currentState!.validate()) {
                        final user = await _auth.signInWithEmailAndPassword(
                            email: _userData['email'],
                            password: _userData['password']);
                        if (user != null) {
                          Navigator.pushNamed(context, 'Main');
                        }
                      }
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'user-not-found')
                        setState(() {
                          showSpinner = false;
                          emailError = true;
                        });
                      else if (e.code == 'wrong-password') {
                        setState(() {
                          passwordError = true;
                          showSpinner = false;
                        });
                      } else {
                        setState(() {
                          showSpinner = false;
                          passwordError = true;
                          emailError = true;
                        });
                      }
                    }
                  }
                },
                child: Text(
                  'Log In',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFFF7C12B),
                  fixedSize: Size(100, 48),
                ),
              ),
            ),
            //   ],
            // ),

            Container(
                width: MediaQuery.of(context).size.width * 1,
                height: MediaQuery.of(context).size.height * 0.25,
                child: Image.asset('Images/bottom.jpeg',
                    height: 20, fit: BoxFit.fill)),
          ],
        ),
      ),
    );
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      body: ModalProgressHUD(
          inAsyncCall: showSpinner, child: getMobileFormWidget(context)),
    );
  }
}
