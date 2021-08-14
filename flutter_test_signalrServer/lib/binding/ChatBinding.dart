import 'package:flutter_test_signalr/api_services/HttpServices.dart';
import 'package:flutter_test_signalr/controller/chat_controller.dart';
import 'package:flutter_test_signalr/repository/ChatRepository.dart';
import 'package:get/get.dart';

class ChatBinding extends Bindings{

  @override
  void dependencies() {
    Get.lazyPut(() => HttpServiceImp());
    Get.lazyPut<HttpService>(()=>HttpServiceImp());

    Get.lazyPut(() => ChatController());
    Get.put(ChatRepositoryImp());

  }
}