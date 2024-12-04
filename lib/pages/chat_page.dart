import 'package:flutter/material.dart';
import 'package:my_chat_app/constants.dart';

import '../widgets/chat_messages.dart';
import '../widgets/new_message.dart';
class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          SizedBox(
            width: 60,
            child: Image.asset(kLogo),
          ),
          const Text('Chat',style: TextStyle(color: Colors.white,fontFamily: 'Pacifico'),),
        ],),
        actions: [
          IconButton(onPressed: (){
            Navigator.pushReplacementNamed(context, 'login');
          }, icon: const Icon(Icons.exit_to_app,color: Colors.white,)),
        ],

        centerTitle: true,
        backgroundColor: kPrimaryColor,
        automaticallyImplyLeading: false,
      ),
      body: const Column(
        children: [
          Expanded(child: ChatMessages()),
          NewMessage(),
        ],
      ),
    );

  }
}
