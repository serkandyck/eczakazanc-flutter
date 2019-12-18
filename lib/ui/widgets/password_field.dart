import 'package:flutter/material.dart';

class PasswordField extends StatelessWidget {
  final TextEditingController passwordController;
  final bool obscureText;
  final String passwordError;
  final VoidCallback togglePassword;
  PasswordField({
	  this.passwordController,
	  this.obscureText,
	  this.passwordError,
	  this.togglePassword
  });
  
	@override
  Widget build(BuildContext context) {
		return new Container(
			padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0),
			child: new TextFormField(
        style: new TextStyle(color: Colors.white),
        maxLines: 1,
        controller: passwordController,
        textInputAction: TextInputAction.done,
        obscureText: obscureText,
        decoration: new InputDecoration(
          errorText: passwordError,
          hintText: "Lütfen şifrenizi giriniz",
          hintStyle: new TextStyle(color: const Color(0xFFFFFFFF)),
          labelText: "Şifreniz",
          labelStyle: new TextStyle(color: const Color(0xFFFFFFFF)),
          suffixIcon: new GestureDetector(
            onTap: togglePassword,
            child: new Icon(obscureText
                        ? Icons.visibility
                        : Icons.visibility_off, color: const Color(0xFFFFFFFF)),
          ),
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
