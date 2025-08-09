import 'package:flutter/material.dart';
class StartPage extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: BackButton(),
        actions: [Icon(Icons.person)],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(hintText: 'example name'),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(hintText: 'example.com'),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: passController,
                  obscureText: true,
                  decoration: InputDecoration(hintText: '********'),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: confirmPassController,
                  obscureText: true,
                  decoration: InputDecoration(hintText: '********'),
                ),
                SizedBox(height: 24),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.tealAccent,
                    minimumSize: Size(size.width, 50),
                  ),
                  onPressed: () {},
                  child: Text('Sign up'),
                ),
                SizedBox(height: 12),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  child: Text.rich(
                    TextSpan(
                      text: "Have an account? ",
                      children: [
                        TextSpan(
                          text: 'Sign in',
                          style: TextStyle(color: Colors.tealAccent),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 24),
                Text.rich(
                  TextSpan(
                    text: "By continuing you agree to our ",
                    children: [
                      TextSpan(text: "Terms of Service", style: TextStyle(color: Colors.tealAccent)),
                      TextSpan(text: " and "),
                      TextSpan(text: "Privacy Policy", style: TextStyle(color: Colors.tealAccent)),
                    ],
                  ),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
