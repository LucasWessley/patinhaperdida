import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'FeedPage.dart';
import 'registerPage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _erro;

  Future<void> _login() async {
    final navigator = Navigator.of(context);

    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      if (credential.user != null) {
        navigator.pushReplacement(
          MaterialPageRoute(
            builder: (context) => FeedPage(),
          ),
        );
      }
    } catch (e) {
      setState(() {
        _erro = "E-mail ou Senha incorreta.";
      });
      print("Erro de Login: $e");
    }
  }

  Future<void> _signInWithEmailAndPassword(BuildContext context) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

   
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => FeedPage()));
    } catch (e) {

      print("Erro de Login: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'PatinhaPerdida - Login',
            style: TextStyle(color: Colors.black),
          ),
        ),
        backgroundColor: Color.fromARGB(255, 134, 195, 245),
      ),
      backgroundColor: Colors.lightGreen[100],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                  labelText: 'E-mail', prefixIcon: Icon(Icons.email)),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Senha',
                prefixIcon: Icon(Icons.password),
              ),
              obscureText: true,
            ),
            SizedBox(height: 32.0),
            ElevatedButton.icon(
              onPressed: _login,
              icon: Icon(Icons.login), 
              label: Text('Login'),
            ),
            SizedBox(height: 16.0),
            TextButton.icon(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterPage()),
                );
              },
              icon: Icon(Icons
                  .person_add), 
              label: Text('Criar conta'),
            ),
            if (_erro != null)
              Text(
                _erro!,
                style: TextStyle(color: Colors.red),
              ),
          ],
        ),
      ),
    );
  }
}
