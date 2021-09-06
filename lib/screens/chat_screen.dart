import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Curtain'),
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (ctx, i) => Container(
          padding: EdgeInsets.all(8),
          child: Text('This shit works'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Firestore.instance
              .collection('/chats/OLY8NDXS6l75yCRFY31J/messages')
              .snapshots()
              .listen((data) {
            data.documents.forEach((element) {
              print(element['text']);
            });
          });
        },
      ),
    );
  }
}
