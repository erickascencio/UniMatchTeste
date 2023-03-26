import 'package:flutter/material.dart';
import 'dart:async';

import 'package:unimatchteste/login_page.dart';

class LoadingPage extends StatefulWidget {

  @override
  State<LoadingPage> createState() => LoadingPageState();
}

class LoadingPageState extends State<LoadingPage> {

  @override
  void initState() {  //ESTADO DE INICIALIZAÇÃO
    // TODO: implement initState
    super.initState();

    Timer(Duration(seconds: 4),(){ //REDIRECIONAMENTO DA TELA APOS 4 SEG
      Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                'assets/images/background.png',
                fit: BoxFit.cover,
              ),
            ),
            Container(
              height: 300.0, //ALTURA DO GIRA GIRA
              child: Align(
                alignment: Alignment.center,
                child: CircularProgressIndicator( //GIRA GIRA
                  valueColor: AlwaysStoppedAnimation(Colors.pink.shade200),
                  strokeWidth: 11.0,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
