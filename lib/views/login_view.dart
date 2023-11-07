import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholar_chat/views/chat_view.dart';
import 'package:scholar_chat/views/resgister_view.dart';
import 'package:scholar_chat/widgets/custom_buttons.dart';
import 'package:scholar_chat/widgets/input_field.dart';
import '../constants.dart';
import '../cubits/login_cubit/login_cubit.dart';
import '../cubits/login_cubit/states.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);
  static String id = 'login screen id';

  @override
  Widget build(BuildContext context) {
    LoginCubit cubit = BlocProvider.of<LoginCubit>(context);
    return Form(
      key: cubit.formKey,
      child: BlocBuilder<LoginCubit, LoginStates>(
        builder: (context, state) {
          return ModalProgressHUD(
            inAsyncCall: cubit.isLoading,
            child: Scaffold(
              // floatingActionButton: FloatingActionButton(
              //   onPressed: () {
              //     Navigator.pushNamed(context, ChatView.id, arguments: 'test');
              //   },
              // ),
              backgroundColor: kPrimaryColor,
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(children: [
                  Container(
                    margin: const EdgeInsets.only(top: 120),
                    child: Image.asset(
                      kLogoPath,
                      height: 100,
                    ),
                  ),
                  const Text(
                    'Scholar Chat',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Pacifico',
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  const Text(
                    'Sign In',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                    ),
                  ),
                  InputField(
                    hint: 'Enter Your Email',
                    label: 'Email',
                    onChanged: (value) {
                      cubit.email = value;
                    },
                  ),
                  InputField(
                    hint: 'Enter Your Password',
                    label: 'Password',
                    onChanged: (value) {
                      cubit.password = value;
                    },
                  ),
                  LoginButton(
                    text: 'Sign In',
                    onPressed: () async {
                      cubit.loginUser(context);
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'don\'t have an account ? ',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, RegisterView.id);
                        },
                        child: const Text('Sign Up'),
                      ),
                    ],
                  ),
                ]),
              ),
            ),
          );
        },
      ),
    );
  }
}
