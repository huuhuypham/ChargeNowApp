import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController(); // Controller cho tên đăng nhập
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();

  SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(
          color: theme.colorScheme.onBackground,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Create Account',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onBackground,
                  ),
                ),
                const SizedBox(height: 32),

                _buildTextField(
                  controller: nameController,
                  hintText: 'Full Name',
                  icon: Icons.person_outline,
                  theme: theme,
                ),
                const SizedBox(height: 16),
                // Thêm trường Tên đăng nhập
                _buildTextField(
                  controller: usernameController,
                  hintText: 'Username', // Hint text cho tên đăng nhập
                  icon: Icons.account_circle_outlined, // Icon cho tên đăng nhập
                  theme: theme,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: emailController,
                  hintText: 'Email Address',
                  icon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  theme: theme,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: passController,
                  hintText: 'Password',
                  icon: Icons.lock_outline,
                  obscureText: true,
                  theme: theme,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: confirmPassController,
                  hintText: 'Confirm Password',
                  icon: Icons.lock_outline,
                  obscureText: true,
                  theme: theme,
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,
                    minimumSize: Size(size.width, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onPressed: () {
                    final String name = nameController.text;
                    final String username = usernameController.text; // Lấy giá trị tên đăng nhập
                    final String email = emailController.text;
                    final String password = passController.text;
                    final String confirmPassword = confirmPassController.text;
                    print('Full Name: $name');
                    print('Username: $username'); // In giá trị tên đăng nhập
                    print('Email: $email');
                    print('Password: $password');
                    print('Confirm Password: $confirmPassword');

                    // Basic validation
                    if (name.isEmpty || username.isEmpty || email.isEmpty || password.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Please fill in all fields."),
                          backgroundColor: Colors.orangeAccent,
                        ),
                      );
                      return;
                    }

                    if (password == confirmPassword) {
                      // TODO: Implement actual sign up logic (e.g., API call)
                      print('Sign up successful (mock)');

                      // After successful sign-up logic, navigate back
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context); // Quay lại trang trước đó
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Passwords do not match!"),
                          backgroundColor: Colors.redAccent,
                        ),
                      );
                    }
                  },
                  child: Text(
                    'Sign up',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context); // Nếu trang Sign Up được push từ Login, thì pop để quay lại
                      } else {
                        // Nếu không thể pop (ví dụ: SignUp là trang đầu tiên), thì thay thế bằng Login
                        Navigator.pushReplacementNamed(context, '/login');
                      }
                    },
                    child: Text.rich(
                      TextSpan(
                        text: "Have an account? ",
                        style: TextStyle(color: theme.textTheme.bodyMedium?.color?.withOpacity(0.7)),
                        children: [
                          TextSpan(
                            text: 'Sign in',
                            style: TextStyle(
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Center(
                  child: Text.rich(
                    TextSpan(
                      text: "By continuing you agree to our ",
                      style: TextStyle(color: theme.textTheme.bodyMedium?.color?.withOpacity(0.7), fontSize: 12),
                      children: [
                        TextSpan(
                            text: "Terms of Service",
                            style: TextStyle(color: theme.colorScheme.primary, fontSize: 12, fontWeight: FontWeight.w500)),
                        TextSpan(text: " and "),
                        TextSpan(
                            text: "Privacy Policy",
                            style: TextStyle(color: theme.colorScheme.primary, fontSize: 12, fontWeight: FontWeight.w500)),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
    required ThemeData theme,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      style: TextStyle(color: theme.colorScheme.onBackground),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: theme.colorScheme.onBackground.withOpacity(0.5)),
        prefixIcon: Icon(icon, color: theme.colorScheme.onBackground.withOpacity(0.7)),
        filled: true,
        fillColor: theme.colorScheme.surfaceVariant.withOpacity(0.3),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: theme.colorScheme.primary, width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
      ),
    );
  }
}
