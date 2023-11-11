import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholar_chat/constants.dart';
import 'package:scholar_chat/cubits/auth_cubit/auth_cubit.dart';
import 'package:scholar_chat/cubits/auth_cubit/auth_state.dart';
import '../widgets/custom_buttons.dart';
import '../widgets/input_field.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({Key? key}) : super(key: key);
  static const String id = 'register id ';

  @override
  Widget build(BuildContext context) {
    AuthCubit cubit = BlocProvider.of<AuthCubit>(context);
    return Form(
      key: cubit.formKey,
      child: BlocBuilder<AuthCubit, AuthStates>(
        builder: (context, state) {
          return ModalProgressHUD(
            inAsyncCall: cubit.isLoading,
            child: Scaffold(
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
                    'Resgiter',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                    ),
                  ),
                  InputField(
                    hint: 'Enter Your Email',
                    label: 'Email',
                    onChanged: (data) {
                      cubit.email = data;
                    },
                  ),
                  InputField(
                    isPassword: true,
                    hint: 'Enter Your Password',
                    label: 'Password',
                    onChanged: (data) {
                      cubit.password = data;
                    },
                  ),
                  LoginButton(
                    text: 'Sign Up',
                    onPressed: () async {
                      cubit.registration(context);
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'You already have an account ? ',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Login'),
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
