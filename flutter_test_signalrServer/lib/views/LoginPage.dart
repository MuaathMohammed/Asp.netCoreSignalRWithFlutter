import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_test_signalr/controller/LoginController.dart';
import 'package:get/get.dart';

import 'chat_page.dart';

class LoginPage extends StatelessWidget {
  final formKey = new GlobalKey<FormState>();
  final LoginController controller = Get.put(LoginController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body:    Center(
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(16.7))),
          child: ListView(
        children: [
       Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Email'),
                      keyboardType: TextInputType.emailAddress,
                      controller:controller.emailTextController,
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Password'),
                      keyboardType: TextInputType.text,
                      controller:controller.passwordTextController,
                      obscureText: true,
                    ),
                  ],
                ),
              ),
            MaterialButton(
                color: Colors.blue,
                splashColor: Colors.white,
                height: 55,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  'تسجيل الدخول',
                ),
                onPressed: () async {

                  if (formKey.currentState!.validate()) {
                    String error = await controller.login(
                        email:controller.emailTextController.text,
                        password:controller.passwordTextController.text);
                    if (error != "") {
                      Get.defaultDialog(
                          title: " ! تاكد من بياناتك  ", middleText: error,);
                    } else {
                      Get.off(()=>ChatPage());
                    }
                  }
                })
        ],
          ),
        )
      ),
    );
  }
}
