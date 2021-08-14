// To parse this JSON data, do
//
//     final message = messageFromMap(jsonString);

import 'dart:convert';

List<Message> messageFromMap(String str) => List<Message>.from(json.decode(str).map((x) => Message.fromMap(x)));

String messageToMap(List<Message> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class Message {
  Message({
    this.id,
    this.userName,
    this.text,
    this.when,
    this.userId,
    this.sender,
  });

  int? id;
  String? userName;
  String? text;
  DateTime? when;
  String? userId;
  dynamic sender;

  factory Message.fromMap(Map<String, dynamic> json) => Message(
    id: json["id"],
    userName: json["userName"],
    text: json["text"],
    when: DateTime.parse(json["when"]),
    userId: json["userId"],
    sender: json["sender"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "userName": userName,
    "text": text,
    "when": when!.toIso8601String(),
    "userId": userId,
    "sender": sender,
  };
}
