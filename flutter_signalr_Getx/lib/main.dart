import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_signalr/Bindding/ChatBinding.dart';
import 'package:flutter_signalr/Screen/ChatSceen.dart';
import 'package:get/get.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter SignalR',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      initialBinding: ChatBinding(),
      home:ChatScreen(),
    );
  }
}

