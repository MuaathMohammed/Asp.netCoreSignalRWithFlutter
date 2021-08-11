import 'package:flutter/material.dart';
import 'package:flutter_signalr/Controller/ChatController.dart';
import 'package:get/get.dart';

class ChatScreen extends StatelessWidget {
  ChatController controller=Get.put(ChatController());
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('SignalRTest'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Obx(()=>ListView.builder(
            itemCount: controller.messages.length,
            itemBuilder: (ctx, i) {
              return Text(controller.messages[i]);
            },
          )),
        ),
        bottomSheet: Container(
          color: Theme.of(context).accentColor,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(5),
          height: MediaQuery.of(context).size.height/4,
          child: Column(
            children: [
              Material(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20.0),
                  topLeft: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0),
                  bottomLeft: Radius.circular(20.0),
                ),
                child: TextFormField(
                  controller: controller.username,
                  decoration: InputDecoration(labelText: "Name...",contentPadding: EdgeInsets.all(10)),
                ),
              ),
              Divider(),
              Material(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20.0),
                  topLeft: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0),
                  bottomLeft: Radius.circular(20.0),
                ),
                child: TextFormField(
                  controller: controller.text,
                  decoration: InputDecoration(labelText: "Text...",contentPadding: EdgeInsets.all(10)),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.send),
          onPressed: () {
            controller.sendMessage();
          },
        ),
      );
    }

}
