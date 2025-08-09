// lib/main_scaffold_page.dart
import 'package:flutter/material.dart';

// Khôi phục các import gốc từ code bạn cung cấp
import 'package:frontend/mapping.dart';            // Trang cho MappingPage (Home mặc định)
import 'package:frontend/search_brand2.dart';     // Trang cho SelectStationPage (Station)
import 'package:frontend/staff_list.dart';         // Trang cho StaffTaskListPage (Home cho maintenance)
import 'package:frontend/chargeoption.dart';       // Trang cho ChargeOptionPage (Central)
import 'package:frontend/history_page.dart';       // Trang cho HistoryPage (History)
import 'package:frontend/profile_page.dart';       // Trang cho ProfilePage (User)

// Các import không dùng trực tiếp trong _pages nhưng có thể cần thiết cho project
import 'package:frontend/booking_page2.dart';
import 'package:frontend/cancel_confirm.dart';

// Component navbar
import 'component/navbar.dart'; // Đường dẫn đến CustomBottomNavBar của bạn

// Import tệp main.dart để truy cập globalAppString
import 'package:frontend/main.dart'; // Thay 'frontend' bằng tên package thực tế của bạn nếu cần.

class MainScaffoldPage extends StatefulWidget {
  const MainScaffoldPage({Key? key}) : super(key: key);

  @override
  _MainScaffoldPageState createState() => _MainScaffoldPageState();
}

class _MainScaffoldPageState extends State<MainScaffoldPage> {
  BottomNavTab _currentTab = BottomNavTab.home; // Tab mặc định khi mở ứng dụng

  // Ánh xạ từ BottomNavTab enum sang index của List _pages
  // Thứ tự này phải khớp với thứ tự các trang trong danh sách _pages được tạo trong hàm build
  int _getPageIndex(BottomNavTab tab) {
    switch (tab) {
      case BottomNavTab.home:
        return 0;
      case BottomNavTab.station:
        return 1;
      case BottomNavTab.central:
        return 2;
      case BottomNavTab.history:
        return 3;
      case BottomNavTab.user:
        return 4;
      default:
        return 0; // Mặc định về home
    }
  }


  void _onTabSelected(BottomNavTab tab) {
    if (_currentTab == tab && tab != BottomNavTab.central) {
      return;
    }

    setState(() {
      _currentTab = tab;
    });

    if (tab == BottomNavTab.central) {
      print("Central button tapped - handled by MainScaffoldPage state change. Current index: ${_getPageIndex(tab)}");
    } else {
      print("Switched to tab: $tab, Page index: ${_getPageIndex(tab)}");
    }
  }

  @override
  Widget build(BuildContext context) {
    final String userRole = globalAppString;
    print("Current User Role for NavBar in MainScaffoldPage: $userRole");

    // Khởi tạo danh sách các trang dựa trên userRole
    final List<Widget> pages = [
      // Index 0: BottomNavTab.home - Trang này sẽ thay đổi dựa trên userRole
      userRole.toLowerCase() == "maintenancestaff"
          ? const StaffTaskListPage()   // Nếu là nhân viên bảo trì, trang Home là danh sách công việc (từ staff_list.dart)
          : const MappingPage(),        // Nếu là người dùng thông thường, trang Home là bản đồ (từ mapping.dart)

      // Index 1: BottomNavTab.station - Giữ nguyên là SelectStationPage
      const SelectStationPage(),      // (từ search_brand2.dart)

      // Index 2: BottomNavTab.central - Giữ nguyên là ChargeOptionPage
      const SelectStationPage(),       // (từ chargeoption.dart)

      // Index 3: BottomNavTab.history - Giữ nguyên là HistoryPage
      const HistoryPage(),            // (từ history_page.dart)

      // Index 4: BottomNavTab.user - Giữ nguyên là ProfilePage
      const ProfilePage(),            // (từ profile_page.dart)
    ];

    return Scaffold(
      body: IndexedStack(
        index: _getPageIndex(_currentTab),
        children: pages, // Sử dụng danh sách pages đã được khởi tạo động
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentTab: _currentTab,
        onTabSelected: _onTabSelected,
        currentUserRole: userRole,
      ),
    );
  }
}
