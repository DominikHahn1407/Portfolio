import 'package:chat_messenger_app/components/gesture_detector.dart';
import 'package:chat_messenger_app/components/text_field.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  const RegisterPage({
    super.key,
    required this.onTap,
  });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();

  void signUp() {}

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
              const Icon(
                Icons.app_registration,
                size: 100,
              ),
              const Text(
                "Register Now",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
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
                padding: const EdgeInsets.only(top: 10),
                child: CustomTextField(
                  controller: passwordConfirmController,
                  hintText: "Confirm Password",
                  obscureText: true,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25),
                child: CustomGestureDetector(onTap: signUp, text: "Register"),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already a member?"),
                  const SizedBox(
                    width: 4,
                  ),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(
                      "Login now",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      )),
    );
  }
}
