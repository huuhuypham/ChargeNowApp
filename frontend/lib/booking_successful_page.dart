import 'package:flutter/material.dart';

class BookingSuccessfulPage extends StatefulWidget {
  // Các tham số này có thể không còn quá liên quan nếu chỉ là xác nhận đặt chỗ,
  // nhưng vẫn giữ lại nếu bạn muốn hiển thị một số chi tiết.
  // Ví dụ, bạn có thể muốn hiển thị ID đặt chỗ hoặc thời gian.
  final String bookingId; // Ví dụ: "BK-12345"
  final String bookingTime; // Ví dụ: "10:00 AM - 10:30 AM, July 29, 2024"

  const BookingSuccessfulPage({
    Key? key,
    required this.bookingId,
    required this.bookingTime,
  }) : super(key: key);

  @override
  _BookingSuccessfulPageState createState() => _BookingSuccessfulPageState();
}

class _BookingSuccessfulPageState extends State<BookingSuccessfulPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800), // Tốc độ animation nhanh hơn một chút
    )..forward(); // Chạy một lần khi vào trang

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.elasticOut, // Hiệu ứng nảy ra
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final Color primaryColor = theme.colorScheme.primary; // Nên là Colors.tealAccent
    final Color cardBackgroundColor = const Color(0xFF1A1A26); // Màu nền tối cho card
    final Color successColor = Colors.tealAccent[400]!; // Màu xanh thành công

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: const Color(0xFF1C1C2A),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(context, '/main', (Route<dynamic> route) => false);
          },
        ),
        title: const Text(
          'Booking Confirmation', // Đổi tiêu đề AppBar
          style: TextStyle(
            color: Color(0xFFEFF8E3),
            fontSize: 20,
            fontWeight: FontWeight.w500,
            fontFamily: 'Poppins',
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            decoration: BoxDecoration(
                color: cardBackgroundColor,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 15,
                    spreadRadius: 5,
                  )
                ]
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ScaleTransition(
                  scale: _scaleAnimation,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: successColor.withOpacity(0.15),
                        border: Border.all(color: successColor, width: 2.5) // Làm viền dày hơn một chút
                    ),
                    child: Icon(
                      Icons.check_circle_outline, // Biểu tượng cho việc đặt chỗ thành công
                      size: 80,
                      color: successColor,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Booking Successful!', // Tiêu đề chính
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Your spot is confirmed.', // Thông điệp phụ
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: successColor,
                    fontSize: 18, // Kích thước chữ nhỏ hơn một chút
                    fontWeight: FontWeight.w500, // Trọng lượng chữ bình thường hơn
                    fontFamily: 'Poppins',
                  ),
                ),
                const SizedBox(height: 20), // Tăng khoảng cách
                Text(
                  // Hiển thị thông tin đặt chỗ nếu cần
                  'Booking ID: ${widget.bookingId}\nTime: ${widget.bookingTime}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.grey[300],
                      fontSize: 14, // Kích thước chữ nhỏ hơn
                      fontFamily: 'Poppins',
                      height: 1.5
                  ),
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(context, '/main', (Route<dynamic> route) => false);
                  },
                  child: const Text(
                    'OK',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
