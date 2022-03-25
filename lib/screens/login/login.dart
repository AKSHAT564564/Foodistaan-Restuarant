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

  Widget emailFormFeild(
      focusNode, controller, obscureText, feildName, errorText) {
    return TextFormField(
      focusNode: focusNode,
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

  Widget passwordFormFeild(
      focusNode, controller, obscureText, feildName, errorText) {
    return TextFormField(
      focusNode: focusNode,
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: emailFocusNode.hasFocus ? 2.h : 3.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hello VENDORS",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  // color: Color(0xFFF7C12B),
                  color: kYellow,
                  fontSize: 26.sp,
                ),
              ),
              Text(
                "Let’s get Started",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w600,
                  color: kYellow,
                  // Color(0xFF0F1B2B),
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 3.h,
        ),
        Container(
            // margin: EdgeInsets.only(left: 2.5.w, right: 2.5.w),
            child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 100.w,
                padding: EdgeInsets.symmetric(
                  horizontal: 11,
                ),
                child: emailFormFeild(emailFocusNode, emailController, false,
                    'email', emailError),
              ),
              SizedBox(
                height: 2.5.h,
              ),
              Container(
                width: 100.w,
                padding: EdgeInsets.symmetric(
                  horizontal: 11,
                ),
                // margin: EdgeInsets.only(left: 2.5.w, right: 2.5.w),
                child: passwordFormFeild(passwordFocusNode, passwordController,
                    true, 'password', passwordError),
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
              if (emailController.text == '' || passwordController.text == '') {
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
    );
  }

  late FocusNode emailFocusNode;
  late FocusNode passwordFocusNode;

  @override
  void initState() {
    super.initState();

    emailFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    emailFocusNode.dispose();
    passwordFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Stack(
          children: [
            Container(
              height: 100.h,
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: 1000),
              curve: Curves.fastOutSlowIn,
              top: emailFocusNode.hasFocus || passwordFocusNode.hasFocus
                  ? -34.h
                  : -6.5.h,
              child: Container(
                  width: MediaQuery.of(context).size.width * 1,
                  // height: MediaQuery.of(context).size.height * 0.65,
                  height: 90.h,
                  child: Image.asset('assets/images/loginBG.png',
                      // height: 20,
                      fit: BoxFit.fill)),
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: 1000),
              curve: Curves.fastOutSlowIn,
              top: emailFocusNode.hasFocus || passwordFocusNode.hasFocus
                  ? 14.h
                  : 42.h,
              child: getMobileFormWidget(context),
            ),
          ],
        ),
      ),
    );
  }
}
