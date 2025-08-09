import 'package:flutter/material.dart';
import 'start.dart';
import 'login.dart';
import 'signup.dart';
import 'cancel_confirm.dart';
import 'booking_page2.dart';
import 'search_brand2.dart';
import 'chargeoption.dart';
import 'profile_page.dart'; // Hoặc đường dẫn đúng// Đảm bảo tên file import này chính xác với tên file bạn đã lưu
import 'staton_detail.dart'; // Hoặc 'station_detail.dart' nếu tên file là vậy
import 'main_scaffold_page.dart';
import 'history_page.dart';
String globalAppString = "Tendangnhap";

void main() {
  runApp(ChargeNowApp());
}

class ChargeNowApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ChargeNow',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        colorScheme: ColorScheme.dark(
          primary: Colors.tealAccent,
        ),
        textTheme: ThemeData.dark().textTheme.apply(
          fontFamily: 'Roboto',
          bodyColor: Colors.white,
          displayColor: Colors.white,
        ),
      ),
      initialRoute: '/login',
      routes: {
        '/main': (context) => MainScaffoldPage(),
        // Route hiện tại của bạn
        // '/': (context) => ProfilePage(), // Đang đặt ProfilePage làm trang chủ
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignUpPage(),
        '/cancel_booking': (context) => CancelConfirmBooking(), // Đổi tên route cho rõ ràng hơn

        // Thêm các route mới từ các file đã import
        '/start': (context) => StartPage(), // Giả sử StartPage là tên class trong start.dart
        '/booking': (context) => BookingPage2(), // Giả sử BookingPage2 là tên class trong booking_page2.dart
        '/SearchStation': (context) => SelectStationPage(), // Giả sử SearchBrand2Page là tên class trong search_brand2.dart
        '/select_charger': (context) => SelectChargerPage(), // Giả sử SelectChargerPage là tên class trong chargeoption.dart
        '/profile': (context) => ProfilePage(), // Route đến trang Profile (nếu cần truy cập từ nơi khác)

        // Route cho trang chi tiết trạm sạc
        // Sẽ hiển thị với dữ liệu mẫu khi được gọi trực tiếp qua route này
        // Khi điều hướng từ nơi khác với dữ liệu cụ thể, bạn sẽ dùng Navigator.push với arguments
        '/station_detail': (context) {
          // Đảm bảo hàm getSampleStation() là static và được định nghĩa trong StationDetailPage
          // và file staton_detail.dart (hoặc station_detail.dart) đã import model ChargingStationDetail
          try {
            final sampleStationData = StationDetailPage.getSampleStation();
            return StationDetailPage();
          } catch (e) {
            // Xử lý trường hợp không lấy được dữ liệu mẫu (ví dụ: hiển thị trang lỗi hoặc thông báo)
            print("Lỗi khi lấy dữ liệu mẫu cho StationDetailPage: $e");
            return Scaffold(
              appBar: AppBar(title: Text("Lỗi")),
              body: Center(child: Text("Không thể tải dữ liệu chi tiết trạm.")),
            );
          }
        },
      },
      // Bạn có thể thêm onGenerateRoute để xử lý các route động hoặc truyền tham số phức tạp hơn
      // onGenerateRoute: (settings) {
      //   if (settings.name == '/station_detail_with_arg') {
      //     final args = settings.arguments as ChargingStationDetail; // Ví dụ
      //     return MaterialPageRoute(
      //       builder: (context) {
      //         return StationDetailPage(station: args);
      //       },
      //     );
      //   }
      //   // Xử lý các route khác nếu cần
      //   return null; // Quan trọng: trả về null nếu không xử lý route này
      // },
    );
  }
}
