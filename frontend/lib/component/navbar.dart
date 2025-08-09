import 'package:flutter/material.dart';

// Enum để định nghĩa các tab
enum BottomNavTab { home, station, central, history, user }

class CustomBottomNavBar extends StatelessWidget {
  final BottomNavTab currentTab;
  final ValueChanged<BottomNavTab> onTabSelected;
  // Thay thế isMaintenanceMode bằng một String để truyền giá trị của globalAppString
  final String currentUserRole;

  const CustomBottomNavBar({
    Key? key,
    required this.currentTab,
    required this.onTabSelected,
    required this.currentUserRole, // Yêu cầu truyền giá trị này
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final Color primaryColor = theme.colorScheme.primary;
    final Color navBarBackgroundColor = const Color(0xFF1A1A26);
    final Color inactiveItemColor = Colors.grey[500]!;

    // Xác định nhãn cho tab người dùng dựa trên currentUserRole
    // So sánh không phân biệt chữ hoa chữ thường
    final bool isMaintenanceUser = currentUserRole.toLowerCase() == "maintenancestaff";
    final String userTabLabel = isMaintenanceUser ? "Staff" : "User";

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      decoration: BoxDecoration(
        color: navBarBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 0,
            blurRadius: 10,
            offset: const Offset(0, -3), // Shadow hướng lên trên
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(
            context: context,
            theme: theme,
            icon: Icons.home_filled,
            label: "Home",
            tab: BottomNavTab.home,
            isSelected: currentTab == BottomNavTab.home,
            activeColor: primaryColor,
            inactiveColor: inactiveItemColor,
            onTap: () => onTabSelected(BottomNavTab.home),
          ),
          _buildNavItem(
            context: context,
            theme: theme,
            icon: Icons.ev_station_outlined,
            label: "Station",
            tab: BottomNavTab.station,
            isSelected: currentTab == BottomNavTab.station,
            activeColor: primaryColor,
            inactiveColor: inactiveItemColor,
            onTap: () => onTabSelected(BottomNavTab.station),
          ),
          InkWell(
            onTap: () => onTabSelected(BottomNavTab.central),
            customBorder: const CircleBorder(),
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                  color: primaryColor,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: primaryColor.withOpacity(0.5),
                      blurRadius: 8,
                      spreadRadius: 2,
                    )
                  ]),
              child: const Icon(Icons.location_on, color: Colors.black, size: 28),
            ),
          ),
          _buildNavItem(
            context: context,
            theme: theme,
            icon: Icons.history_outlined,
            label: "History",
            tab: BottomNavTab.history,
            isSelected: currentTab == BottomNavTab.history,
            activeColor: primaryColor,
            inactiveColor: inactiveItemColor,
            onTap: () => onTabSelected(BottomNavTab.history),
          ),
          // Mục User/Maintenance Staff có điều kiện dựa trên userTabLabel
          _buildNavItem(
            context: context,
            theme: theme,
            icon: Icons.person, // Giữ nguyên icon User
            label: userTabLabel, // Nhãn thay đổi dựa trên currentUserRole
            tab: BottomNavTab.user, // Vẫn là tab User về mặt logic
            isSelected: currentTab == BottomNavTab.user,
            activeColor: primaryColor,
            inactiveColor: inactiveItemColor,
            onTap: () => onTabSelected(BottomNavTab.user),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required BuildContext context,
    required ThemeData theme,
    required IconData icon,
    required String label,
    required BottomNavTab tab,
    required bool isSelected,
    required Color activeColor,
    required Color inactiveColor,
    required VoidCallback onTap,
  }) {
    final Color itemColor = isSelected ? activeColor : inactiveColor;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: itemColor, size: 26),
            const SizedBox(height: 3),
            Text(
              label,
              style: theme.textTheme.bodySmall?.copyWith(
                color: itemColor,
                fontSize: 10,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
