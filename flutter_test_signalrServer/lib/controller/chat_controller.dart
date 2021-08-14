import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test_signalr/models/message_model.dart';
import 'package:flutter_test_signalr/repository/ChatRepository.dart';
import 'package:get/get.dart';
import 'package:signalr_core/signalr_core.dart';

class ChatController extends GetxController {
  late TextEditingController name;

  ChatController() {
    _chatRepository = Get.put(ChatRepositoryImp());
    name = new TextEditingController();
  }
  late ChatRepository _chatRepository;
  // bool _isConnected = false;

  final hubConnection = HubConnectionBuilder()
      .withUrl(
        "https://signalrwithuseridentity.conveyor.cloud/Home/Index",
        HttpConnectionOptions(logging: (level, message) => print(message)),
      )
      .build();
  var messages = <Message?>[].obs;
  receiveMessage(List<dynamic>? message) {
    List<dynamic> json = jsonDecode(jsonEncode(message![0]));
    json.forEach((item) {
      messages.add(Message.fromMap(item));
    });
    update();
  }

  void start() async {
    await hubConnection.start();
  }

  void sendMessage() async {
    await hubConnection
        .invoke("SendMessage", args: addMessage())
        .catchError((err) {
      print(err);
    });
    update();
  }

  late Message messageModel;
  @override
  void onInit() {
    loadNews();
    //  addMessage();
    receiveMessage;
    hubConnection.onclose((_) {
      print("SignalR Test");
    });

    hubConnection.on("receiveMessage", receiveMessage);
    start();
    // hubConnection.invoke('getConnectionId')
    //     .then((connectionId) {
    //     // Send the connectionId to controller
    // });
    update();
  }
  // bool getIsConnected() {
  //   return _isConnected;
  // }

  addMessage() {
    var message = new Message(text: name.text);
    _chatRepository.addMessage(message);
    update();
  }

  RxBool isLoading = false.obs;
  loadNews() async {
    showLoading();
    var result = await _chatRepository.getMessage();
    print(result);
    hideLoading();
    if (result != null) {
      messages.assignAll(result as List<Message>);
    } else {
      print("NO Data Found");
    }
    update();
  }

  showLoading() {
    isLoading.toggle();
  }

  hideLoading() {
    isLoading.toggle();
  }
}
