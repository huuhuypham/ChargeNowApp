import 'package:flutter/material.dart';
import 'package:frontend/chargeoption.dart';
import 'package:frontend/search_brand2.dart';
import 'package:frontend/staton_detail.dart';

// --- PHẦN GIẢ ĐỊNH CHO AppColors và AppTextStyles ---
// (Trong dự án thực tế, bạn nên đặt chúng vào theme/colors.dart và theme/text_styles.dart và import vào)
class AppColors {
  static const Color primaryBackground = Color(0xFF0D0D1A); // Ví dụ màu nền chính
  static const Color searchBackground = Color(0xFF1F1F30); // Ví dụ màu nền ô tìm kiếm
  static const Color accentGreen = Color(0xFF03DABB);     // Ví dụ màu xanh lá cây nhấn
}

class AppTextStyles {
  static const TextStyle headerTitle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.white,
    fontFamily: 'Poppins', // Giả sử bạn dùng font Poppins
  );
  static TextStyle searchText = TextStyle(
    fontSize: 14,
    color: Colors.grey[400],
    fontFamily: 'Poppins',
  );
  static const TextStyle tagText = TextStyle(
    fontSize: 12,
    color: Colors.white,
    fontFamily: 'Poppins',
  );
  static const TextStyle stationTitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.white,
    fontFamily: 'Poppins',
  );
  static TextStyle stationDetails = TextStyle(
    fontSize: 13,
    color: Colors.grey[400],
    height: 1.4,
    fontFamily: 'Poppins',
  );
  static const TextStyle buttonText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    fontFamily: 'Poppins',
  );
}
// --- KẾT THÚC PHẦN GIẢ ĐỊNH ---

class MappingPage extends StatefulWidget {
  const MappingPage({Key? key}) : super(key: key);

  @override
  _MappingPageState createState() => _MappingPageState();
}

class _MappingPageState extends State<MappingPage> {
  // Biến trạng thái để lưu đường dẫn ảnh bản đồ hiện tại
  String _currentMapImagePath = 'assets/images/map2.png'; // Ảnh bản đồ mặc định
  // Đường dẫn đến ảnh bản đồ thay thế (BẠN CẦN CÓ ẢNH NÀY TRONG ASSETS)
  final String _alternativeMapImagePath = 'assets/images/map2.png'; // TÊN FILE VÍ DỤ

