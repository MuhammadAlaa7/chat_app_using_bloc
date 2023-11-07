import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../cubits/login_cubit/states.dart';
import '../../components/show_snack_bar.dart';
import '../../views/chat_view.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

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
}
