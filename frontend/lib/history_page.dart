import 'package:flutter/material.dart';

// Model đơn giản cho một mục lịch sử sạc
class ChargingHistoryItem {
  final String id;
  final String stationName;
  final String stationCode; // Ví dụ: VF2-002
  final String date;
  final String cost;
  final String timeSlot;
  final String durationInfo; // Ví dụ: "30 minutes in HNL"
  final IconData icon; // Icon cho mỗi mục

  ChargingHistoryItem({
    required this.id,
    required this.stationName,
    required this.stationCode,
    required this.date,
    required this.cost,
    required this.timeSlot,
    required this.durationInfo,
    this.icon = Icons.ev_station, // Icon mặc định
  });
}

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  // Dữ liệu mẫu cho danh sách lịch sử - bạn nên thay thế bằng dữ liệu thực tế
  final List<ChargingHistoryItem> _historyItems = List.generate(
    15, // Tạo 15 mục mẫu
        (index) => ChargingHistoryItem(
      id: "history_$index",
      stationName: "Trạm sạc Vinfast ${index % 3 + 2}", // Tạo tên trạm khác nhau
      stationCode: "VF${index % 3 + 2}-00${index % 5 + 1}",
      date: "18/02/202${index % 3 + 2}", // Ngày khác nhau
      cost: "${(index % 5 + 1) * 10}.000 VND", // Giá khác nhau
      timeSlot: "${7 + index % 2}:00 AM - ${7 + index % 2}:30 AM",
      durationInfo: "${25 + index % 10} minutes in HNL",
    ),
  );

  // Biến cho phân trang (ví dụ)
  int _currentPage = 1;
  final int _itemsPerPage = 6; // Số mục hiển thị trên mỗi trang
  // Giả sử _totalItems được lấy từ độ dài của _historyItems nếu không có API
  // Hoặc bạn có thể đặt một giá trị cố định nếu API trả về tổng số item
  late int _totalItems;


  List<ChargingHistoryItem> get _paginatedItems {
    final startIndex = (_currentPage - 1) * _itemsPerPage;
    // Đảm bảo endIndex không vượt quá độ dài của _historyItems
    final endIndex = (startIndex + _itemsPerPage > _historyItems.length)
        ? _historyItems.length
        : startIndex + _itemsPerPage;
    // Đảm bảo startIndex không âm và không vượt quá độ dài list
    if (startIndex < 0 || startIndex > _historyItems.length) return [];
    return _historyItems.sublist(startIndex, endIndex);
  }

  @override
  void initState() {
    super.initState();
    // Khởi tạo _totalItems dựa trên dữ liệu mẫu
    // Trong ứng dụng thực tế, bạn có thể lấy giá trị này từ API
    _totalItems = _historyItems.length;
    // Nếu bạn muốn tổng số item là một số cố định khác, ví dụ 256, và dữ liệu mẫu chỉ là phần nhỏ:
    // _totalItems = 256; // Thì logic phân trang cần gọi API để lấy dữ liệu cho từng trang
  }


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final Color primaryColor = theme.colorScheme.primary; // Nên là Colors.tealAccent
    final Color cardBackgroundColor = const Color(0xFF1A1A26); // Màu nền cho các card/item
    final Color costColor = const Color(0xFF4CAF50); // Màu xanh lá cho giá tiền (hoặc primaryColor)

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor, // Đồng bộ với nền
        elevation: 0,
        title: Text(
          "History",
          style: theme.textTheme.headlineSmall?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        // Nếu trang này không phải là tab chính nữa, bạn có thể muốn có nút back
        // automaticallyImplyLeading: true, // Hoặc false tùy theo cấu trúc điều hướng mới
      ),
      body: Column(
        children: [
          Expanded(
            child: _paginatedItems.isEmpty
                ? Center(
              child: Text(
                "No history items found.",
                style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey[500]),
              ),
            )
                : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
              itemCount: _paginatedItems.length, // Sử dụng danh sách đã phân trang
              itemBuilder: (context, index) {
                final item = _paginatedItems[index];
                return _buildHistoryItemCard(context, item, theme, cardBackgroundColor, costColor, primaryColor);
              },
            ),
          ),
          _buildPaginationControls(context, theme),
        ],
      ),
      // Thuộc tính bottomNavigationBar đã được xóa
    );
  }

  Widget _buildHistoryItemCard(BuildContext context, ChargingHistoryItem item, ThemeData theme, Color cardBackgroundColor, Color costColor, Color primaryColor) {
    return Card(
      color: cardBackgroundColor,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(item.icon, color: primaryColor, size: 36), // Icon trạm sạc
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.stationName,
                    style: theme.textTheme.titleMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.stationCode,
                    style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey[400]),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.date,
                    style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey[400]),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  item.cost,
                  style: theme.textTheme.titleSmall?.copyWith(color: costColor, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  item.timeSlot,
                  style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey[400]),
                ),
                const SizedBox(height: 4),
                Text(
                  item.durationInfo,
                  style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey[400]),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaginationControls(BuildContext context, ThemeData theme) {
    // Sử dụng _historyItems.length cho totalItems nếu dữ liệu chỉ là mẫu và không có API
    // Hoặc nếu _totalItems đã được set từ API thì giữ nguyên
    int currentTotalItemsForPagination = _totalItems; // Hoặc _historyItems.length nếu không có API tổng

    int totalPages = (currentTotalItemsForPagination / _itemsPerPage).ceil();
    if (totalPages == 0 && _historyItems.isNotEmpty) totalPages = 1; // Đảm bảo có ít nhất 1 trang nếu có item

    int startItem = (_currentPage - 1) * _itemsPerPage + 1;
    int endItem = _currentPage * _itemsPerPage;
    if (endItem > currentTotalItemsForPagination) endItem = currentTotalItemsForPagination;

    if (_historyItems.isEmpty) { // Nếu không có item nào thì không hiển thị phân trang
      return const SizedBox.shrink();
    }
    // Chỉ hiển thị phân trang nếu có nhiều hơn 1 trang hoặc nếu tổng số item lớn hơn số item mỗi trang
    // và danh sách item không rỗng
    if (totalPages <= 1 && _historyItems.length <= _itemsPerPage) {
      // Vẫn hiển thị nếu có item nhưng chỉ 1 trang
      if (_historyItems.isNotEmpty) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "$startItem - $endItem of $currentTotalItemsForPagination",
                style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey[400]),
              ),
            ],
          ),
        );
      }
      return const SizedBox.shrink();
    }


    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back_ios, color: _currentPage > 1 ? Colors.white : Colors.grey[700], size: 18),
            onPressed: _currentPage > 1
                ? () {
              setState(() {
                _currentPage--;
              });
            }
                : null,
          ),
          Text(
            "$startItem - $endItem of $currentTotalItemsForPagination",
            style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey[400]),
          ),
          IconButton(
            icon: Icon(Icons.arrow_forward_ios, color: _currentPage < totalPages ? Colors.white : Colors.grey[700], size: 18),
            onPressed: _currentPage < totalPages
                ? () {
              setState(() {
                _currentPage++;
              });
            }
                : null,
          ),
        ],
      ),
    );
  }
}
