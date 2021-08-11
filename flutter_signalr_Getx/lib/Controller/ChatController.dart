import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signalr_client/signalr_client.dart';

class ChatController extends GetxController{
  final username = new TextEditingController();
  final text = new TextEditingController();
  final hubConnection =
  HubConnectionBuilder().withUrl("https://localhost:44395/chat").build();
  var messages = <String>[].obs;
  void receiveMessage(List<Object> result) {
      messages.add("${result[0]} says: ${result[1]}");
      update();
  }

  void start() async {
    await hubConnection.start();
  }

  void sendMessage() async {
    await hubConnection.invoke("SendMessage",
        args: <Object>[username.text, text.text]).catchError((err) {
      print(err);
    });
    update();

  }
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    hubConnection.onclose((_) {
      print("SignalR Test");
    });
    hubConnection.on("ReceiveMessage", receiveMessage);
    start();
    update();

  }

}