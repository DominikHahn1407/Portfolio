import 'package:chat_messenger_app/components/gesture_detector.dart';
import 'package:chat_messenger_app/components/text_field.dart';
import 'package:chat_messenger_app/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;
  const LoginPage({
    super.key,
    required this.onTap,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void login() async {
    final authService = Provider.of<AuthService>(context, listen: false);

    try {
      await authService.signInWithEmailAndPassword(
        emailController.text,
        passwordController.text,
      );
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "ChatMessenger",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Icon(
                  Icons.message,
                  size: 100,
                ),
                const SizedBox(
                  height: 20,
                ),
                // const Text(
                //   "Welcome back you\'ve been missed!",
                //   style: TextStyle(
                //     fontSize: 16,
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: CustomTextField(
                    controller: emailController,
                    hintText: "Email",
                    obscureText: false,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: CustomTextField(
                    controller: passwordController,
                    hintText: "Password",
                    obscureText: true,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: CustomGestureDetector(onTap: login, text: "Login"),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Not a member?"),
                    const SizedBox(
                      width: 4,
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        "Register now",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
