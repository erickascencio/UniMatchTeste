import 'package:flutter/material.dart';

import 'cadastro_page.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  int counter = 0;
  String email = '';
  String senha = '';
  String cadastro = 'Não tem cadastro? Clique aqui!';

  Widget _body(){
    return Column(
      children: [
        SingleChildScrollView(  //permite dar Scroll na tela enquanto digita
          child: SizedBox(            //Box de Login
            width: MediaQuery.of(context).size.width, // delimita o tamanho (X,Y)
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.all(8.0),  //Distancia da borda do celular
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Container(
                      width: 300,
                      height: 300,
                      child: Image.asset('assets/images/Unimatch.png')
                  ),
                  Container(height: 20,),

                  TextField(
                    onChanged: (text){
                      print(text);
                      email = text;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(      // coloca borda no textfield
                      labelText: 'Usuário',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  Container(height: 10,),
                  TextField(
                    onChanged: (text){
                      print(text);
                      senha = text;
                    },
                    obscureText:  true,  //deixa senha nao visivel
                    decoration: InputDecoration(      // coloca borda no textfield
                      labelText: 'Senha',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  ElevatedButton(onPressed: (){
                    if(email == 'KN@email.com' && senha =='123'){
                      Navigator.of(context).pushNamed('/home');
                    }else{
                      print('Login Inválido');
                    }
                  }, child: Icon(Icons.navigate_next)),
                  Container(height: 50,),
                  ElevatedButton(onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CadastroPage()),
                    );
                  }, child: Text(cadastro),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.pink.shade,
      body: SingleChildScrollView(
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
            /**Container(
              color: Colors.black.withOpacity(0.3),
            ),**/
            _body(),
          ],
        ),
      )

    );
  }
}

/**import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget{ // cria um estado HomePage
  @override                            // Da pra alterar enquanto roda o app
  State<LoginPage> createState() {      // Dinamico
    return LoginPageState();
  }
}

class LoginPageState extends State<LoginPage>{
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(                      // Tela branca no fundo
      appBar: AppBar(                   // Molda a tela para se assemelhar a um App
        title: Text('UniMatch'),
      ),
      body: Container(
        height: 800,
        width: 500,
        color: Colors.pinkAccent,
        child: Align(                     // alinhamento do container
          alignment: Alignment.center, //Essas duas linhas podem ser subs por center
          child: Container(
            child : Center(
              child: Text('UNIMATCH',
                  style: TextStyle(color: Colors.white, fontSize: 20.0)),
            ),
            height: 200,
            width: 200,
            color: Colors.pink,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton( // botao flutuante dir/baixo
        child: Icon(Icons.add), // icone do botao
        onPressed: () {
          setState(() { //muda o estado a cada clicada na tela
            counter++;
            print(counter); // printa no terminal
          });
        } ,
      ),
    );
  }

}**/