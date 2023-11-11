import 'package:flutter/material.dart';

abstract class AuthEvent {}

// what are the events you have ?

class LoginEvent extends AuthEvent {
 final BuildContext context;

  LoginEvent({
   // required this.email,
  //  required this.password,
    required this.context,
  });
}

class RegisterEvent extends AuthEvent {
  //   final String email;
  // final String password;
 // final BuildContext context;

  RegisterEvent(
    //{
   // required this.email,
  //  required this.password,
   // required this.context,
 // }
 );
}
