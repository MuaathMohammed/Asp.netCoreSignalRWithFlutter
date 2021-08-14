import 'dart:convert';

import 'package:flutter_test_signalr/api_services/HttpServices.dart';
import 'package:flutter_test_signalr/constant/AppConstant.dart';
import 'package:flutter_test_signalr/models/message_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

abstract class ChatRepository{
  Future<List<Message>?> getMessage() ;
  Future<int?> addMessage(Message message);

}

class ChatRepositoryImp implements ChatRepository{

 late HttpService _httpService;
  ChatRepositoryImp()
  {
    _httpService = Get.put(HttpServiceImp());

  }

  @override
  Future<List<Message>?> getMessage() async{
    try {
      http.Response response = await _httpService.getMethod("https://signalrwithuseridentity.conveyor.cloud/api/Hub/GetAll");
      final paresJson = messageFromMap(response.body);
      print(response.body);
      return paresJson;
    } on Exception catch (e) {
      print(e);
      return null;
    }
  }
 @override
 Future<int?> addMessage(Message message) async{

   Map data = {
     'userName': 'Muath@Muath.com',
     'text': message.text,
     'userId': 'f8b60d9c-61f2-49cf-8dd2-fd14142d0a75',
   };
   try {
     final http.Response res=await http.post(Uri.parse(baseUrl+'/Create'),headers: <String, String>{
       'Content-Type': 'application/json; charset=UTF-8',
     }, body: jsonEncode(data));
     print(res.body);
     print( message.id);
     return message.id;
   } on Exception catch (e) {
     throw e;
   }
 }
}