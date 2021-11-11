import 'package:flutter/material.dart';
import 'user_detail_form.dart';

enum MobileVerificationState {
  SHOW_MOBILE_FORM_STATE,
  SHOW_OTP_FORM_STATE,
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final phoneController = TextEditingController();
  final otpController = TextEditingController();
  // FirebaseAuth _auth = FirebaseAuth.instance;
  String? verificationId;
  bool showLoading = false;
  String currentText = "";

  // void signInWithPhoneAuthCredential(
  //     PhoneAuthCredential phoneAuthCredential) async {
  //   setState(() {
  //     showLoading = true;
  //   });
  //   try {
  //     final authCredential =
  //         await _auth.signInWithCredential(phoneAuthCredential);
  //     setState(() {
  //       showLoading = false;
  //     });
  //     if (authCredential.user != null) {
  //       final _userDetail = await FirebaseFirestore.instance
  //           .collection('users')
  //           .doc(phoneController.text)
  //           .get();

  //       _userDetail.exists
  //           ? Navigator.push(
  //               context, MaterialPageRoute(builder: (context) => MainScreen()))
  //           : Navigator.push(
  //               context,
  //               MaterialPageRoute(
  //                   builder: (context) =>
  //                       UserDetail(phone_number: phoneController.text)));
  //     }
  //   } on FirebaseAuthException catch (e) {
  //     setState(() {
  //       showLoading = false;
  //     });
  //     // _scaffoldKey.currentState.ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message!)));
  //   }
  // }

  MobileVerificationState currentState =
      MobileVerificationState.SHOW_MOBILE_FORM_STATE;
  getMobileFormWidget(context) {
    return Container(
      height: MediaQuery.of(context).size.height * 1,
      width: MediaQuery.of(context).size.width * 1,
      child: Column(
        children: [
          Container(
              width: MediaQuery.of(context).size.width * 1,
              height: MediaQuery.of(context).size.height * 0.3,
              child:
                  Image.asset('Images/top.jpeg', height: 20, fit: BoxFit.fill)),
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
            height: MediaQuery.of(context).size.height * 0.1,
            child: TextFormField(
              textAlign: TextAlign.center,
              controller: phoneController,
              //keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                focusColor: Colors.yellow,
                hintText: 'Phone Number (Please enter +91)',
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFF7C12B), width: 3.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFF7C12B), width: 3.0),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.04,
            ),
            width: MediaQuery.of(context).size.height * 0.5,
            height: MediaQuery.of(context).size.height * 0.1,
            child: ElevatedButton(
              onPressed: null,
              // onPressed: () async {
              //   setState(() {
              //     showLoading = true;
              //   });
              //   await _auth.verifyPhoneNumber(
              //     phoneNumber: phoneController.text,
              //     verificationCompleted: (phoneAuthCredential) async {
              //       setState(() {
              //         showLoading = false;
              //       });
              //       //signInWithPhoneAuthCredential
              //     },
              //     verificationFailed: (verificationFailed) async {
              //       setState(() {
              //         showLoading = false;
              //       });
              //       // _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(verificationFailed.message!),));
              //     },
              //     codeSent: (verificationId, resendingToken) async {
              //       setState(() {
              //         showLoading = false;
              //         currentState =
              //             MobileVerificationState.SHOW_OTP_FORM_STATE;
              //         this.verificationId = verificationId;
              //       });
              //     },
              //     codeAutoRetrievalTimeout: (verificationId) async {},
              //   );
              // },
              child: Text(
                'Send OTP',
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
    );
  }

  getOtpFormWidget(context) {
    return Container(
      height: MediaQuery.of(context).size.height * 1,
      width: MediaQuery.of(context).size.width * 1,
      child: Column(
        children: [
          Container(
              width: MediaQuery.of(context).size.width * 1,
              height: MediaQuery.of(context).size.height * 0.3,
              child:
                  Image.asset('Images/top.jpeg', height: 20, fit: BoxFit.fill)),
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
            height: MediaQuery.of(context).size.height * 0.1,
            child: TextFormField(
              textAlign: TextAlign.center,
              controller: otpController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                focusColor: Colors.yellow,
                hintText: 'Enter OTP',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFF7C12B), width: 3.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFF7C12B), width: 3.0),
                ),
              ),
            ),
          ),

          // Container(
          //   child: OTPTextField(
          //     length: 6,
          //     width: MediaQuery.of(context).size.width,
          //     fieldWidth: 40,
          //     style: TextStyle(
          //         fontSize: 17
          //     ),
          //     textFieldAlignment: MainAxisAlignment.spaceAround,
          //     fieldStyle: FieldStyle.underline,
          //     onCompleted: (pin) {
          //       print("Completed: " + pin);
          //     },
          //   ),
          // ),
          Container(
            margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.04,
            ),
            width: MediaQuery.of(context).size.height * 0.5,
            height: MediaQuery.of(context).size.height * 0.1,
            child: ElevatedButton(
              onPressed: null,
              // onPressed: () async {
              //   PhoneAuthCredential phoneAuthCredential =
              //       PhoneAuthProvider.credential(
              //           verificationId: verificationId!,
              //           smsCode: otpController.text);
              //   signInWithPhoneAuthCredential(phoneAuthCredential);
              // },
              child: Text(
                'Verify OTP',
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
    );
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      body: Container(
        child: showLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : currentState == MobileVerificationState.SHOW_MOBILE_FORM_STATE
                ? getMobileFormWidget(context)
                : getOtpFormWidget(context),
      ),
    );
  }
}



// class Login extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     double height, width;
//     height = MediaQuery.of(context).size.height;
//     width = MediaQuery.of(context).size.width;
//     return
//   }
// }
