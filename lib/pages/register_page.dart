import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../constants.dart';
import '../helper/show_snack_bar.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_form_field.dart';
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String _enteredEmail ='';
  String _enteredPassword ='';
  String _enteredUserName ='';
  bool isLoading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late UserCredential users ;

  @override
  Widget build(BuildContext context) {
    return  ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: const Color(0xff2B475E),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  const SizedBox(height: 75,),
                  Image.asset(kLogo),
                  const Text('ChatApp',style: TextStyle(color: Colors.white,fontSize: 30,fontFamily: 'Pacifico'),),
                  const SizedBox(height: 130,),
                  const Padding(
                    padding:  EdgeInsets.only(bottom: 15),
                    child:  Align(alignment: Alignment.centerLeft,child: Text('REGISTER',style: TextStyle(color: Colors.white,fontSize: 24,),)),
                  ),
                   Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: CustomTextFormField(
                      hintText: 'User name',
                      onChanged: (value) {
                         _enteredUserName = value;
                      }, obscureText: false,
                    ),
                  ),
                   Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: CustomTextFormField(
                      hintText: 'Email',

                      onChanged: (value) {
                         _enteredEmail = value;
                      }, obscureText: false,
                    ),
                  ),
                   Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: CustomTextFormField(
                      hintText: 'Password',
                      onChanged: (value) {
                        _enteredPassword = value;
                      }, obscureText: true,
                    ),
                  ),
                   CustomButton(title: 'REGISTER', onTap: ()async{
                    if(_formKey.currentState!.validate()){
                      isLoading = true;
                      setState(() {
                      });
                      try {
                        await RegisterUser();
                        ShowSnackBar(context, 'Success');
                        Navigator.pushReplacementNamed(context, 'chat');
                      }
                      on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          ShowSnackBar(context, 'Weak Password');
                        } else if (e.code == 'email-already-in-use') {
                          ShowSnackBar(context, 'Email Already Exist');
                        } else {
                          ShowSnackBar(context, 'An unexpected error occurred');
                        }
                      }
                      catch(e){     //catch the exceptions
                        ShowSnackBar(context,'There was an error');
                      }
                      isLoading = false;
                      setState(() {

                      });
                    }
                    else{}

                   },
                   ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("already have an account?",style: TextStyle(color: Colors.white,fontSize: 17),),
                      TextButton(onPressed: () {
                        Navigator.pop(context);
                      }, child: const Text('Login',style: TextStyle(color: Colors.white,fontSize: 18)),),
                    ],
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }



  Future<void> RegisterUser() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _enteredEmail,
        password: _enteredPassword,
      );
      await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
        'userName': _enteredUserName,
        'email': _enteredEmail,
      });
    } catch (e) {
      throw Exception('Registration failed: ${e.toString()}');
    }
  }

}


