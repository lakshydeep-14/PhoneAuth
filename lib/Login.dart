import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pak/Controller.dart';
import 'package:pak/registerscreen.dart';

class Login extends StatefulWidget {
  static const id = 'register-screen';
  const Login({key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  FirebaseFirestore _firebaseFirestore =FirebaseFirestore.instance;

  TextEditingController _phoneNumberController = TextEditingController();
  bool _validPhoneNumber = false;
  

  @override
  Widget build(BuildContext context) {
    Get.put(AuthCon());
    return Scaffold(
      
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              
              Text(
                'Login',
                style:
                TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              SizedBox(
                height: 30,
              ),
             
              TextField(
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.phone, color: Colors.greenAccent,),
                  prefixStyle: TextStyle(color: Colors.black),
                  labelText: 'Enter Your Mobile Number',
                  labelStyle: TextStyle(color: Colors.black,),
                  enabledBorder: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 2,color: Theme.of(context).primaryColor
                      )
                  ),
                ),
                autofocus: true,
                keyboardType: TextInputType.phone,
                maxLength: 10,
                controller: _phoneNumberController,
                onChanged: (value) {
                  if (value.length == 10) {
                    setState(() {
                      _validPhoneNumber = true;

                    });
                  } else {
                    setState(() {
                      _validPhoneNumber = false;
                    });
                  }
                },
              ),
              SizedBox( height: 10,),
              Row(
                children: [
                  Expanded(
                    child: AbsorbPointer(
                      absorbing: _validPhoneNumber ? false : true,
                      child: FlatButton(
                        onPressed: ()async {
                          List<String> abc=[];
                          await  _firebaseFirestore.collection('PhoneList').get().then((value){
                           value.docChanges.forEach((e) {
                             abc.add(e.doc['phn'].toString());
                           });
                           
                         });
                         int z=abc.indexOf(_phoneNumberController.text);
                         z>=0? Get.find<AuthCon>().signUP(context,1,phone: _phoneNumberController.text,)
                         :Get.to(()=>RegisterScreen());
                        },
                        color: _validPhoneNumber
                            ? Colors.greenAccent
                            : Colors.grey,
                        child:
                        Text(
                          _validPhoneNumber
                              ? 'CONTINUE'
                              : 'ENTER PHONE NUMBER',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

