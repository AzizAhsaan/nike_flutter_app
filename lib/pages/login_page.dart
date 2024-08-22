import 'package:flutter/material.dart';
import 'package:nike_app/auth/auth_service.dart';
import 'package:nike_app/components/my_button.dart';
import 'package:nike_app/components/my_textfield.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;
  LoginPage({super.key, this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //email and password controller
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();
  bool isLoading = false;
  //login function
  void login(BuildContext context) async {
    final authService = AuthService();
    setState(() {
      isLoading = true;
    });

    //try login

    try {
      await authService.signInWithEmailPassword(
          _emailController.text, _passwordController.text);
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(title: Text(e.toString())));
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Hello again',
              style: TextStyle(
                color: Colors.black,
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              child: Text(
                textAlign: TextAlign.center,
                'Fill your details or continue with social media',
                style: TextStyle(color: Colors.black45, fontSize: 20),
              ),
            ),
            const SizedBox(height: 10),
            MyTextfield(
              controller: _emailController,
              hintText: 'Email',
              obscureText: false,
            ),
            SizedBox(height: 15),
            MyTextfield(
              controller: _passwordController,
              hintText: 'Password',
              obscureText: true,
            ),
            SizedBox(height: 15),
            MyButton(
              text: isLoading
                  ? SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ))
                  : Text("Sign in"),
              onTap: () => login(context),
            ),
            Row(
              children: [
                const Text('Don\'t have an account?'),
                GestureDetector(
                  onTap: widget.onTap,
                  child: const Text('Sign up'),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
