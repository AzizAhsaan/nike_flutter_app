import 'package:flutter/material.dart';
import 'package:nike_app/auth/auth_service.dart';
import 'package:nike_app/components/my_button.dart';
import 'package:nike_app/components/my_textfield.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  RegisterPage({super.key, this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //email and password controller
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool isLoading = false;
  //login function
  void register(BuildContext context) async {
    //get auth service
    final _auth = AuthService();

    if (_confirmPasswordController.text == _passwordController.text) {
      try {
        _auth.signUpWithEmailPassword(
            _emailController.text, _passwordController.text);
      } catch (e) {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text(e.toString()),
                ));
      }
    } else {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text("Password does not match"),
              ));
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
              'Register account',
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
            const SizedBox(height: 15),
            MyTextfield(
              controller: _confirmPasswordController,
              hintText: 'Confirm Password',
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
                  : Text("Register now"),
              onTap: () => register(context),
            ),
            Row(
              children: [
                const Text('Already have an account?'),
                GestureDetector(
                  onTap: widget.onTap,
                  child: const Text('Sign in'),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
