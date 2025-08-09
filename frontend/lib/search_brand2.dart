import 'package:flutter/material.dart';

// Model đơn giản cho một trạm sạc, bạn có thể mở rộng thêm các thuộc tính
class ChargingStation {
  final String id;
  final String name;
  final String address;
  final String status; // Ví dụ: "Available", "In Use", "Offline"

  ChargingStation({
    required this.id,
    required this.name,
    required this.address,
    this.status = "Unknown",
  });
}

class SelectStationPage extends StatefulWidget {
  const SelectStationPage({Key? key}) : super(key: key);

  @override
  _SelectStationPageState createState() => _SelectStationPageState();
}

class _SelectStationPageState extends State<SelectStationPage> {
  final TextEditingController _searchController = TextEditingController();

  // Danh sách trạm sạc mẫu - bạn nên thay thế bằng dữ liệu thực tế từ API hoặc database
  final List<ChargingStation> _allStations = [
    ChargingStation(id: "1", name: "Trạm Sạc VinFast Royal City", address: "72A Nguyễn Trãi, Thanh Xuân, Hà Nội", status: "Available"),
    ChargingStation(id: "2", name: "Trạm Sạc EVN Times City", address: "458 Minh Khai, Hai Bà Trưng, Hà Nội", status: "In Use"),
    ChargingStation(id: "3", name: "Trạm Sạc Porsche Sài Gòn", address: "123 Nguyễn Văn Linh, Quận 7, TP.HCM", status: "Available"),
    ChargingStation(id: "4", name: "Trạm Sạc Tesla Landmark 81", address: "208 Nguyễn Hữu Cảnh, Bình Thạnh, TP.HCM", status: "Offline"),
    ChargingStation(id: "5", name: "Trạm Sạc ABC Vũng Tàu", address: "1 Lê Hồng Phong, Vũng Tàu", status: "Available"),
    ChargingStation(id: "6", name: "Trạm Sạc Ecotap Đà Nẵng", address: "Võ Nguyên Giáp, Sơn Trà, Đà Nẵng"),
    ChargingStation(id: "7", name: "Trạm Sạc Quận 1 Hub", address: "50 Đồng Khởi, Quận 1, TP.HCM", status: "Available"),
    ChargingStation(id: "8", name: "Trạm Sạc Vincom Thủ Đức", address: "216 Võ Văn Ngân, Thủ Đức, TP.HCM", status: "In Use"),
  ];
  List<ChargingStation> _filteredStations = [];

  @override
  void initState() {
    super.initState();
    _filteredStations = List.from(_allStations);
    _searchController.addListener(_filterStations);
  }

  void _filterStations() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredStations = _allStations.where((station) {
        final stationName = station.name.toLowerCase();
        final stationAddress = station.address.toLowerCase();
        return stationName.contains(query) || stationAddress.contains(query);
      }).toList();
    });
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterStations);
    _searchController.dispose();
    super.dispose();
  }

  InputDecoration _buildSearchInputDecoration(BuildContext context) {
    final theme = Theme.of(context);
    final inputTheme = theme.inputDecorationTheme;

    return InputDecoration(
      hintText: 'Tìm kiếm tên trạm, địa chỉ...', // Hint text tiếng Việt
      hintStyle: inputTheme.hintStyle ?? TextStyle(color: Colors.grey[400]),
      prefixIcon: Icon(Icons.search, color: inputTheme.prefixIconColor ?? Colors.grey[400]),
      filled: true,
      fillColor: inputTheme.fillColor ?? const Color(0xFF2E2E48),
      border: inputTheme.border ?? OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide.none,
      ),
      focusedBorder: inputTheme.focusedBorder ?? OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(color: theme.colorScheme.primary, width: 1.5),
      ),
      contentPadding: inputTheme.contentPadding ?? const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    final appBarTheme = Theme.of(context).appBarTheme;
    final listTileTheme = Theme.of(context).listTileTheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: appBarTheme.iconTheme?.color ?? Colors.white),
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
            print("Back button pressed on SelectStationPage");
          },
        ),
        title: Text(
          'Chọn Trạm Sạc', // Tiêu đề tiếng Việt
          style: appBarTheme.titleTextStyle ?? textTheme.titleLarge?.copyWith(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _searchController,
              style: textTheme.bodyLarge?.copyWith(color: Colors.white),
              decoration: _buildSearchInputDecoration(context),
              cursorColor: Theme.of(context).textSelectionTheme.cursorColor ?? Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: _filteredStations.isEmpty && _searchController.text.isNotEmpty
                  ? Center(
                child: Text(
                  'Không tìm thấy trạm sạc nào', // Thông báo tiếng Việt
                  style: textTheme.bodyMedium?.copyWith(color: Colors.grey),
                ),
              )
                  : ListView.builder(
                itemCount: _filteredStations.length,
                itemBuilder: (context, index) {
                  final station = _filteredStations[index];
                  return ListTile(
                    // Có thể thêm Icon trạm sạc ở đây nếu muốn
                    // leading: Icon(Icons.ev_station, color: Colors.tealAccent),
                    title: Text(
                      station.name,
                      style: textTheme.titleMedium?.copyWith(color: listTileTheme.textColor ?? Colors.white),
                    ),
                    subtitle: Text(
                      station.address,
                      style: textTheme.bodySmall?.copyWith(color: listTileTheme.textColor?.withOpacity(0.7) ?? Colors.white70),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: listTileTheme.iconColor ?? Colors.white54,
                    ),
                    onTap: () {
                      print('Đã chọn trạm: ${station.name}');
                      // Trả về trạm đã chọn cho trang trước
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context, station); // Trả về cả object ChargingStation
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
