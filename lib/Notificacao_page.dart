import 'dart:async';
import 'package:flutter/material.dart';
import 'package:unimatchteste/cadastro_page.dart';

class NotificacaoSenhaPage extends StatefulWidget {

  @override
  State<NotificacaoSenhaPage> createState() => NotificacaoSenhaPageState();
}

class NotificacaoSenhaPageState extends State<NotificacaoSenhaPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('AVISO'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('Os campos "SENHA" E '
                '"CONFIRMAR SENHA" devem ser os mesmos',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


