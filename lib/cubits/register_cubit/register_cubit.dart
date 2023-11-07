import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scholar_chat/cubits/register_cubit/register_state.dart';
import '../../components/show_snack_bar.dart';
import '../../views/chat_view.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  GlobalKey<FormState> formKey = GlobalKey();

  String? email;

  String? password;

  bool isLoading = false;

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
