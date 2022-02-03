import 'package:flutter/material.dart';

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
              TextField(
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
                textInputAction: TextInputAction.done,
                onSubmitted: (value) {
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
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 14,
                      ),
                    )
                  : const SizedBox(height: 1),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: ElevatedButton(onPressed: () {}, child: Text('Log in')),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Don\'t have an account?'),
                  TextButton(onPressed: () {}, child: const Text('Sign up')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
