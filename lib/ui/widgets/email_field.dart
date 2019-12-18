import 'package:flutter/material.dart';

class EmailField extends StatelessWidget {
	final TextEditingController emailController;
	final String emailError;
  EmailField({this.emailController, this.emailError});
  
	@override
  Widget build(BuildContext context) {
    return new Container(
	    padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 30.0),
	    child:  new TextFormField(
        style: new TextStyle(color: Colors.white),
        textInputAction: TextInputAction.done,
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        controller: emailController,
        decoration: new InputDecoration(
          errorText: emailError,
          hintText: "Lütfen e-posta adresinizi giriniz",
          hintStyle: new TextStyle(color: Colors.white),
          labelText: "E-posta adresiniz",
          labelStyle: new TextStyle(color: Colors.white),
          focusedBorder: UnderlineInputBorder(      
            borderSide: BorderSide(color: Colors.white),   
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          )
        )
      )
    );
  }
	
}
