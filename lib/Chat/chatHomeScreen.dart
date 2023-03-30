import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:unimatchteste/Chat/matchesFavoritos.dart';
import 'package:unimatchteste/Chat/category_selector.dart';

import 'chatsRecentes.dart';
import 'message_model.dart';

class ChatHomeScreen extends StatefulWidget {
  @override
  State<ChatHomeScreen> createState() => _ChatHomeScreenState();
}

class _ChatHomeScreenState extends State<ChatHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          iconSize: 30.0,
          color: Colors.white,
          onPressed: (){},
        ),
        title: Text(
          'Chat',
          style: TextStyle(
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            iconSize: 30.0,
            color: Colors.white,
            onPressed: (){},
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          CategorySelector(),
          Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                ),
                child: Column(
                  children: [
                    MatchesFavoritos(),
                    ChatsRecentes(),
                  ],
                ),
              ),
          ),
        ],
      ),
    );
  }
}