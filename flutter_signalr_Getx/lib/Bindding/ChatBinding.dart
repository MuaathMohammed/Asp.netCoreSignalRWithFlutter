import 'package:flutter_signalr/Controller/ChatController.dart';
import 'package:get/get.dart';

class ChatBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => ChatController());
  }
}