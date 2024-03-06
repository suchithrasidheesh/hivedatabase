import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../database/database.dart';
import '../modelclass/UserModel.dart';

class RegistrationHive extends StatelessWidget{
  TextEditingController username=TextEditingController();
  TextEditingController password=TextEditingController();
  TextEditingController cpass=TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  ListView(
        children: [
          SizedBox(height: 50,),
          TextField(
            controller: username,
            decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                hintText: 'Username'
            ),
          ),
          SizedBox(height: 30,),
          TextField(
            controller: password,
            decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                hintText: 'Password'
            ),
          ),
          SizedBox(height: 30,),
          TextField(
            controller: cpass,
            decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                hintText: 'Confirmpassword'
            ),
          ),
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.all(15),
            child: ElevatedButton(onPressed: (){
              validateSignUp();
            }, child: Text('Register')),
          ),
          SizedBox(height: 10,),
          TextButton(onPressed: (){}, child: Text(' registered User login Here')),
        ],
      ),
    );
  }
  void validateSignUp() async{

    final email=username.text.trim();
    final pass=password.text.trim();
    final cpassw=cpass.text.trim();

    final emailValidationResult=EmailValidator.validate(email);

    if(email !="" && pass !="" && cpassw != "") {
      if(emailValidationResult==true){
        final passValidationResult=checkPassword(pass,cpassw);
        if(passValidationResult==true){
          final user=User(email:email,password:pass);
          await DBFunction.instance.userSignUp(user);
          Get.back();
          Get.snackbar("Success",'Account created');
        }
      }else{
        Get.snackbar("Error","Provide a valid email");
      }
    }else{
      Get.snackbar("Error","Fields can not be empty");
    }
  }

  bool checkPassword(String pass,String cpass){
    if(pass==cpass){
      if(pass.length<6){
        Get.snackbar("Error","Password length should be >6");
        return false;
      }else{
        return true;
      }
    }else{
      Get.snackbar("Error","Password mismatch");
      return false;
    }
  }
}