  // Hàm để thay đổi ảnh bản đồ
  void _toggleMapImage() {
    setState(() {
      if (_currentMapImagePath == 'assets/images/map2.png') {
        _currentMapImagePath = 'assets/images/map.png';
      } else {
        _currentMapImagePath = 'assets/images/map2.png';
      }
    });
    print("Map image toggled to: $_currentMapImagePath"); // Để debug
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      appBar: AppBar(
        backgroundColor: AppColors.primaryBackground,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Map",
          style: AppTextStyles.headerTitle,
        ),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _buildCustomHeader(context),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildMapSection(context),
                    _buildStationDetailSheet(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      color: AppColors.primaryBackground,
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
            onPressed: () {
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              }
              print("Back button pressed");
            },
          ),
          Expanded(
            // --- BẮT ĐẦU THAY ĐỔI: Thêm GestureDetector cho ô tìm kiếm ---
            child: GestureDetector(
              onTap: () {
                print("Search Station area tapped");
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SelectStationPage()),
                );
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 8.0),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: AppColors.searchBackground,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Row(
                  children: [
                    Icon(Icons.search, color: AppTextStyles.searchText.color?.withOpacity(0.7) ?? Colors.grey[400], size: 20),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Search Station',
                        style: AppTextStyles.searchText.copyWith(fontSize: 14),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // --- KẾT THÚC THAY ĐỔI ---
          ),
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.white, size: 24),
            onPressed: () {
              final ScaffoldState? scaffoldState = Scaffold.maybeOf(context);
              if (scaffoldState != null && scaffoldState.hasEndDrawer) {
                scaffoldState.openEndDrawer();
              } else {
                print("Menu button pressed - No End Drawer found or not applicable for this context.");
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMapSection(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double mapHeight = screenHeight * 0.42; // 42% chiều cao màn hình

    return Container(
        height: mapHeight,
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: Colors.grey[850], // Màu nền placeholder cho bản đồ
          borderRadius: BorderRadius.circular(16),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: Image.asset(
            _currentMapImagePath, // Sử dụng đường dẫn ảnh từ state
            key: ValueKey(_currentMapImagePath), // Quan trọng: Giúp Flutter rebuild Image khi path thay đổi
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
            errorBuilder: (context, error, stackTrace) => const Center(
                child: Text("Map placeholder",
                    style: TextStyle(color: Colors.white54))),
          ),
        ));
  }

  Widget _buildStationDetailSheet(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
          color: const Color(0xFF1A1A26),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 0,
              blurRadius: 10,
              offset: const Offset(0, -3),
            )
          ]),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStatusTags(context),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _buildStationInfo(context),
              ),
              const SizedBox(width: 16),
              _buildStationImageAndAvailability(context), // Ảnh xe sẽ có GestureDetector ở đây
            ],
          ),
          const SizedBox(height: 20),
          _buildActionButtons(context),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildStatusTags(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 6.0,
      children: [
        _buildTag('Open', backgroundColor: AppColors.accentGreen.withOpacity(0.8), textColor: Colors.black, fontWeight: FontWeight.bold),
        _buildTag('№ 3', borderColor: Colors.white54),
        _buildTagWithIcon(Icons.location_on_outlined, '800m', borderColor: Colors.white54),
      ],
    );
  }

  Widget _buildTag(String text, {Color? backgroundColor, Color? borderColor, Color? textColor, FontWeight? fontWeight}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor ?? const Color(0xFF2C2C3E),
        borderRadius: BorderRadius.circular(20),
        border: borderColor != null ? Border.all(color: borderColor, width: 0.8) : null,
      ),
      child: Text(
        text,
        style: AppTextStyles.tagText.copyWith(
          color: textColor ?? Colors.white,
          fontWeight: fontWeight ?? FontWeight.normal,
        ),
      ),
    );
  }

  Widget _buildTagWithIcon(IconData icon, String text, {Color? backgroundColor, Color? borderColor, Color? textColor, FontWeight? fontWeight}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor ?? const Color(0xFF2C2C3E),
        borderRadius: BorderRadius.circular(20),
        border: borderColor != null ? Border.all(color: borderColor, width: 0.8) : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: textColor ?? Colors.white70, size: 14),
          const SizedBox(width: 6),
          Text(
            text,
            style: AppTextStyles.tagText.copyWith(
              color: textColor ?? Colors.white,
              fontWeight: fontWeight ?? FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStationInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Trạm sạc Vinfast 2',
          style: AppTextStyles.stationTitle,
        ),
        const SizedBox(height: 6),
        Text(
          '5.0\$ / hour, Mon - Sat, 08:00 - 23:00',
          style: AppTextStyles.stationDetails,
        ),
      ],
    );
  }

  // Đảm bảo _toggleMapImage và AppColors đã được định nghĩa trong _MappingPageState
  // Giả định các phương thức khác và state (_toggleMapImage, AppColors, AppTextStyles) vẫn giữ nguyên

  Widget _buildStationDetailSheet2(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
          color: const Color(0xFF1A1A26),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 0,
              blurRadius: 10,
              offset: const Offset(0, -3),
            )
          ]),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStatusTags(context),
          const SizedBox(height: 16), // Khoảng cách giữa tags và dòng thông tin
          Row(
            crossAxisAlignment: CrossAxisAlignment.start, // Quan trọng: căn chỉnh các con theo đầu dòng
            children: [
              Expanded(
                child: _buildStationInfo(context),
              ),
              const SizedBox(width: 16), // Khoảng cách giữa cụm thông tin và cụm ảnh/availability

              // --- BẮT ĐẦU THAY ĐỔI ---
              // Sử dụng Transform.translate để đẩy widget này lên một chút
              Transform.translate(
                offset: const Offset(0, -8.0), // Đẩy lên 8 logical pixels
                // Bạn có thể điều chỉnh giá trị -8.0 này
                // (ví dụ: -5.0, -10.0) để có vị trí mong muốn.
                child: _buildStationImageAndAvailability(context),
              ),
              // --- KẾT THÚC THAY ĐỔI ---
            ],
          ),
          const SizedBox(height: 20), // Khoảng cách dưới dòng thông tin
          _buildActionButtons(context),
          const SizedBox(height: 10), // Padding dưới cùng của sheet
        ],
      ),
    );
  }

  // Các phương thức _buildStatusTags, _buildStationInfo,
  // _buildStationImageAndAvailability, _buildActionButtons, v.v...
  // giữ nguyên nội dung của chúng, chỉ có vị trí của _buildStationImageAndAvailability
  // trong _buildStationDetailSheet là được bọc bởi Transform.translate.
  Widget _buildStationImageAndAvailability(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector( // GestureDetector vẫn giữ nguyên để xử lý việc nhấn
          onTap: _toggleMapImage, // Gọi hàm thay đổi ảnh bản đồ chính khi nhấn
          child: CircleAvatar( // THAY THẾ Image.asset bằng CircleAvatar
            radius: 30, // Bán kính của vòng tròn, bạn có thể điều chỉnh (đường kính sẽ là 60)
            backgroundColor: AppColors.accentGreen.withOpacity(0.25), // Màu nền cho vòng tròn, độ mờ tùy chỉnh
            child: Icon(
              Icons.navigation, // Icon mũi tên điều hướng
              // Bạn có thể thử Icons.near_me hoặc các icon tương tự khác
              color: AppColors.accentGreen, // Màu của icon
              size: 30, // Kích thước của icon, điều chỉnh cho phù hợp với radius
            ),
          ),
        ),
        const SizedBox(height: 8), // Khoảng cách giữa icon và dòng chữ "6 charge left"
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '6 charge left',
              style: TextStyle(
                color: AppColors.accentGreen,
                fontSize: 13,
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins', // Giả sử bạn dùng font Poppins
              ),
            ),
            const SizedBox(width: 4),
            Icon(Icons.arrow_forward_ios, color: AppColors.accentGreen, size: 12),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _buildButton('View', true, context)),
        const SizedBox(width: 12),
        Expanded(child: _buildButton('Book', false, context)),
      ],
    );
  }

  Widget _buildButton(String text, bool isOutlined, BuildContext context) {
    return ElevatedButton(
      // --- BẮT ĐẦU THAY ĐỔI: Thêm điều hướng cho nút ---
      onPressed: () {
        print("$text button pressed");
        if (text == "View") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  StationDetailPage()),
          );
        } else if (text == "Book") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SelectChargerPage()), // Sử dụng tên trang booking mới
          );
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: isOutlined ? Colors.transparent : AppColors.accentGreen,
        foregroundColor: isOutlined ? AppColors.accentGreen : Colors.black,
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
          side: isOutlined ? BorderSide(color: AppColors.accentGreen, width: 1.5) : BorderSide.none,
        ),
        elevation: isOutlined ? 0 : 2,
      ),
      child: Text(
        text,
        style: AppTextStyles.buttonText.copyWith(
          color: isOutlined ? AppColors.accentGreen : Colors.black,
        ),
      ),
    );
  }
}