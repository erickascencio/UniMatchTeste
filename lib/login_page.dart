import 'package:firebase_auth/firebase_auth.dart';
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
  Widget _body() {
    return Column(
      children: [
        SingleChildScrollView(
          //permite dar Scroll na tela enquanto digita
          child: SizedBox(
            //Box de Login
            width:
                MediaQuery.of(context).size.width, // delimita o tamanho (X,Y)
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding:
                  const EdgeInsets.all(8.0), //Distancia da borda do celular
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      width: 300,
                      height: 300,
                      child: Image.asset('assets/images/Unimatch.png')),
                  Container(
                    height: 20,
                  ),
                  TextField(
                    onChanged: (text) {
                      print(text);
                      email = text;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      // coloca borda no textfield
                      labelText: 'Usuário',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  Container(
                    height: 10,
                  ),
                  TextField(
                    onChanged: (text) {
                      print(text);
                      senha = text;
                    },
                    obscureText: true, //deixa senha nao visivel
                    decoration: InputDecoration(
                      // coloca borda no textfield
                      labelText: 'Senha',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      try {
                        UserCredential userCredential = await FirebaseAuth
                            .instance
                            .signInWithEmailAndPassword(
                          email: email,
                          password: senha,
                        );
                        print('Login realizado com sucesso!');
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                        );
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          print('Usuário não encontrado');
                        } else if (e.code == 'wrong-password') {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Senha incorreta'),
                            ),
                          );
                        }
                      } catch (e) {
                        print(e);
                      }
                    },
                    child: Icon(Icons.navigate_next),
                  ),
                  Container(
                    height: 50,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CadastroPage()),
                      );
                    },
                    child: Text(cadastro),
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
    ));
  }
}
