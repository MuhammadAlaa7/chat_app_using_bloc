import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scholar_chat/blocs/auth_bloc/auth_state.dart';

import '../../components/show_snack_bar.dart';
import '../../views/chat_view.dart';
import 'auth_event.dart';

class AuthBloc extends Bloc<AuthEvent, AuthStates> {
  AuthBloc() : super(AuthInitialState()) {
    // this is for handling the events of the bloc
    // it tells you that it will work  >> on <<< the event sof bloc X and gives you state

    // receives an event from you and gives you a state as a result
    //and logic accroding to the event

    on<AuthEvent>((event, emit) async {
      if (event is LoginEvent) {
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
              event.context,
              ChatView.id,
              arguments: email,
            );
          } on FirebaseAuthException catch (e) {
            // This block should execute if there is a FirebaseAuthException.
            log('FirebaseAuthException: ${e.code}');
            if (e.code == 'user-not-found') {
              showSnackBar('No user found for that email.', event.context);
            } else if (e.code == 'invalid-login-credentials') {
              showSnackBar(
                  'Wrong password provided for that user.', event.context);
            } else {
              showSnackBar('test :: ${e.message!}', event.context);
            }

            isLoading = false;
            emit(LoginFailureState(e.code));
          } catch (e) {
            // This block should execute if there is any other error.
            print('Error: $e');
            showSnackBar(e.toString(), event.context);
            isLoading = false;
            emit(LoginFailureState(e.toString()));
          }
        } else {
          // This block should execute if form validation fails.
          showSnackBar('Validation Error', event.context);
        }
      }
    });
  }
  // this is the email coming from input field for email and so the password
  String? email;
  String? password;
  //  BuildContext? context;
  bool isLoading = false;
  final GlobalKey<FormState> formKey = GlobalKey();


/// This is for tracking the events and the states happended as a result for them 
  @override
  void onTransition(Transition<AuthEvent, AuthStates> transition) {
    super.onTransition(transition);
    print(transition);
  }
/// this is specified only for tracking the states not the events 
  @override
  void onChange(Change<AuthStates> change) {
    super.onChange(change);
    print(change);
  }
}
