
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_food_app/Views/login.dart';
import 'package:flutter_food_app/utils/color_constants.dart';
import 'package:flutter_food_app/widgets/toptitle.dart';

class SignUp extends StatefulWidget {
  SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController email = TextEditingController();
  TextEditingController fullname = TextEditingController();
  TextEditingController phoneNum = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isMale = false;
  final GlobalKey<ScaffoldState> scaffold = GlobalKey<ScaffoldState>();
  static String pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
      r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
      r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
      r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
      r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
      r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
      r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
  static RegExp regex = new RegExp(pattern);
  bool isLoading = false;
  late UserCredential credential;
  void submit() async {
    setState(() {
      isLoading = true;
    });
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );
    } on FirebaseAuthException catch (e) {
      String message = 'Please check internet';
      if (e.message != null) {
        message = e.message.toString();
      }
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
    FirebaseFirestore.instance
        .collection("UserData")
        .doc(credential.user!.uid)
        .set({
      "UserName": fullname.text,
      "UserEmail": email.text,
      "UserNumber": phoneNum.text,
      "UserAddress":address.text,
    });
  }

  void validation(context) {
    if (email.text.isEmpty &&
        password.text.isEmpty &&
        fullname.text.isEmpty &&
        phoneNum.text.isEmpty &&
        address.text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('All fields is empty')));
    }
    if (email.text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Email is empty')));
    } else if (!regex.hasMatch(email.text)) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Email is not valid')));
    } else if (fullname.text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('FullName is empty')));
    } else if (phoneNum.text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('PhoneNumber is empty')));
    } else if (phoneNum.text.length < 11) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('PhoneNumber must be 11')));
    } else if (address.text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Address is empty')));
    } else if (password.text.length<8) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Password is too short')));
    }
    else{
      submit();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: scaffold,
      body: SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            child: Column(children: [
              TopTitle(title: "SignUp", subtitle: "Create an account"),
              Container(
                // height: 600,
                child: Column(
                  children: [
                    Center(
                        child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [
                          TextFormField(
                            controller: email,
                            decoration: InputDecoration(
                                fillColor: Color1.filledColor,
                                filled: true,
                                hintText: "Email",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none)),
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            controller: fullname,
                            decoration: InputDecoration(
                                fillColor: Color1.filledColor,
                                filled: true,
                                hintText: "Full Name",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none)),
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            controller: phoneNum,
                            decoration: InputDecoration(
                                fillColor: Color1.filledColor,
                                filled: true,
                                hintText: "Phone Number",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none)),
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            controller: address,
                            decoration: InputDecoration(
                                fillColor: Color1.filledColor,
                                filled: true,
                                hintText: "Address",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none)),
                          ),
                          SizedBox(height: 10),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isMale = !isMale;
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.only(left: 10),
                              height: 60,
                              width: double.infinity,
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                  color: Color1.filledColor,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Text(
                                isMale == false ? 'Female' : "Male",
                                style:
                                    TextStyle(fontSize: 16, color: Colors.grey),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: password,
                            obscureText: true,
                            decoration: InputDecoration(
                                suffixIcon: GestureDetector(
                                  onTap: () {},
                                  child: Icon(Icons.visibility),
                                ),
                                fillColor: Color1.filledColor,
                                filled: true,
                                hintText: "Password",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none)),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                              height: 60,
                              // width: 400,
                              child:Card(
                                color: Color1.textColor,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(12.0),
                                  onTap: () {
                                    validation(context);
                                  },
                                  child: const Center(
                                    child: Text(
                                      'SignUp',
                                      style: TextStyle(
                                          fontSize: 30.0, color: Colors.white),
                                    ),
                                  ),
                                ),
                              )),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Already have an account",
                                style: TextStyle(
                                    fontSize: 18.0, color: Colors.black),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Login()));
                                },
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                      color: Color1.textColor, fontSize: 20),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )),
                  ],
                ),
              ),
            ])),
      ),
    );
  }
}
