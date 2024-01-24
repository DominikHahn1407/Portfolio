import 'package:chat_messenger_app/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void signOut() {
    final authService = Provider.of<AuthService>(context, listen: false);
    authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text("HomePage"),
        ),
        actions: [
          IconButton(
            onPressed: signOut,
            icon: const Icon(Icons.logout),
          )
        ],
      ),
    );
  }
}
