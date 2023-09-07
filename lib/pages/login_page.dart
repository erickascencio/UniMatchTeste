import 'package:flutter/material.dart';
import 'package:unimatchteste/controller/security/UserAuth.dart';
import 'package:unimatchteste/pages/perfil_page.dart';
import '../controller/service/LoginService.dart';
import 'cadastro_page.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  UserAuth authService = UserAuth();
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
                    decoration: const InputDecoration(
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
                    decoration: const InputDecoration(
                      // coloca borda no textfield
                      labelText: 'Senha',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      LoginService securityController = LoginService();
                      String result =
                          await securityController.signIn(email, senha);
                      if (result == 'first_login') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PerfilPage()),
                        );
                      } else if (result == 'success') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(result),
                          ),
                        );
                      }
                    },
                    child: const Icon(Icons.navigate_next),
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
