class LoginPage extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 60),
                Text(
                  'Welcome to\nChargeNow',
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 32),
                TextField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    hintText: 'Username',
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    hintText: 'Password',
                    suffixIcon: Icon(Icons.visibility_off),
                  ),
                ),
                Row(
                  children: [
                    Checkbox(value: false, onChanged: (_) {}),
                    Text('Remember me'),
                    Spacer(),
                    TextButton(onPressed: () {}, child: Text('Forgot Password?'))
                  ],
                ),
                SizedBox(height: 12),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.tealAccent,
                    minimumSize: Size(size.width, 50),
                  ),
                  onPressed: () {},
                  child: Text('Login'),
                ),
                SizedBox(height: 12),
                Center(
                  child: Text.rich(
                    TextSpan(
                      text: "Don't have an account? ",
                      children: [
                        WidgetSpan(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (_) => SignupPage()));
                            },
                            child: Text(
                              'Sign up',
                              style: TextStyle(color: Colors.tealAccent),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Center(child: Text('Or Continue With')),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(icon: Icon(Icons.facebook, color: Colors.blue), onPressed: () {}),
                    IconButton(icon: Icon(Icons.apple, color: Colors.white), onPressed: () {}),
                    IconButton(icon: Icon(Icons.g_mobiledata, color: Colors.red), onPressed: () {}),
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
