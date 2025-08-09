import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Cần thiết nếu bạn muốn format thời gian động

// Giả sử BookingDetailsRow được định nghĩa ở đây hoặc bạn sẽ thay thế nó
// import '../theme/booking_details_card.dart'; // If you have this
// Import component bottom sheet mới
import '../component/cancel_booking_bottom_sheet.dart'; // Điều chỉnh đường dẫn nếu cần

// Import the new booking successful page
import 'booking_successful_page.dart'; // Điều chỉnh đường dẫn nếu cần

class CancelConfirmBooking extends StatelessWidget {
  const CancelConfirmBooking({Key? key}) : super(key: key);

  void _showCancelBookingSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext bc) {
        return CancelBookingBottomSheet(
          onConfirmCancel: () {
            print("User confirmed cancellation!");
            Navigator.pop(bc); // Close bottom sheet
            Navigator.pushNamedAndRemoveUntil(context, '/main', (Route<dynamic> route) => false);
          },
          onKeepBooking: () {
            print("User chose not to cancel.");
            Navigator.pop(context); // Close bottom sheet
          },
        );
      },
    );
  }

  Widget _buildDetailRow(BuildContext context, String label, String value) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey[400])),
          Text(value, style: theme.textTheme.bodyMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Dữ liệu mẫu cho bookingId và bookingTime để truyền đi
    // Trong ứng dụng thực tế, bạn sẽ lấy dữ liệu này từ state hoặc model
    final String currentBookingId = "78889377726"; // Lấy từ _buildDetailRow
    DateTime specificDate = DateTime(2025, 5, 31);

    final String currentBookingTime = "08:00 - 08:30, ${DateFormat('MMM dd, yyyy').format(specificDate)}";


    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: const Color(0xFF1C1C2A),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
          onPressed: () {
            if (Navigator.canPop(context)) Navigator.pop(context);
          },
        ),
        title: const Text(
          'Booking',
          style: TextStyle(
            color: Color(0xFFEFF8E3),
            fontSize: 20,
            fontWeight: FontWeight.w500,
            fontFamily: 'Poppins',
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.white, size: 24),
            onPressed: () { /* Xử lý mở menu */},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text(
                'Charging Station',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Poppins',
                ),
              ),
              const SizedBox(height: 10),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 7),
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF1A1A26),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/cars.png', // Đảm bảo đường dẫn này đúng
                      width: 42,
                      height: 42,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) => const Icon(Icons.directions_car, color: Colors.white54, size: 42), // Fallback icon
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Cash payment', // Dữ liệu mẫu
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Trạm Sạc Vinfast2', // Dữ liệu mẫu
                            style: TextStyle(
                              color: Color(0xFFF2F2F2),
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            '45 Tan Lap, Tp Di An, Binh Duong', // Dữ liệu mẫu
                            style: TextStyle(
                              color: Color(0xFFBFBFBF),
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              const Text(
                'Charger',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Poppins',
                ),
              ),
              const SizedBox(height: 10),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 7),
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF1A1A26),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'DC post', // Dữ liệu mẫu
                          style: TextStyle(
                            color: Color(0xFFF2F2F2),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        const SizedBox(height: 8),
                        Image.asset(
                          'assets/images/cars.png', // Đảm bảo đường dẫn này đúng
                          width: 35,
                          height: 35,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) => const Icon(Icons.ev_station, color: Colors.white54, size: 35), // Fallback icon
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: 1.5,
                          height: 50,
                          color: const Color(0xFF4A4A58),
                        ),
                        const SizedBox(width: 17),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Max. Power', // Dữ liệu mẫu
                              style: TextStyle(
                                color: Color(0xFFF2F2F2),
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Poppins',
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              '30 kW', // Dữ liệu mẫu
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Image.asset(
                      'assets/images/cars.png', // Đảm bảo đường dẫn này đúng
                      width: 24,
                      height: 24,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) => const Icon(Icons.info_outline, color: Colors.white54, size: 24), // Fallback icon
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Booking detail',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Poppins',
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 7.0),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF1A1A26),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    _buildDetailRow(context, 'Booking ID', currentBookingId), // Sử dụng biến
                    _buildDetailRow(context, 'Customer', 'Pham Huu Huy'),
                    _buildDetailRow(context, 'Booking Time', '08:00 - 08:30'), // Dữ liệu mẫu, có thể thay bằng biến
                    _buildDetailRow(context, 'Charging Station Location', 'SG2-017'),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30.0),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          _showCancelBookingSheet(context);
                          print("Cancel button (triggering sheet) pressed");
                        },
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          side: BorderSide(color: theme.colorScheme.primary, width: 1.5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            fontSize: 16,
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          print("Booking button pressed - navigating to success page.");
                          // TODO: Add actual booking logic here (e.g., API call)
                          // Sau khi logic đặt chỗ thành công:
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BookingSuccessfulPage(
                                bookingId: currentBookingId, // Truyền bookingId thực tế
                                bookingTime: currentBookingTime, // Truyền thời gian đặt chỗ thực tế
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.colorScheme.primary,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        child: const Text(
                          'Booking',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
