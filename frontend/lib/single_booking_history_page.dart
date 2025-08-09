// single_booking_history_page.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For date formatting
import 'booking_detail_model.dart'; // Import model vừa tạo

class SingleBookingHistoryPage extends StatelessWidget {
  final BookingDetail bookingDetail;

  const SingleBookingHistoryPage({Key? key, required this.bookingDetail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final Color cardBackgroundColor = const Color(0xFF1A1A26); // Màu nền card tối
    final Color subtleTextColor = Colors.grey[400]!;        // Màu chữ phụ, hơi xám
    final Color primaryTextColor = Colors.white;             // Màu chữ chính
    final Color accentColor = theme.colorScheme.primary;     // Màu nhấn (TealAccent từ theme)

    return Scaffold(
      backgroundColor: Colors.black, // Màu nền chính của trang
      appBar: AppBar(
        backgroundColor: const Color(0xFF1C1C2A), // Màu nền AppBar
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context); // Quay lại trang trước nếu có thể
            }
          },
        ),
        title: const Text(
          'Booking Details', // Tiêu đề trang
          style: TextStyle(
            color: Color(0xFFEFF8E3), // Màu chữ tiêu đề
            fontSize: 20,
            fontWeight: FontWeight.w500,
            fontFamily: 'Poppins', // Đảm bảo font này đã được thêm vào dự án
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0), // Padding chung cho nội dung
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Card thông tin trạm và đặt chỗ cơ bản
            _buildInfoCard(
                context: context,
                backgroundColor: cardBackgroundColor,
                children: [
                  _buildHeaderRow(
                      theme: theme,
                      stationName: bookingDetail.stationName,
                      stationCode: bookingDetail.stationCode,
                      price: bookingDetail.price,
                      primaryTextColor: primaryTextColor,
                      accentColor: accentColor
                  ),
                  const SizedBox(height: 12),
                  _buildDetailItem(
                      icon: Icons.calendar_today_outlined,
                      label: DateFormat('dd/MM/yyyy').format(bookingDetail.bookingDate), // Định dạng ngày
                      value: bookingDetail.bookingTimeSlot,
                      theme: theme,
                      subtleTextColor: subtleTextColor,
                      primaryTextColor: primaryTextColor
                  ),
                  const SizedBox(height: 8),
                  _buildDetailItem(
                      icon: Icons.timer_outlined,
                      label: bookingDetail.duration,
                      value: bookingDetail.durationContext ?? '', // Hiển thị context nếu có
                      theme: theme,
                      subtleTextColor: subtleTextColor,
                      primaryTextColor: primaryTextColor
                  ),
                  if (bookingDetail.stationAddress != null && bookingDetail.stationAddress!.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    _buildDetailItem(
                      icon: Icons.location_on_outlined,
                      label: bookingDetail.stationAddress!,
                      theme: theme,
                      subtleTextColor: subtleTextColor,
                      primaryTextColor: primaryTextColor,
                      isSingleLine: true, // Địa chỉ thường dài, hiển thị một dòng
                    ),
                  ],
                ]
            ),
            const SizedBox(height: 20),

            // Card thông tin chi tiết về cổng sạc
            Text(
              'Charger Details',
              style: theme.textTheme.titleLarge?.copyWith(color: primaryTextColor, fontWeight: FontWeight.bold, fontFamily: 'Poppins'),
            ),
            const SizedBox(height: 10),
            _buildInfoCard(
                context: context,
                backgroundColor: cardBackgroundColor,
                children: [
                  _buildChargerDetailRow(
                      theme: theme,
                      chargerType: bookingDetail.chargerType,
                      maxPower: bookingDetail.maxPower,
                      primaryTextColor: primaryTextColor,
                      subtleTextColor: subtleTextColor,
                      // Cung cấp đường dẫn ảnh mặc định nếu carImageAsset là null
                      assetPath: bookingDetail.carImageAsset ?? 'assets/images/default_charger_icon.png'
                  ),
                ]
            ),

            // Card thông tin bổ sung (khách hàng, thanh toán)
            if (bookingDetail.customerName != null || bookingDetail.paymentMethod != null) ...[
              const SizedBox(height: 20),
              Text(
                'Additional Info',
                style: theme.textTheme.titleLarge?.copyWith(color: primaryTextColor, fontWeight: FontWeight.bold, fontFamily: 'Poppins'),
              ),
              const SizedBox(height: 10),
              _buildInfoCard(
                  context: context,
                  backgroundColor: cardBackgroundColor,
                  children: [
                    if (bookingDetail.customerName != null && bookingDetail.customerName!.isNotEmpty)
                      _buildSimpleDetailRow(theme, "Customer", bookingDetail.customerName!, primaryTextColor, subtleTextColor),
                    // Thêm đường kẻ nếu cả hai thông tin đều có
                    if ((bookingDetail.customerName != null && bookingDetail.customerName!.isNotEmpty) &&
                        (bookingDetail.paymentMethod != null && bookingDetail.paymentMethod!.isNotEmpty))
                      Divider(color: Colors.grey[700], height: 20, thickness: 0.5),
                    if (bookingDetail.paymentMethod != null && bookingDetail.paymentMethod!.isNotEmpty)
                      _buildSimpleDetailRow(theme, "Payment", bookingDetail.paymentMethod!, primaryTextColor, subtleTextColor),
                  ]
              ),
            ],

            const SizedBox(height: 30),
            // Nút hành động
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: accentColor,
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'Poppins'),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                onPressed: () {
                  // Điều hướng về trang chính hoặc trang lịch sử danh sách
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  } else {
                    // Nếu không thể pop, có thể điều hướng đến một trang mặc định như '/main'
                    Navigator.pushNamedAndRemoveUntil(context, '/main', (route) => false);
                  }
                },
                child: const Text('Done', style: TextStyle(color: Colors.black)),
              ),
            ),
            const SizedBox(height: 20), // Thêm khoảng đệm dưới cùng
          ],
        ),
      ),
    );
  }

  // Helper widget để tạo một card thông tin chung
  Widget _buildInfoCard({
    required BuildContext context,
    required Color backgroundColor,
    required List<Widget> children
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12.0), // Bo góc cho card
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }

  // Helper widget cho hàng tiêu đề của card (Tên trạm, mã trạm, giá)
  Widget _buildHeaderRow({
    required ThemeData theme,
    required String stationName,
    required String stationCode,
    required String price,
    required Color primaryTextColor,
    required Color accentColor
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start, // Căn chỉnh theo chiều dọc
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                stationName,
                style: theme.textTheme.titleLarge?.copyWith(color: primaryTextColor, fontWeight: FontWeight.bold, fontFamily: 'Poppins'),
                overflow: TextOverflow.ellipsis, // Chống tràn chữ
              ),
              const SizedBox(height: 4),
              Text(
                stationCode,
                style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey[500], fontFamily: 'Poppins'),
              ),
            ],
          ),
        ),
        const SizedBox(width: 10), // Khoảng cách giữa tên trạm và giá
        Text(
          price,
          style: theme.textTheme.titleLarge?.copyWith(color: accentColor, fontWeight: FontWeight.bold, fontFamily: 'Poppins'),
        ),
      ],
    );
  }

  // Helper widget cho một mục chi tiết có icon (Ngày, giờ, địa điểm,...)
  Widget _buildDetailItem({
    required IconData icon,
    required String label,
    String? value, // Value có thể là null hoặc rỗng
    required ThemeData theme,
    required Color subtleTextColor,
    required Color primaryTextColor,
    bool isSingleLine = false, // Nếu true, chỉ hiển thị label (cho địa chỉ dài)
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start, // Căn icon và text theo đầu dòng
      children: [
        Icon(icon, color: subtleTextColor, size: 18),
        const SizedBox(width: 10),
        Expanded(
          child: isSingleLine || value == null || value.isEmpty
              ? Text( // Chỉ hiển thị label nếu là isSingleLine hoặc value không có
            label,
            style: theme.textTheme.bodyMedium?.copyWith(color: primaryTextColor, fontFamily: 'Poppins', height: 1.4),
          )
              : RichText( // Sử dụng RichText để style khác nhau cho label và value
            text: TextSpan(
              // Style mặc định cho cả đoạn
              style: theme.textTheme.bodyMedium?.copyWith(color: primaryTextColor, fontFamily: 'Poppins', height: 1.4),
              children: [
                TextSpan(text: '$label '), // Phần label
                TextSpan(
                  text: value, // Phần value
                  style: const TextStyle(fontWeight: FontWeight.w500), // Value có thể đậm hơn
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Helper widget cho hàng chi tiết cổng sạc
  Widget _buildChargerDetailRow({
    required ThemeData theme,
    required String chargerType,
    required String maxPower,
    required Color primaryTextColor,
    required Color subtleTextColor,
    required String assetPath, // Đường dẫn ảnh cho loại sạc
  }) {
    return Row(
      children: [
        Image.asset(
          assetPath,
          width: 40,
          height: 40,
          fit: BoxFit.contain,
          // Cung cấp fallback nếu ảnh không tải được
          errorBuilder: (context, error, stackTrace) => Icon(Icons.ev_station, size: 40, color: subtleTextColor),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(chargerType, style: theme.textTheme.titleMedium?.copyWith(color: primaryTextColor, fontWeight: FontWeight.bold, fontFamily: 'Poppins')),
              const SizedBox(height: 2),
              Text("Max. Power", style: theme.textTheme.bodySmall?.copyWith(color: subtleTextColor, fontFamily: 'Poppins')),
            ],
          ),
        ),
        Text(maxPower, style: theme.textTheme.titleMedium?.copyWith(color: primaryTextColor, fontWeight: FontWeight.bold, fontFamily: 'Poppins')),
      ],
    );
  }

  // Helper widget cho hàng chi tiết đơn giản (Label: Value)
  Widget _buildSimpleDetailRow(ThemeData theme, String label, String value, Color primaryTextColor, Color subtleTextColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0), // Padding cho mỗi hàng
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: theme.textTheme.bodyMedium?.copyWith(color: subtleTextColor, fontFamily: 'Poppins')),
          Text(value, style: theme.textTheme.bodyLarge?.copyWith(color: primaryTextColor, fontWeight: FontWeight.w500, fontFamily: 'Poppins')),
        ],
      ),
    );
  }
}
