import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hivedatabase/Screen/Home.dart';
import 'package:hivedatabase/database/database.dart';
import 'package:hivedatabase/modelclass/UserModel.dart';

import 'Registration.dart';

void main()async{

  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  Hive.openBox<User>('user');
  runApp(GetMaterialApp(home: LoginHive(),));
}
class LoginHive extends StatelessWidget {
  TextEditingController uname=TextEditingController();
  TextEditingController pass=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(height: 50,),
          TextField(
            controller: uname,
            decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            hintText: 'Username'
            ),
          ),
          SizedBox(height: 30,),
          TextField(
            controller: pass,
            decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                hintText: 'Password'
            ),
          ),
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.only(left:50,right: 50),
            child: ElevatedButton(onPressed: ()async{
              final userlist=await DBFunction.instance.getUser();
              findUser(userlist);
            }, child: Text('Login')),
          ),
          SizedBox(height: 10,),
          TextButton(onPressed: (){
            Get.to(RegistrationHive());
          }, child: Text('Not registered Register Here')),
        ],
      ),
    );
  }

  Future <void>findUser(List<User> userlist)async{
    final email=uname.text.trim();
    final password=pass.text.trim();
    bool userfound=false;
    final validate=await validateLogin(email,password);

    if(validate==true){
      await Future.forEach(userlist, (user){
        if(user.email==email&&user.password==password){
          userfound=true;
        }
        else{
          userfound=false;
        }
      });
      if(userfound==true){
        Get.offAll(()=>HomeHive(email:email));
        Get.snackbar("Success", "Login Success",backgroundColor: Colors.green);
      }else{
        Get.snackbar('Error', 'Incorrect email/password',backgroundColor:Colors.red);
      }

    }
  }

  Future<bool> validateLogin(String email, String password)async {
    if(email!=''&&password!=''){
      return true;
    }
    else{
      Get.snackbar('Error','Fieldsncan not be empty',backgroundColor: Colors.red);
      return false;
    }
  }
}

