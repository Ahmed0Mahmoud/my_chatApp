import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final Function(String)? onChanged;
  final bool obscureText;
  const CustomTextFormField({
    super.key, required this.hintText, required this.onChanged, required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value){
        if(value!.isEmpty){
          return 'field is required';
        }

      },
      decoration: InputDecoration(
        hintText:hintText ,
        hintStyle:const TextStyle(
          color: Colors.white,
        ),
        border: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            )
        ),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            )
        ),

      ),
      onChanged:onChanged ,
      obscureText:obscureText ,
    );
  }
}
