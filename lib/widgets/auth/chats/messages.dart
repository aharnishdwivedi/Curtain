import 'package:chatapp_oldv/widgets/auth/chats/message_bubble.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseAuth.instance.currentUser(),
      builder: (ctx, snapshot) =>
          snapshot.connectionState == ConnectionState.waiting
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : StreamBuilder(
                  stream: Firestore.instance
                      .collection('chat')
                      .orderBy(
                        'timestamp',
                        descending: true,
                      )
                      .snapshots(),
                  builder: (ctx, chatSnapshot) {
                    if (chatSnapshot.connectionState == ConnectionState.waiting)
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    final chatDocs = chatSnapshot.data.documents;
                    return ListView.builder(
                      reverse: true,
                      itemCount: chatDocs.length,
                      itemBuilder: (ctx, index) {
                        return MessageBubble(
                          chatDocs[index]['text'],
                          chatDocs[index]['username'],
                          chatDocs[index]['userId'] == snapshot.data.uid,
                          chatDocs[index]['userImage'],
                          key: ValueKey(
                            chatDocs[index].documentID,
                          ),
                        );
                        //  Text(chatDocs[index]['text']);
                      },
                    );
                  },
                ),
    );
  }
}
