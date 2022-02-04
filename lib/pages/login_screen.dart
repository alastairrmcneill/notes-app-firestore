import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes_app_firebase/pages/home_screen.dart';
import 'package:notes_app_firebase/services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  FocusNode _emailFocus = FocusNode();
  bool _emailAutoValidate = false;
  String errorText = '';

  final _emailFormKey = GlobalKey<FormFieldState>();
  final _passwordFormKey = GlobalKey<FormFieldState>();

  void signIn({bool newUser = false}) async {
    // Set error message back to blank
    setState(() {
      errorText = '';
      _emailAutoValidate = true;
    });

    // Validate email field and password then try loggin in
    if (_emailFormKey.currentState!.validate() && _passwordFormKey.currentState!.validate()) {
      dynamic result = newUser
          ? await AuthService.registerWithEmailPassword(
              _emailController.text.trim(),
              _passwordController.text.trim(),
            )
          : await AuthService.signInWithEmailPassword(
              _emailController.text.trim(),
              _passwordController.text.trim(),
            );

      // Display any errors
      if (result is FirebaseAuthException) {
        setState(() {
          errorText = result.message!;
        });
      }
      if (result is UserCredential) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen()));
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _emailFocus.addListener(() {
      if (_emailFocus.hasFocus) {
        setState(() {
          _emailAutoValidate = false;
        });
      } else {
        setState(() {
          _emailAutoValidate = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Transform.translate(
          offset: const Offset(8, 0),
          child: const Text(
            'Sign in to Notes App',
            style: TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 28,
            ),
          ),
        ),
        centerTitle: false,
      ),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
                focusNode: _emailFocus,
                key: _emailFormKey,
                textInputAction: TextInputAction.next,
                autovalidateMode: AutovalidateMode.always,
                validator: (value) {
                  if (_emailAutoValidate) {
                    if (value == null || value.isEmpty || value.length < 5 || !value.contains('@') || !(value.contains('.com') || value.contains('.co.uk'))) {
                      return 'Invalid email address';
                    }
                  }
                  return null;
                },
                maxLines: 1,
                controller: _emailController,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                  border: const OutlineInputBorder(),
                  hintText: 'example@email.com',
                  hintStyle: TextStyle(
                    color: Colors.grey[400],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
                key: _passwordFormKey,
                textInputAction: TextInputAction.done,
                validator: (value) {
                  if (value == null || value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }

                  return null;
                },
                onFieldSubmitted: (value) {
                  print(value);
                },
                obscureText: true,
                maxLines: 1,
                controller: _passwordController,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                  border: const OutlineInputBorder(),
                  hintText: 'password',
                  hintStyle: TextStyle(
                    color: Colors.grey[400],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              errorText != ''
                  ? Text(
                      errorText,
                      style: TextStyle(
                        color: Colors.red[700],
                        fontSize: 12,
                      ),
                    )
                  : const SizedBox(height: 1),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: ElevatedButton(
                    onPressed: () async {
                      signIn(newUser: false);
                    },
                    child: Text('Log in')),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Don\'t have an account?',
                  ),
                  TextButton(
                      onPressed: () async {
                        signIn(newUser: true);
                      },
                      child: const Text('Sign up')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
