import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../constants.dart';
import '../helper/show_snack_bar.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_form_field.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _enteredEmail ='';
  String _enteredPassword ='';
  bool isLoading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                    child:  Align(alignment: Alignment.centerLeft,child: Text('LOGIN',style: TextStyle(color: Colors.white,fontSize: 24,),)),
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
                  CustomButton(title: 'LOGIN', onTap: ()async{
                    if(_formKey.currentState!.validate()){
                      isLoading = true;
                      setState(() {
                      });
                      try {
                        await LoginUser();
                        ShowSnackBar(context, 'Success');

                        Navigator.pushReplacementNamed(context, 'chat');
                      }
                      on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          ShowSnackBar(context,'User Not Found');
                        } else if (e.code == 'wrong-password') {
                          ShowSnackBar(context,'Wrong Password');
                        } else {
                          ShowSnackBar(context,'An unexpected error occurred');
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
                      const Text("don't have an account?",style: TextStyle(color: Colors.white,fontSize: 17),),
                      TextButton(onPressed: () {
                        Navigator.pushNamed(context, 'register');
                      }, child: const Text('Register',style: TextStyle(color: Colors.white,fontSize: 18)),),
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


  Future<void> LoginUser() async {
    UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: _enteredEmail,
      password: _enteredPassword,
    );

  }
}


