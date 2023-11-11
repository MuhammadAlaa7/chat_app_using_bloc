import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholar_chat/cubits/auth_cubit/auth_state.dart';

import '../../components/show_snack_bar.dart';
import '../../views/chat_view.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthInitialState());


  GlobalKey<FormState> formKey = GlobalKey();
  // this is the email coming from input field for email and so the password
  String? email;

  String? password;

  bool isLoading = false;

  loginUser(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      isLoading = true;
      emit(LoginLoadingState());

      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email!,
          password: password!,
        );

        // This block should execute if login is successful.

        isLoading = false;
        emit(LoginSuccessState());

        Navigator.pushNamed(
          context,
          ChatView.id,
          arguments: email,
        );
      } on FirebaseAuthException catch (e) {
        // This block should execute if there is a FirebaseAuthException.
        log('FirebaseAuthException: ${e.code}');
        if (e.code == 'user-not-found') {
          showSnackBar('No user found for that email.', context);
        } else if (e.code == 'invalid-login-credentials') {
          showSnackBar('Wrong password provided for that user.', context);
        } else {
          showSnackBar('test :: ${e.message!}', context);
        }

        isLoading = false;
        emit(LoginFailureState(e.code));
      } catch (e) {
        // This block should execute if there is any other error.
        print('Error: $e');
        showSnackBar(e.toString(), context);
        isLoading = false;
        emit(LoginFailureState(e.toString()));
      }
    } else {
      // This block should execute if form validation fails.
      showSnackBar('Validation Error', context);
    }
  }




registration(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      isLoading = true;
      emit(RegisterLoadingState());

      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email!,
          password: password!,
        );

        // This block should execute if login is successful.

        isLoading = false;
        emit(RegisterSuccessState());

        Navigator.pushNamed(
          context,
          ChatView.id,
          arguments: email,
        );
        log('Done');
      } on FirebaseAuthException catch (ex) {
        if (ex.code == 'weak-password') {
          showSnackBar('The Password Provided is Too Weak', context);
        } else if (ex.code == 'email-already-in-use') {
          showSnackBar('The account already exists for that email.', context);
        } else if (ex.code == 'invalid-email') {
          showSnackBar('invalid email form ', context);
        }

        isLoading = false;
        emit(RegisterFailureState(ex.code));
      } catch (e) {
        showSnackBar(e.toString(), context);

        isLoading = false;
        emit(RegisterFailureState(e.toString()));
      }
    } else {
      showSnackBar('No validation ', context);
    }
  }


}
