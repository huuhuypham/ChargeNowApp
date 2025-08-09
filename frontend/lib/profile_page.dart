import 'package:flutter/material.dart';
// Đảm bảo bạn đã import LoginPage.
// Giả sử LoginPage nằm trong cùng thư mục hoặc bạn có đường dẫn đúng.
import 'login.dart'; // Thêm import này

// Import các file cần thiết cho trang chi tiết đặt chỗ
import 'single_booking_history_page.dart'; // Đường dẫn đến trang chi tiết
import 'booking_detail_model.dart';    // Đường dẫn đến model BookingDetail
import 'package:intl/intl.dart'; // For date formatting, if needed for sample data

// Model đơn giản cho một mục tùy chọn trong danh sách
class ProfileOptionItem {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  ProfileOptionItem({
    required this.icon,
    required this.title,
    required this.onTap,
  });
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

// Dữ liệu mẫu, bạn có thể thay thế bằng dữ liệu người dùng thực tế
class _ProfilePageState extends State<ProfilePage> {
  final String userName = "Pham Huu Huy";
  final String userLevel = "Level 4 Ace Member";
  final String userAvatarUrl =
      "https://placehold.co/100x100/2E2E48/FFF?text=HH"; // URL hoặc asset path
  final int transactions = 237;
  final int points = 726;
  final int rank = 8;
  final double levelProgress = 0.65; // 65%

  // Dữ liệu mẫu cho một booking để truyền đi
  final BookingDetail sampleBooking = BookingDetail(
    bookingId: "BK-00123",
    stationName: "Trạm sạc Vinfast 2",
    stationCode: "SG2-017",
    bookingDate: DateTime(2025, 5, 31),
    bookingTimeSlot: "08:00 - 08:30",
    duration: "30 minutes",
    durationContext: "charged",
    price: "25.000 VND",
    chargerType: "AC Charger",
    maxPower: "30 kW",
    customerName: "Pham Huu Huy", // Có thể lấy từ userName
    stationAddress: "720A Điện Biên Phủ, Vinhomes Tân Cảng, Bình Thạnh",
    paymentMethod: "Visa **** 1234",
    carImageAsset: 'assets/images/default_charger_icon.png', // Cần có ảnh này trong assets
  );


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final Color primaryColor = theme.colorScheme.primary;
    final Color cardBackgroundColor = const Color(0xFF1A1A26);
    final Color subtleTextColor = Colors.grey[400]!;
    final Color iconColor = Colors.grey[300]!;

