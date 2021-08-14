import 'dart:io';

import 'package:flutter_test_signalr/constant/AppConstant.dart';
import 'package:flutter_test_signalr/models/ErrorResp.dart';
import 'package:flutter_test_signalr/models/LoginResp.dart';
import 'package:http/io_client.dart';
import 'package:signalr_core/signalr_core.dart';
import 'package:http/http.dart' as http;

class ApiServices{
  Future getData() async{
    var data;
    return data;
  }
  static var client = http.Client();

  static Future<List> login({String? email, String? password}) async {
    const headers = {"content-type": "application/json"};

    var response = await client.post(Uri.parse("https://localhost:44380/Home/Index/negotiate?negotiateVersion=1"),
        headers: {"Content-Type": "application/json"},

        body:{ "userName": email,
          "password": password});

    if (response.statusCode == 200) {
      var json = response.body;
      var loginRes = loginRespFromJson(json);
      if (loginRes != null) {
        return [loginRes.accessToken, ""];
      } else {
        return ["", "Unknown Error"];
      }
    } else {
      var json = response.body;
      var errorResp = errorRespFromJson(json);
      if (errorResp == null) {
        return ["", "Unknown Error"];
      } else {
        return ["", errorResp.error];
      }
    }
  }
  Future<void> main(List<String> arguments) async {
    final connection = HubConnectionBuilder().withUrl(baseUrl,
        HttpConnectionOptions(
          client: IOClient(HttpClient()..badCertificateCallback = (x, y, z) => true),
          logging: (level, message) => print(message),
        )).build();

    await connection.start();

    connection.on('ReceiveMessage', (message) {
      print(message.toString());
    });

    await connection.invoke('SendMessage', args: ['Bob', 'Says hi!']);
  }
}