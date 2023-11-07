import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholar_chat/cubits/chat_cubit/chat_cubit.dart';
import 'package:scholar_chat/cubits/login_cubit/login_cubit.dart';
import 'package:scholar_chat/cubits/register_cubit/register_cubit.dart';
import 'package:scholar_chat/views/chat_view.dart';
import 'package:scholar_chat/views/login_view.dart';
import 'package:scholar_chat/views/resgister_view.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ChatApp());
}

// If you are using the named routes make the id of the home screen / route >>>> '/'
// to avoid the exception >> a global key used multiple times

class ChatApp extends StatelessWidget {
  const ChatApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginCubit(),
        ),
        BlocProvider(
          create: (context) => RegisterCubit(),
        ),
        BlocProvider(
          create: (context) => ChatCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => const LoginView(),
          RegisterView.id: (context) => const RegisterView(),
          ChatView.id: (context) => ChatView(),
        },
        initialRoute: '/',
      ),
    );
  }
}
