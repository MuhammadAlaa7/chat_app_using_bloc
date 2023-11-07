import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholar_chat/cubits/chat_cubit/chat_cubit.dart';

import '../constants.dart';

class MessageField extends StatelessWidget {
  MessageField({
    Key? key,
    required this.scrollController,
  }) : super(key: key);

  final ScrollController scrollController;

// this is for controlling the focus of the text field ,
//so that if i need to cancel the focus from the textfield to get the keyboard down after finishing the texting
  final focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    ChatCubit cubit = BlocProvider.of<ChatCubit>(context);
    return TextField(
      controller: cubit.controller,
      focusNode: focusNode,
      decoration: InputDecoration(
        hintText: 'Send a message',
        hintStyle: const TextStyle(
          color: Colors.grey,
        ),
        suffixIcon: IconButton(
          icon: const Icon(
            Icons.send,
            color: kPrimaryColor,
          ),
          onPressed: () async {
            if (cubit.controller.text != '') {
              await cubit.sendMessage();
              // clear the text in the textfield
              cubit.controller.clear();
              // cancel the focus to get the keyboard down
              focusNode.unfocus();

              scrollController.animateTo(
                0,
                duration: const Duration(
                  milliseconds: 500,
                ),
                curve: Curves.linear,
              );
            }
          },
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: kPrimaryColor,
          ),
        ),
      ),
    );
  }
}
