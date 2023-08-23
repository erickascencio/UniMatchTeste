import 'package:firebase_auth/firebase_auth.dart';
import 'package:unimatchteste/controller/security/UserAuth.dart';

class SecurityController {
  final UserAuth _authService;

  SecurityController(this._authService);

    Future<String> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _authService.userAuth(email, password);
      print('Login realizado com sucesso!');
      return 'success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'Usuário não encontrado';
      } else if (e.code == 'wrong-password') {
        return 'Senha incorreta';
      } else {
        return 'Erro desconhecido';
      }
    } catch (e) {
      print(e);
      return 'Erro desconhecido';
    }
  }
}

