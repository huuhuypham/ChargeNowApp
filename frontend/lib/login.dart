import 'package:flutter/material.dart';
import 'package:frontend/main_scaffold_page.dart';
import 'package:frontend/mapping.dart';
import 'package:frontend/signup.dart'; // Đảm bảo bạn đã tạo file này
import 'package:frontend/start.dart';
import 'package:frontend/main.dart';
// Giả sử SignUpPage là một StatelessWidget đơn giản cho ví dụ này
// class SignUpPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Sign Up')),
//       body: Center(child: Text('Sign Up Page')),
//     );
//   }
// }

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Biến trạng thái để theo dõi việc hiển thị mật khẩu
  bool _isPasswordVisible = false;
  // Biến trạng thái cho Checkbox "Remember me"
  bool _rememberMe = false;

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
                  // Sử dụng biến trạng thái để quyết định có ẩn văn bản hay không
                  obscureText: !_isPasswordVisible,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    hintText: 'Password',
                    // Sử dụng IconButton để có thể nhấn và thay đổi trạng thái
                    suffixIcon: IconButton(
                      icon: Icon(
                        // Thay đổi icon dựa trên trạng thái
                        _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        // Cập nhật trạng thái khi icon được nhấn
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                  ),
                ),
                Row(
                  children: [
                    Checkbox(
                      value: _rememberMe,
                      onChanged: (bool? value) {
                        setState(() {
                          _rememberMe = value ?? false;
                        });
                      },
                      activeColor: Colors.tealAccent, // Tùy chỉnh màu khi được chọn
                    ),
                    Text('Remember me'),
                    Spacer(),
                    TextButton(onPressed: () {
                      // TODO: Triển khai chức năng quên mật khẩu
                    }, child: Text('Forgot Password?'))
                  ],
                ),
                SizedBox(height: 12),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.tealAccent,
                    minimumSize: Size(size.width, 50),
                    shape: RoundedRectangleBorder( // Thêm bo góc cho nút
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onPressed: () {
                    // TODO: Triển khai logic đăng nhập
                    String username = usernameController.text;
                    String password = passwordController.text;
                    print('Username: $username');
                    globalAppString = username;
                    print('Password: $password');
                    print('Remember me: $_rememberMe');
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => MainScaffoldPage()), // Đảm bảo bạn đã import MainPage
                    );

                  },
                  child: Text(
                    'Login',
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold), // Thay đổi màu chữ nếu cần
                  ),
                ),
                SizedBox(height: 12),
                Center(
                  child: Text.rich(
                    TextSpan(
                      text: "Don't have an account? ",
                      style: TextStyle(color: Colors.grey[700]), // Màu cho văn bản thường
                      children: [
                        WidgetSpan(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (_) => SignUpPage()));
                            },
                            child: Text(
                              'Sign up',
                              style: TextStyle(
                                color: Colors.tealAccent, // Màu cho chữ "Sign up"
                                fontWeight: FontWeight.bold, // Làm đậm chữ "Sign up"
                                decoration: TextDecoration.underline, // Thêm gạch chân (tùy chọn)
                                decorationColor: Colors.tealAccent, // Màu gạch chân (tùy chọn)
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Center(child: Text('Or Continue With', style: TextStyle(color: Colors.grey[600]))),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                        icon: Icon(Icons.facebook, color: Colors.blue, size: 30),
                        onPressed: () {
                          // TODO: Triển khai đăng nhập bằng Facebook
                        }
                    ),
                    SizedBox(width: 16), // Thêm khoảng cách giữa các icon
                    IconButton(
                        icon: Icon(Icons.apple, color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black, size: 30), // Icon Apple sẽ đổi màu theo theme
                        onPressed: () {
                          // TODO: Triển khai đăng nhập bằng Apple
                        }
                    ),
                    SizedBox(width: 16), // Thêm khoảng cách giữa các icon
                    // Sử dụng hình ảnh Google SVG hoặc PNG tùy chỉnh nếu muốn icon đẹp hơn
                    // Ở đây dùng tạm IconData có sẵn gần giống
                    GestureDetector(
                      onTap: () {
                        // TODO: Triển khai đăng nhập bằng Google
                      },
                      child: CircleAvatar(
                        radius: 15,
                        backgroundColor: Colors.white, // Hoặc màu nền phù hợp
                        child: Padding(
                          padding: const EdgeInsets.all(4.0), // Điều chỉnh padding nếu cần
                          // Thay thế bằng logo Google thực tế nếu có
                          child: Image.network(
                            'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Google_%22G%22_logo.svg/768px-Google_%22G%22_logo.svg.png',
                            height: 20, // Kích thước logo
                            width: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40), // Thêm khoảng trống ở cuối để dễ cuộn
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Đừng quên giải phóng controller khi widget bị hủy
  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}