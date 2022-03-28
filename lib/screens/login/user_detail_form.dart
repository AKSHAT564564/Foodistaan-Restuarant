import 'package:flutter/material.dart';
import 'package:foodistaan_restuarant/utils/constants.dart';

class UserDetail extends StatefulWidget {
  String phone_number;

  UserDetail({required this.phone_number});
  @override
  _UserDetailState createState() => _UserDetailState();
}

// addUser(_userData) {
//   Map<String, dynamic> m = {};
//   try {
//     FirebaseFirestore.instance
//         .collection('users')
//         .doc(_userData['phoneNumber'])
//         .set({
//       'name': _userData['name'],
//       'email': _userData['email'],
//       'phoneNumber': _userData['phoneNumber'],
//       'dateAndTime': _userData['dateAndTime'],
//       'profilePic': _userData['profilePic'],
//       'cart-total-map' : {} as Map,
//     });
//   } on Exception catch (e) {
//     print(e.toString());
//     return false;
//   }

//   return true;
// }

class _UserDetailState extends State<UserDetail> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();

  Map<String, dynamic> _userData = {
    'name': '',
    'email': '',
    'phoneNumber': '',
    'dateAndTime': '',
    'profilePic': '',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: MediaQuery.of(context).size.height * 1,
        width: MediaQuery.of(context).size.width * 1,
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
              height: MediaQuery.of(context).size.height * 0.1,
              child: TextFormField(
                textAlign: TextAlign.center,
                controller: nameController,
                //keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  focusColor: Colors.yellow,
                  hintText: 'Name',
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xFFF7C12B), width: 3.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xFFF7C12B), width: 3.0),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.05,
              ),
              width: MediaQuery.of(context).size.height * 0.5,
              height: MediaQuery.of(context).size.height * 0.1,
              child: TextFormField(
                textAlign: TextAlign.center,
                controller: emailController,
                //keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  focusColor: Colors.yellow,
                  hintText: 'Email-id',
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xFFF7C12B), width: 3.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xFFF7C12B), width: 3.0),
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
                //   _userData['name'] = nameController.text;
                //   _userData['email'] = emailController.text;
                //   _userData['phoneNumber'] = widget.phone_number;
                //   _userData['dateAndTime'] = DateTime.now().toString();
                //   await addUser(_userData);
                //   Navigator.push(context,
                //       MaterialPageRoute(builder: (context) => MainScreen()));
                // },
                child: Text(
                  'Submit',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: kYellow,
                  fixedSize: Size(100, 48),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
