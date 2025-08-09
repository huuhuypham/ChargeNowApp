import 'package:flutter/material.dart';

class CancelBookingBottomSheet extends StatelessWidget {
  final VoidCallback onConfirmCancel; // Callback khi nhấn "Yes, cancel"
  final VoidCallback onKeepBooking;   // Callback khi nhấn "No, don't cancel"

  const CancelBookingBottomSheet({
    Key? key,
    required this.onConfirmCancel,
    required this.onKeepBooking,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // Màu sắc có thể được lấy từ theme hoặc định nghĩa trực tiếp
    final Color primaryActionColor = theme.colorScheme.primary; // Ví dụ: Colors.tealAccent
    final Color destructiveActionColor = const Color(0xFFD24444); // Màu đỏ cho nút hủy
    final Color sheetBackgroundColor = const Color(0xFF010101);
    final Color textColor = const Color(0xFFF3F0FF);
    final Color borderColor = const Color(0xFF07B68B);

    return Container(
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 30), // Giảm padding dưới để tránh khoảng trống thừa với safe area
      decoration: BoxDecoration(
        color: sheetBackgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(18),
          topRight: Radius.circular(18),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2), // Giảm độ mờ của shadow
            offset: const Offset(0, -5), // Điều chỉnh offset
            blurRadius: 15,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // Để bottom sheet chỉ chiếm chiều cao cần thiết
        children: [
          const SizedBox(height: 12), // Giảm khoảng trống trên cùng
          Container(
            width: 40, // Tăng chiều rộng một chút
            height: 5,
            decoration: BoxDecoration(
              color: Colors.grey[700], // Màu cho thanh kéo
              borderRadius: BorderRadius.circular(9),
            ),
          ),
          const SizedBox(height: 27),
          Center(
            child: Text(
              'Cancel Booking',
              style: TextStyle(
                color: destructiveActionColor,
                fontSize: 24, // Giảm kích thước font một chút
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins',
              ),
            ),
          ),
          const SizedBox(height: 20),
          Divider(color: Colors.grey[800]), // Sử dụng Divider widget
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0), // Thêm padding ngang
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded( // Cho phép text xuống dòng nếu cần
                  child: Text(
                    'Are you sure you want to cancel this booking?', // Sửa lại câu hỏi cho rõ ràng
                    style: TextStyle(
                      color: textColor,
                      fontSize: 18, // Giảm kích thước font
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
                // Không có nút "Reset" trong thiết kế này, nếu cần có thể thêm lại
                // TextButton(
                //   onPressed: () { /* Xử lý Reset nếu cần */ },
                //   child: Text(
                //     'Reset',
                //     style: TextStyle(
                //       color: textColor,
                //       fontSize: 16,
                //       fontWeight: FontWeight.w500,
                //       fontFamily: 'Poppins',
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: onKeepBooking,
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15), // Giảm padding
                    side: BorderSide(color: borderColor, width: 1.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // Bo góc đồng nhất hơn
                    ),
                  ),
                  child: Text(
                    'No, don\'t cancel',
                    style: TextStyle(
                      color: borderColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 18),
              Expanded(
                child: ElevatedButton(
                  onPressed: onConfirmCancel,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryActionColor, // Màu nút chính
                    padding: const EdgeInsets.symmetric(vertical: 15), // Giảm padding
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // Bo góc đồng nhất hơn
                    ),
                  ),
                  child: const Text(
                    'Yes, cancel',
                    style: TextStyle(
                      color: Colors.black, // Màu chữ trên nút chính
                      fontSize: 16,
                      fontWeight: FontWeight.w600, // Chữ đậm hơn
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10), // Khoảng đệm dưới cùng nhỏ hơn
        ],
      ),
    );
  }
}

