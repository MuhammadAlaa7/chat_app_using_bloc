import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../models/message.dart';
part 'chat_state.dart';

class ChatCubit extends Cubit<ChatStates> {
  ChatCubit() : super(ChatInitialState());

  @override
  void onChange(Change<ChatStates> change) {
    // TODO: implement onChange
    super.onChange(change);
    print('change is :: $change');
  }

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
      messagesList
          .clear(); // to avoid duplication  before getting the list data because the cubit is still alive
      for (var doc in event.docs) {
        messagesList.add(Message.fromJson(doc));
      }

      emit(ChatSuccessState());
      log('received');
    });
  }
}
