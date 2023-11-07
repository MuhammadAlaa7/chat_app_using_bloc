import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholar_chat/constants.dart';
import 'package:scholar_chat/widgets/chat_buble.dart';
import 'package:scholar_chat/widgets/message_field.dart';
import '../cubits/chat_cubit/chat_cubit.dart';

class ChatView extends StatelessWidget {
  ChatView({Key? key}) : super(key: key);

  final ScrollController scrollController = ScrollController();

  static String id = 'chat id';

  @override
  Widget build(BuildContext context) {
    ChatCubit cubit = BlocProvider.of<ChatCubit>(context);
    cubit.emailFromLogin = ModalRoute.of(context)!.settings.arguments as String;
    cubit.receiveMessage();
    return Scaffold(
      appBar: AppBar(
        // to remove the leading from the app bar
        automaticallyImplyLeading: false,

        backgroundColor: kPrimaryColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              kLogoPath,
              height: 50,
            ),
            const Text('Chat'),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            BlocBuilder<ChatCubit, ChatStates>(
              builder: (context, state) {
                return Expanded(
                  child: ListView.builder(
                    reverse: true,
                    controller: scrollController,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return cubit.messagesList[index].id ==
                              cubit.emailFromLogin
                          ? SentChatBuble(
                              message: cubit.messagesList[index].messageText,
                            )
                          : ReceivedChatBuble(
                              message: cubit.messagesList[index].messageText,
                            );
                    },
                    itemCount: cubit.messagesList.length,
                  ),
                );
              },
            ),
            MessageField(
              scrollController: scrollController,
            ),
          ],
        ),
      ),
    );
  }
}
