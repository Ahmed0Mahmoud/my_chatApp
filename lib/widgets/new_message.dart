import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class NewMessage extends StatefulWidget {
  const NewMessage({super.key});

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final TextEditingController messageController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    messageController.dispose();
  }
  sendMessage()async{
    final enteredMessage = messageController.text;
    if(enteredMessage.trim().isEmpty){
      return;
    }
    final User user = FirebaseAuth.instance.currentUser!;  //بتخزن مين اليوزر الي هيبعت
    final userData = await FirebaseFirestore.instance.collection('users').doc(user.uid).get(); //رجعلي بيانات اليوزرز
    await FirebaseFirestore.instance.collection('chats').add({
      'text':enteredMessage,
      "createdAt":Timestamp.now(),
      'userId' : user.uid,
      'userName' : userData.data()!['userName'],
    });

    messageController.clear();


  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 14,bottom: 14,right: 1),
      child: Row(
        children: [
           Expanded(
            child: TextField(
              controller: messageController,
              decoration: InputDecoration(
                labelText: 'Send message...',
                labelStyle: TextStyle(color: Colors.black),
              ),
              autocorrect: true,
              enableSuggestions: true,
              textCapitalization: TextCapitalization.sentences,
            ),
          ),
          IconButton(onPressed:sendMessage, icon: const Icon(Icons.send,color: Colors.deepPurpleAccent,size: 27,))

        ],
      ),
    );
  }
}
