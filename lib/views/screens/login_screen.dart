import 'package:flutter/material.dart';
import 'package:library_system/views/screens/library_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //! assign a global key to the form
  final _formKey = GlobalKey<FormState>();
  //! create text editing controllers here
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  //! set obscure text to true
  bool _obscureText = true;
  //! dispose controllers
  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  //! username and passowrd
  final String _username = 'admin';
  final String _password = 'admin123';
  //! validate username
  String? validateUsername(String? value) {
    final value0 = value?.trim() ?? '';
    if (value0.isEmpty) return 'Please enter your username';
    if (value0.contains(' ')) return 'No spaces allowed';
    if (value0.length < 3) return 'Username must be at least 3 characters';
    return null;
  }

  //! validate password
  String? validatePassword(String? value) {
    final value0 = value ?? '';
    if (value0.isEmpty) return 'Please enter your password';
    if (value0.length < 6) return 'Password must be at least 6 characters';
    return null;
  }

  //! function when the login button is pressed
  void onLoginPressed() {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState!.validate()) {
      if (usernameController.text.trim() == _username &&
          passwordController.text == _password) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Welcome, ${usernameController.text.trim()}!'),
            backgroundColor: Colors.green.shade400,
          ),
        );
        Navigator.push(context, MaterialPageRoute(builder: (context) => LibraryScreen(),));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Invalid username or password'),
            backgroundColor: Colors.red.shade400,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.local_library_outlined),
          title: Text('Henry Luce III Library'),
        ),
        body: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 420),
            child: Padding(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 20),
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 20),
                    TextFormField(
                      controller: usernameController,
                      decoration: InputDecoration(
                        labelText: 'Username',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.person),
                      ),
                      validator: validateUsername,
                      textInputAction: TextInputAction.next,
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureText
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                        ),
                      ),
                      validator: validatePassword,
                      obscureText: _obscureText,
                      textInputAction: TextInputAction.done,
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: onLoginPressed,
                        child: Text('Login'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
