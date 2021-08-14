import 'package:flutter/material.dart';
import 'package:flutter_test_signalr/api_services/ApiServices.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController{
  var loginProcess = false.obs;
  var error = "";
  var emailTextController = TextEditingController(text: "");
  var passwordTextController = TextEditingController(text: "");
  Future<String> login({String? email, String? password}) async {
    Get.dialog(Center(child: CircularProgressIndicator()),
        barrierDismissible: true);
    error = "";
    try {
      loginProcess(true);
      List loginResp = await ApiServices.login(email: email, password: password);
      if (loginResp[0] != "") {
        //success
        final prefs = await SharedPreferences.getInstance();
        prefs.setString("token", loginResp[0]);
      } else {
        error = loginResp[1];
      }
    } finally {
      loginProcess(false);
    }
    return error;
  }

}