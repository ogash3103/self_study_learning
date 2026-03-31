import 'package:flutter/material.dart';

void main() {
  runApp(const LoginApp());
}

class LoginApp extends StatelessWidget {
  const LoginApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();

  final nameFocus = FocusNode();
  final emailFocus = FocusNode();
  final passwordFocus = FocusNode();

  bool isPasswordHidden = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    nameFocus.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
    super.dispose();
  }

  void signUp() {
    FocusScope.of(context).unfocus();

    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Email: ${emailController.text}\nParol: ${passwordController.text}\nParol: ${nameController.text}",
          ),
        ),
      );
    }
  }

  InputDecoration buildInputDecoration({
    required String? label,
    Widget? suffixIcon,
  }) {
    return InputDecoration(labelText: label, suffixIcon: suffixIcon);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(30),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const Text(
                    "Instagram",
                    style: TextStyle(
                      fontSize: 40,
                      letterSpacing: 2,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 24),
                  // name
                  TextFormField(
                    controller: nameController,
                    focusNode: nameFocus,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,

                    decoration: buildInputDecoration(label: "Name"),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Ismingizni kiriting";
                      }

                      return null;
                    },
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(emailFocus);
                    },
                  ),
                  const SizedBox(height: 16),
                  // email
                  TextFormField(
                    controller: emailController,
                    focusNode: emailFocus,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,

                    decoration: buildInputDecoration(label: "Email"),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Email kiriting";
                      }
                      if (!value.contains("@")) {
                        return "Email format noto‘g‘ri";
                      }
                      return null;
                    },
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(passwordFocus);
                    },
                  ),
                  const SizedBox(height: 16),
                  // password
                  TextFormField(
                    controller: passwordController,
                    focusNode: passwordFocus,
                    obscureText: isPasswordHidden,
                    textInputAction: TextInputAction.done,
                    decoration: buildInputDecoration(
                      label: "Parol",
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isPasswordHidden = !isPasswordHidden;
                          });
                        },
                        icon: Icon(
                          isPasswordHidden
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Parol kiriting";
                      }
                      if (value.length < 6) {
                        return "Parol kamida 6 ta belgi bo‘lsin";
                      }
                      return null;
                    },
                    onFieldSubmitted: (_) => signUp(),
                  ),
                  const SizedBox(height: 24),
                  // button
                  SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: signUp,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  // LogIn page

                     Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Already have an account?",
                          style: TextStyle(fontSize: 12, color: Colors.black87),
                        ),
                        SizedBox(width: 12),
                        Text("Log In",
                          style: TextStyle(fontSize: 12, color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