    final List<ProfileOptionItem> options = [
      ProfileOptionItem(
          icon: Icons.calendar_today_outlined,
          title: "My Booking",
          onTap: () {
            print("My Booking tapped - Navigating to SingleBookingHistoryPage");
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SingleBookingHistoryPage(bookingDetail: sampleBooking),
              ),
            );
          }),
      ProfileOptionItem(
          icon: Icons.report_problem_outlined,
          title: "Report Station Issue",
          onTap: () => print("Report Station Issue tapped")),
      ProfileOptionItem(
          icon: Icons.payment_outlined,
          title: "Payment method",
          onTap: () => print("Payment method tapped")),
      ProfileOptionItem(
          icon: Icons.language_outlined,
          title: "Change language",
          onTap: () => print("Change language tapped")),
      ProfileOptionItem(
          icon: Icons.lock_outline,
          title: "Change password",
          onTap: () => print("Change password tapped")),
      ProfileOptionItem(
          icon: Icons.description_outlined,
          title: "Terms and Conditions",
          onTap: () => print("Terms and Conditions tapped")),
    ];

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            _buildFakeStatusBar(context, theme),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    _buildUserInfoHeader(context, theme, primaryColor,
                        cardBackgroundColor, subtleTextColor),
                    const SizedBox(height: 20),
                    _buildActionButtonsRow(context, theme, primaryColor,
                        cardBackgroundColor, iconColor),
                    const SizedBox(height: 24),
                    _buildOptionsList(context, theme, options,
                        cardBackgroundColor, iconColor),
                    const SizedBox(height: 30),
                    _buildLogoutButton(context, theme, primaryColor),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFakeStatusBar(BuildContext context, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            DateFormat('HH:mm').format(DateTime.now()), // Thời gian động
            style: theme.textTheme.bodySmall?.copyWith(color: Colors.white70),
          ),
          Text(
            "Profile",
            style: theme.textTheme.titleLarge
                ?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              Icon(Icons.signal_cellular_alt,
                  color: Colors.white70, size: 18),
              const SizedBox(width: 4),
              Icon(Icons.battery_full, color: Colors.white70, size: 18),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildUserInfoHeader(BuildContext context, ThemeData theme,
      Color primaryColor, Color cardBackgroundColor, Color subtleTextColor) {
    final String displayName = userName;

    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(userAvatarUrl),
              onBackgroundImageError: (exception, stackTrace) {
                print('Error loading avatar: $exception');
              },
              backgroundColor: Colors.grey[700],
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    displayName,
                    style: theme.textTheme.headlineSmall?.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        userLevel,
                        style: theme.textTheme.bodyMedium
                            ?.copyWith(color: subtleTextColor),
                      ),
                      const SizedBox(width: 8),
                      Icon(Icons.shield_outlined,
                          color: primaryColor, size: 16),
                    ],
                  ),
                  const SizedBox(height: 6),
                  LinearProgressIndicator(
                    value: levelProgress,
                    backgroundColor: Colors.grey[700],
                    valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                    minHeight: 6,
                    borderRadius: BorderRadius.circular(3), // Bo góc cho thanh progress
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            IconButton(
              icon: Icon(Icons.close,
                  color: Colors.white54, size: 28),
              onPressed: () {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                } else {
                  print("Close icon pressed - cannot pop from ProfilePage");
                  // Có thể điều hướng về trang chủ nếu không thể pop
                  // Navigator.pushNamedAndRemoveUntil(context, '/main', (route) => false);
                }
              },
            )
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildStatItem(
                "Transactions", transactions.toString(), theme, subtleTextColor),
            _buildStatItem("Points", points.toString(), theme, subtleTextColor),
            _buildStatItem("Rank", rank.toString(), theme, subtleTextColor),
          ],
        ),
      ],
    );
  }

  Widget _buildStatItem(
      String label, String value, ThemeData theme, Color subtleTextColor) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value,
          style: theme.textTheme.titleLarge
              ?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(color: subtleTextColor),
        ),
      ],
    );
  }

  Widget _buildActionButtonsRow(BuildContext context, ThemeData theme,
      Color primaryColor, Color cardBackgroundColor, Color iconColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildActionButton(
            context,
            theme,
            "Edit Profile",
            Icons.person_outline,
                () => print("Edit Profile Tapped"),
            cardBackgroundColor,
            iconColor),
        _buildActionButton(
            context,
            theme,
            "Settings",
            Icons.settings_outlined,
                () => print("Settings Tapped"),
            cardBackgroundColor,
            iconColor),
        _buildActionButton(context, theme, "Cars Type",
            Icons.directions_car_outlined, () => print("Cars Type Tapped"),
            cardBackgroundColor, iconColor,
            showArrow: true, primaryColor: primaryColor),
      ],
    );
  }

  Widget _buildActionButton(
      BuildContext context,
      ThemeData theme,
      String label,
      IconData icon,
      VoidCallback onTap,
      Color backgroundColor,
      Color iconColor,
      {bool showArrow = false,
        Color? primaryColor}) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 4.0),
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: iconColor, size: 20),
              const SizedBox(width: 6),
              Flexible(
                child: Text(
                  label,
                  style: theme.textTheme.bodySmall?.copyWith(
                      color: Colors.white, fontWeight: FontWeight.w500),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (showArrow && primaryColor != null) ...[
                const SizedBox(width: 4),
                Icon(Icons.arrow_forward_ios, color: primaryColor, size: 14),
              ]
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOptionsList(
      BuildContext context,
      ThemeData theme,
      List<ProfileOptionItem> options,
      Color cardBackgroundColor,
      Color iconColor) {
    return Container(
      decoration: BoxDecoration(
        color: cardBackgroundColor,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: options.length,
        itemBuilder: (context, index) {
          final item = options[index];
          return ListTile(
            leading: Icon(item.icon, color: iconColor),
            title: Text(item.title,
                style: theme.textTheme.bodyLarge?.copyWith(color: Colors.white)),
            trailing:
            Icon(Icons.arrow_forward_ios, color: Colors.grey[600], size: 16),
            onTap: item.onTap, // onTap đã được cập nhật ở trên cho "My Booking"
            contentPadding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
          );
        },
        separatorBuilder: (context, index) => Divider(
          height: 1,
          color: Colors.grey[800],
          indent: 16,
          endIndent: 16,
        ),
      ),
    );
  }

  Widget _buildLogoutButton(
      BuildContext context, ThemeData theme, Color primaryColor) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: () {
          print("Log out tapped");
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
                (Route<dynamic> route) => false,
          );
        },
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 14.0),
          side: BorderSide(color: primaryColor, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
        ),
        child: Text(
          "Log out",
          style: theme.textTheme.titleMedium
              ?.copyWith(color: primaryColor, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
