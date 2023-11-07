import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../models/message.dart';
part 'chat_state.dart';

class ChatCubit extends Cubit<ChatStates> {
  ChatCubit() : super(ChatInitialState());

  final CollectionReference messagesCollectionReference =
      FirebaseFirestore.instance.collection('messages');
  final controller = TextEditingController();

  String? emailFromLogin;

  Future<void> sendMessage() async {
    messagesCollectionReference.add(
      {
        'message': controller.text,
        'time': DateTime.now(),
        'id': emailFromLogin,
      },
    );
  }

  List<Message> messagesList = [];

  receiveMessage() {
    messagesCollectionReference
        .orderBy(
          'time',
          descending: true, // the newer is under and older is up
        )
        .snapshots()
        .listen((event) {
      messagesList.clear(); // to avoid duplication
      for (var doc in event.docs) {
        Map<String, dynamic> docJson = doc as Map<String, dynamic>;
        messagesList.add(Message.fromJson(docJson));
      }

      emit(ChatSuccessState());
      log('received');
    });
  }
}
