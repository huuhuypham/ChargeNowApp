import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/cancel_confirm.dart';
import '../theme/date_selector_widget.dart'; // Giả sử đường dẫn này chính xác
import '../theme/time_selector_widget.dart'; // Giả sử đường dẫn này chính xác

class BookingPage2 extends StatefulWidget {
  const BookingPage2({Key? key}) : super(key: key);

  @override
  _BookingPage2State createState() => _BookingPage2State();
}

class _BookingPage2State extends State<BookingPage2> {
  DateTime selectedDate = DateTime.now().add(const Duration(days: 3));

  String selectedStartTime = "14:00";
  String selectedEndTime = "14:30";

  List<String> _timeOptions = [];
  String? _selectedDecorativeTime; // Theo dõi ô thời gian trang trí đang "sáng"

  // Màu teal đặc trưng cho trạng thái "sáng"
  static const Color _tealColor = Color(0xFF07B687);
  // Màu trắng cho trạng thái bình thường
  static const Color _normalColor = Colors.white;


  @override
  void initState() {
    super.initState();
    _generateTimeOptions();
    _selectedDecorativeTime = "06"; // Khởi tạo "06" là ô sáng mặc định

    // Đảm bảo selectedStartTime hợp lệ
    if (!_timeOptions.contains(selectedStartTime)) {
      selectedStartTime = _timeOptions.isNotEmpty ? _timeOptions.first : "07:00";
    }

    // Đảm bảo selectedEndTime hợp lệ và sau selectedStartTime
    if (!_timeOptions.contains(selectedEndTime)) {
      selectedEndTime = _timeOptions.length > 1 ? _timeOptions[1] : selectedStartTime;
    }

    DateTime sTime = _parseTime(selectedStartTime);
    DateTime eTime = _parseTime(selectedEndTime);

    // Điều chỉnh selectedEndTime nếu nó không hợp lệ
    if (eTime.isBefore(sTime) || eTime.isAtSameMomentAs(sTime)) {
      int startIndex = _timeOptions.indexOf(selectedStartTime);
      if (startIndex != -1 && startIndex < _timeOptions.length - 1) {
        selectedEndTime = _timeOptions[startIndex + 1];
      } else if (startIndex == _timeOptions.length - 1) {
        selectedEndTime = selectedStartTime;
      } else {
        selectedEndTime = _timeOptions.length > 1 ? _timeOptions[1] : selectedStartTime;
      }
    }

    // Thiết lập SystemUiOverlayStyle
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );
  }

  void _generateTimeOptions() {
    _timeOptions.clear();
    // Tạo các lựa chọn thời gian từ 07:00 đến 23:30
    for (int h = 7; h < 24; h++) {
      _timeOptions.add("${h.toString().padLeft(2, '0')}:00");
      _timeOptions.add("${h.toString().padLeft(2, '0')}:30");
    }
    // Thêm "24:00" cho nửa đêm
    _timeOptions.add("24:00");
  }

  DateTime _parseTime(String timeStr) {
    // Hàm hỗ trợ chuyển đổi chuỗi "HH:mm" thành DateTime để so sánh
    if (timeStr == "24:00") {
      return DateTime(2000, 1, 2, 0, 0); // Ngày hôm sau, 00:00
    }
    try {
      final parts = timeStr.split(':');
      if (parts.length == 2) {
        final hour = int.tryParse(parts[0]);
        final minute = int.tryParse(parts[1]);
        if (hour != null && minute != null) {
          return DateTime(2000, 1, 1, hour, minute);
        }
      }
    } catch (e) {
      print("Lỗi phân tích thời gian: $timeStr, Lỗi: $e");
      return DateTime(2000, 1, 1, 0, 0); // Giá trị dự phòng
    }
    return DateTime(2000, 1, 1, 0, 0); // Giá trị dự phòng
  }


  @override
  Widget build(BuildContext context) {
    // Đảm bảo SystemUiOverlayStyle được áp dụng
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Colors.black,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        top: true, // Giữ SafeArea ở trên cùng cho status bar
        bottom: false, // Không cần SafeArea ở dưới cùng cho thiết kế này
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFF010101), // Màu nền chính của nội dung
            borderRadius: BorderRadius.circular(30),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 0), // Bỏ margin dọc nếu status bar nằm ngoài
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // _buildStatusBar(context), // Status bar đã được xử lý bởi SafeArea và SystemChrome
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildChargeStatusHeader(), // Header đã được sửa đổi
                      _buildTimeSelectionSection(),
                      _buildDateSelector(),
                      _buildTimeSelectors(),
                      _buildContinueButton(),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Bỏ _buildStatusBar nếu bạn muốn sử dụng status bar mặc định của hệ thống
  // Widget _buildStatusBar(BuildContext context) { ... }


  // Đảm bảo rằng bạn đã định nghĩa _tealColor trong lớp _BookingPage2State, ví dụ:
  // static const Color _tealColor = Color(0xFF07B687);

  Widget _buildChargeStatusHeader() {
    // Phần đầu trang hiển thị trạng thái sạc
    return Padding(
      // Padding này áp dụng cho toàn bộ cụm header (dòng tiêu đề và dòng chỉ báo "1/2")
      // Khoảng cách ngang 16px sẽ được cung cấp bởi Container cha trong widget build()
      padding: const EdgeInsets.only(top: 25.0, bottom: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              // Nút Back
              IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
                onPressed: () {
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  } else {
                    // Xử lý trường hợp không có trang nào để pop (ví dụ: đây là trang gốc)
                    print("Cannot pop. No previous page in navigation stack.");
                  }
                },
                tooltip: MaterialLocalizations.of(context).backButtonTooltip,
              ),
              // Tiêu đề "Charge Status" được mở rộng để chiếm không gian và căn giữa
              const Expanded(
                child: Text(
                  "Charge Status",
                  textAlign: TextAlign.center, // Căn giữa chữ trong không gian Expanded
                  style: TextStyle(
                    color: Color(0xFFEFF8E3), // Màu chữ cho tiêu đề
                    fontSize: 24,             // Kích thước chữ
                    fontWeight: FontWeight.w500,
                    letterSpacing: -0.48,
                    fontFamily: 'Poppins',      // Đảm bảo font này có trong dự án
                  ),
                ),
              ),
              // Placeholder để cân bằng với IconButton, giúp tiêu đề được căn giữa chuẩn
              // Chiều rộng này nên tương đương với chiều rộng có thể nhấn của IconButton (khoảng 48.0 là giá trị phổ biến)
              const SizedBox(width: 48.0),
            ],
          ),
          const SizedBox(height: 10), // Khoảng cách giữa dòng tiêu đề và chỉ báo bước "1/2"
          const Align(
            alignment: Alignment.centerRight,
            child: Padding(
              // Padding cho chỉ báo "1/2" để nó không quá sát lề phải
              padding: EdgeInsets.only(right: 4.0), // Điều chỉnh nếu cần
              child: Text(
                "1/2", // Chỉ báo bước
                style: TextStyle(
                  color: _tealColor, // Sử dụng màu teal đã định nghĩa trong State
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- BẮT ĐẦU PHẦN CHỌN THỜI GIAN TRANG TRÍ ĐÃ SỬA ĐỔI ---

  // Hàm tạo widget cho một ô thời gian trang trí
  Widget _buildInteractiveDecorativeSlotWidget(String timeValue) {
    bool isCurrentlySelected = _selectedDecorativeTime == timeValue;

    // Kiểu chữ cơ bản cho các ô thời gian trang trí
    TextStyle textStyle = TextStyle(
      color: isCurrentlySelected ? _tealColor : _normalColor, // Màu teal nếu được chọn, ngược lại màu trắng
      fontSize: 24,
      fontWeight: FontWeight.w500,
      fontFamily: 'Poppins',
    );

    Widget content;

    // Tất cả các ô khi được chọn sẽ có BoxDecoration
    if (isCurrentlySelected) {
      content = Container(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: _tealColor, // Viền màu teal khi được chọn
            width: 2,
          ),
        ),
        child: Text(timeValue, style: textStyle), // textStyle đã xử lý màu chữ
      );
    } else {
      // Khi không được chọn, chỉ là Text đơn giản với màu chữ bình thường
      content = Text(timeValue, style: textStyle);
    }

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedDecorativeTime = timeValue;
        });
      },
      child: content,
    );
  }


  Widget _buildTimeSelectionSection() {
    // Widget ảnh xe chung
    Widget carImage = Image.asset(
      'assets/images/cars.png', // TODO: Thay thế bằng đường dẫn ảnh thực tế
      width: 120,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) => const Icon(Icons.directions_car_filled_outlined, color: Colors.white24, size: 50),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
      child: Column(
        children: [
          _buildVisualRowEntry(
            leftContent: _buildInteractiveDecorativeSlotWidget("03"),
            rightContent: carImage,
          ),
          const SizedBox(height: 15),
          _buildVisualRowEntry(
            leftContent: carImage,
            rightContent: _buildInteractiveDecorativeSlotWidget("06"),
          ),
          const SizedBox(height: 15),
          _buildDivider(),
          const SizedBox(height: 15),
          _buildVisualRowEntry(
            leftContent: _buildInteractiveDecorativeSlotWidget("10"),
            rightContent: carImage,
          ),
          const SizedBox(height: 15),
          _buildVisualRowEntry(
            leftContent: _buildInteractiveDecorativeSlotWidget("13"),
            rightContent: carImage,
          ),
          const SizedBox(height: 15),
          _buildDivider(),
          const SizedBox(height: 15),
          _buildVisualRowEntry(
            leftContent: _buildInteractiveDecorativeSlotWidget("16"),
            rightContent: _buildInteractiveDecorativeSlotWidget("17"),
          ),
        ],
      ),
    );
  }

  // Hàm hỗ trợ tạo mỗi hàng trong phần trang trí
  Widget _buildVisualRowEntry({Widget? leftContent, Widget? rightContent}) {
    return IntrinsicHeight(
      child: Row(
        children: <Widget>[
          Expanded(
            child: Center(child: leftContent ?? Container()),
          ),
          Container(
            width: 1,
            color: const Color(0xFF757575),
          ),
          Expanded(
            child: Center(child: rightContent ?? Container()),
          ),
        ],
      ),
    );
  }

  // Hàm tạo đường kẻ ngang bằng ảnh
  Widget _buildDivider() {
    return Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: const AssetImage('assets/images/Divider.png'), // TODO: Thay thế bằng đường dẫn ảnh thực tế
          fit: BoxFit.contain,
          onError: (exception, stackTrace) {
            // Xử lý lỗi tải ảnh (tùy chọn)
          },
        ),
      ),
    );
  }
  // --- KẾT THÚC PHẦN CHỌN THỜI GIAN TRANG TRÍ ĐÃ SỬA ĐỔI ---


  Widget _buildDateSelector() {
    // Widget chọn ngày
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: DateSelectorWidget(
        selectedDate: selectedDate,
        onDateSelected: (date) {
          setState(() {
            selectedDate = date;
          });
        },
      ),
    );
  }

  Widget _buildTimeSelectors() {
    // Các widget chọn thời gian bắt đầu và kết thúc thực tế
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 25, left: 16, right: 16, bottom: 8),
          child: Text(
            "Start Time", // Nhãn thời gian bắt đầu
            style: TextStyle(color: Colors.white70, fontSize: 16, fontFamily: 'Poppins', fontWeight: FontWeight.w500),
          ),
        ),
        TimeSelectorWidget(
          selectedTime: selectedStartTime,
          timeOptions: _timeOptions,
          onTimeSelected: (time) {
            setState(() {
              selectedStartTime = time;
              DateTime sTime = _parseTime(selectedStartTime);
              DateTime eTime = _parseTime(selectedEndTime);
              // Tự động điều chỉnh thời gian kết thúc nếu cần
              if (eTime.isBefore(sTime) || eTime.isAtSameMomentAs(sTime)) {
                int currentIndex = _timeOptions.indexOf(selectedStartTime);
                if (currentIndex < _timeOptions.length - 1) {
                  selectedEndTime = _timeOptions[currentIndex + 1];
                } else {
                  selectedEndTime = selectedStartTime; // Trường hợp cuối danh sách
                }
              }
            });
          },
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Center(
            child: Text(
              "to", // Chữ "đến"
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w500,
                letterSpacing: -0.4,
                fontFamily: 'Poppins',
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 16, right: 16, bottom: 8),
          child: Text(
            "End Time", // Nhãn thời gian kết thúc
            style: TextStyle(color: Colors.white70, fontSize: 16, fontFamily: 'Poppins', fontWeight: FontWeight.w500),
          ),
        ),
        TimeSelectorWidget(
          selectedTime: selectedEndTime,
          timeOptions: _timeOptions,
          onTimeSelected: (time) {
            setState(() {
              DateTime sTime = _parseTime(selectedStartTime);
              DateTime newETime = _parseTime(time);
              // Kiểm tra và cảnh báo nếu thời gian kết thúc không hợp lệ
              if (newETime.isBefore(sTime) || newETime.isAtSameMomentAs(sTime)) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Thời gian kết thúc phải sau thời gian bắt đầu."),
                    backgroundColor: Colors.redAccent,
                    duration: Duration(seconds: 2),
                  ),
                );
              }
              selectedEndTime = time; // Cho phép chọn, kiểm tra lại khi nhấn Continue
            });
          },
        ),
      ],
    );
  }

  Widget _buildContinueButton() {
    // Nút Tiếp tục
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 30, 16, 20),
      child: TextButton(
        onPressed: () {
          // Các biến này cần được truy cập từ state của _BookingPage2State
          // Đảm bảo selectedStartTime, selectedEndTime, selectedDate, _selectedDecorativeTime
          // và _parseTime là có thể truy cập được ở đây.
          // Nếu _buildContinueButton là một phần của _BookingPage2State thì chúng sẽ truy cập được.

          DateTime sTime = _parseTime(selectedStartTime);
          DateTime eTime = _parseTime(selectedEndTime);

          // Kiểm tra lần cuối trước khi tiếp tục
          if (eTime.isBefore(sTime) || eTime.isAtSameMomentAs(sTime)) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Thời gian kết thúc phải sau thời gian bắt đầu. Vui lòng điều chỉnh lựa chọn của bạn."),
                backgroundColor: Colors.redAccent,
                duration: Duration(seconds: 3),
              ),
            );
            return; // Dừng thực thi nếu kiểm tra thất bại
          }

          // In thông tin đã chọn (ví dụ, bạn có thể giữ hoặc xóa)
          print("Ngày đã chọn: ${selectedDate.toLocal().toString().split(' ')[0]}");
          print("Thời gian bắt đầu đã chọn: $selectedStartTime");
          print("Thời gian kết thúc đã chọn: $selectedEndTime");
          print("Ô thời gian trang trí đã chọn: $_selectedDecorativeTime");

          // ---- BẮT ĐẦU PHẦN ĐIỀU HƯỚNG ----
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CancelConfirmBooking()), // Điều hướng đến trang xác nhận giả định
          );
          // ---- KẾT THÚC PHẦN ĐIỀU HƯỚNG ----
        },
        style: TextButton.styleFrom(
          backgroundColor: const Color(0xFF03DABB), // Màu nền nút
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          minimumSize: const Size(double.infinity, 50),
        ),
        child: const Text(
          "Continue", // Chữ trên nút
          style: TextStyle(
            color: Color(0xFF1C1C2A),
            fontSize: 20,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.4,
            fontFamily: 'Poppins',
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
