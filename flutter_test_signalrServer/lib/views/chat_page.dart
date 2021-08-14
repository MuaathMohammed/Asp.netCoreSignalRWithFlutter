import 'package:flutter/material.dart';
import 'package:flutter_test_signalr/controller/chat_controller.dart';
import 'package:get/get.dart';

class ChatPage extends StatelessWidget{
//ChatController controller=Get.find<ChatController>();
  ChatController controller=Get.put(ChatController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SignalRTest'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 100.0),
        child: Obx(()=>controller.isLoading.isTrue?Center(child: CircularProgressIndicator(color: Colors.blue,),):ListView.builder(
          itemCount: controller.messages.length,
          itemBuilder: (ctx, i) {

            return  Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0),
              bottomLeft: Radius.circular(20.0),
              ),
              child:
                   Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                  Text(controller.messages[i]!.userName??''),
                  Text(controller.messages[i]!.text??''),
                  Text( '${controller.messages[i]!.when??''}'),
                ],
              )),
            );
          },
        )),
      ),
      bottomSheet: Form(
        key: _formKey,
        child: Container(
          color: Theme.of(context).accentColor,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(5),
          height: MediaQuery.of(context).size.height/6,
          child:
              Material(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20.0),
                  topLeft: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0),
                  bottomLeft: Radius.circular(20.0),
                ),
                child: TextFormField(controller: controller.name,
                  decoration: InputDecoration(labelText: "Text...",contentPadding: EdgeInsets.all(10)),
                )
              ),),
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

