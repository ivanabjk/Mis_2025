import 'package:flutter/material.dart';

import '../auth/auth_service.dart';
import '../widgets/my_button.dart';
import '../widgets/my_textfield.dart';
class RegisterScreen extends StatefulWidget {
  final Function()? onTap;

  RegisterScreen({
    super.key,
    required this.onTap,
  });

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final _auth = AuthService();

  void register() {
    if(passwordController.text == confirmPasswordController.text){
      try{
        _auth.signUpWithEmailPassword(
          emailController.text,
          passwordController.text,
        );
      } catch (e){
        showErrorMessage(e.toString());
      }
    } else{
      showErrorMessage("Passwords don't match.");
    }
  }


  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Error"),
        content: Text("Firebase error: $message"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50,
                ),
                // logo
                Icon(
                  Icons.set_meal,
                  size: 100,
                  // color: Theme.of(context).colorScheme.primary,
                ),

                SizedBox(
                  height: 50,
                ),
                // welcome back, you've been missed!
                Text(
                  "Become a new member!",
                  style: TextStyle(
                    // color: Theme.of(context).colorScheme.primary,
                    fontSize: 16,
                  ),
                ),

                SizedBox(
                  height: 25,
                ),

                // email textField

                MyTextField(
                  controller: emailController,
                  hintText: "Email",
                  obscureText: false,
                ),

                SizedBox(
                  height: 10,
                ),

                // password textField

                MyTextField(
                  controller: passwordController,
                  hintText: "Password",
                  obscureText: true,
                ),

                SizedBox(
                  height: 10,
                ),

                // confirm password textField

                MyTextField(
                  controller: confirmPasswordController,
                  hintText: "Confirm Password",
                  obscureText: true,
                ),

                SizedBox(
                  height: 10,
                ),

                // forgot password?
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Forgot password?",
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height: 25,
                ),

                // sign in button

                MyButton(
                  text: "Register",
                  // onTap: signUserIn,
                  onTap: register,
                ),

                SizedBox(
                  height: 50,
                ),

                // or continue with

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          "Or continue with",
                          style: TextStyle(color: Colors.grey.shade700),
                        ),
                      ),
                      Expanded(
                        child: Divider(),
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height: 50,
                ),


                SizedBox(
                  height: 50,
                ),

                // not a member? register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already a member?",
                      style: TextStyle(color: Colors.grey.shade700),
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
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