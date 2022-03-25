import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:foodistaan_restuarant/constants.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:sizer/sizer.dart';

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
      textAlignVertical: TextAlignVertical.center,
      cursorColor: kYellow,
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
        focusColor: kYellow,
        hintText: 'Enter $feildName',
        errorText: errorText ? 'Check $feildName' : null,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.sp),
          borderSide: BorderSide(color: kYellow, width: 3.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.sp),
          borderSide: BorderSide(color: kYellow, width: 3.0),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.sp),
          borderSide: BorderSide(color: kRed, width: 3.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.sp),
          borderSide: BorderSide(color: kRed, width: 3.0),
        ),
      ),
    );
  }

  getMobileFormWidget(context) {
    return Container(
      margin: EdgeInsets.only(left: 2.5.w, right: 2.5.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              margin: EdgeInsets.only(left: 2.5.w, right: 2.5.w),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        // height: 8.h,
                        child: textFormFeild(
                            emailController, false, 'email', emailError)),
                    SizedBox(
                      height: 2.5.h,
                    ),
                    Container(
                      // height: 8.h,
                      child: textFormFeild(
                          passwordController, true, 'password', passwordError),
                    )
                  ],
                ),
              )),
          Container(
            width: 75.w,
            height: 8.h,
            margin: EdgeInsets.only(
              top: 4.h,
            ),
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
                        Navigator.pushNamedAndRemoveUntil(
                            context, 'Main', (route) => false);
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
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: kYellow,
                // fixedSize: Size(100, 48),
                shape: new RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.sp),
                ),
              ),
            ),
          ),
        ],
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
        inAsyncCall: showSpinner,
        child: Stack(
          children: [
            Container(
              width: 100.w,
              height: 100.h,
              child: Image.asset('assets/images/Login.png',
                  height: 20, fit: BoxFit.fill),
            ),
            AnimatedContainer(
              margin: EdgeInsets.only(bottom: 8.h),
              curve: Curves.easeInOut,
              duration: Duration(milliseconds: 1000),
              child: Column(children: [
                getMobileFormWidget(context),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
