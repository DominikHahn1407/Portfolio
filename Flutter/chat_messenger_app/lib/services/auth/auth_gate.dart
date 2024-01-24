import 'package:chat_messenger_app/pages/home_page.dart';
import 'package:chat_messenger_app/services/auth/login_or_register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            // Logged in User
            if (snapshot.hasData) {
              return const HomePage();
            }
            // Not Logged in User
            else {
              return const LoginOrRegister();
            }
          }),
    );
  }
}
