import 'package:flutter/material.dart';
import 'package:frontend/booking_page2.dart';

// Model đơn giản cho một tùy chọn sạc
class ChargerOption {
  final String id;
  final String typeName; // Ví dụ: "DC post"
  final String powerLabel; // Ví dụ: "Max. Power"
  final String powerValue; // Ví dụ: "30 kW", "60 kW"
  final IconData icon; // Icon cho loại sạc

  ChargerOption({
    required this.id,
    required this.typeName,
    required this.powerLabel,
    required this.powerValue,
    required this.icon,
  });
}

class SelectChargerPage extends StatefulWidget {
  const SelectChargerPage({Key? key}) : super(key: key);

  @override
  _SelectChargerPageState createState() => _SelectChargerPageState();
}

class _SelectChargerPageState extends State<SelectChargerPage> {
  // Danh sách các tùy chọn sạc - bạn nên thay thế bằng dữ liệu thực tế
  final List<ChargerOption> _chargerOptions = [
    ChargerOption(id: "dc30", typeName: "DC post", powerLabel: "Max. Power", powerValue: "30 kW", icon: Icons.ev_station),
    ChargerOption(id: "dc60", typeName: "DC post", powerLabel: "Max. Power", powerValue: "60 kW", icon: Icons.ev_station),
    ChargerOption(id: "dc150", typeName: "DC post", powerLabel: "Max. Power", powerValue: "150 kW", icon: Icons.ev_station),
    ChargerOption(id: "dc180", typeName: "DC post", powerLabel: "Max. Power", powerValue: "180 kW", icon: Icons.ev_station),
    ChargerOption(id: "ac7", typeName: "AC post", powerLabel: "Max. Power", powerValue: "7 kW", icon: Icons.power_outlined),
  ];

  ChargerOption? _selectedCharger;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appBarTheme = theme.appBarTheme;
    final textTheme = theme.textTheme;

    // Lấy màu xanh lá chủ đạo từ theme (Colors.tealAccent đã được định nghĩa trong main.dart)
    // Hoặc bạn có thể đặt một màu xanh lá cụ thể ở đây
    final Color activeColor = theme.colorScheme.primary; // Nên là Colors.tealAccent

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: appBarTheme.iconTheme?.color ?? Colors.white),
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          },
        ),
        title: Text(
          'Select Charger',
          style: appBarTheme.titleTextStyle ?? textTheme.titleLarge?.copyWith(color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.person_outline, color: appBarTheme.actionsIconTheme?.color ?? Colors.white),
            onPressed: () {
              // Xử lý khi nhấn vào icon người dùng
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: _chargerOptions.length,
                itemBuilder: (context, index) {
                  final option = _chargerOptions[index];
                  final bool isSelected = _selectedCharger?.id == option.id;
                  return _buildChargerOptionItem(context, option, isSelected, theme, activeColor);
                },
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: activeColor, // Sử dụng màu xanh lá chủ đạo
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: _selectedCharger != null ? () {
                print("Continue with charger: ${_selectedCharger!.powerValue}");
                // if (Navigator.canPop(context)) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const BookingPage2()),
                    );



              } : null,
              child: Text(
                "Continue",
                style: textTheme.titleMedium?.copyWith(
                  color: Colors.black, // Màu chữ cho nút (thường là màu tối trên nền sáng)
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChargerOptionItem(BuildContext context, ChargerOption option, bool isSelected, ThemeData theme, Color activeColor) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCharger = option;
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: const Color(0xFF2A2A3A),
          borderRadius: BorderRadius.circular(12.0),
          border: isSelected
              ? Border.all(color: activeColor, width: 2.0) // Sửa thành activeColor (xanh lá)
              : Border.all(color: Colors.transparent, width: 2.0),
        ),
        child: Row(
          children: [
            Icon(option.icon, color: Colors.white70, size: 30),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    option.typeName,
                    style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey[400]),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    option.powerLabel,
                    style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey[500]),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  option.powerValue,
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 16),
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? activeColor : Colors.grey[600]!, // Sửa thành activeColor
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Center(
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: activeColor, // Sửa thành activeColor
                  ),
                ),
              )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
