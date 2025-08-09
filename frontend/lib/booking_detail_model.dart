// booking_detail_model.dart
import 'package:flutter/material.dart'; // Không thực sự cần thiết ở đây, nhưng có thể để lại

class BookingDetail {
  final String bookingId;
  final String stationName;
  final String stationCode; // Ví dụ: "VF2-002"
  final DateTime bookingDate;
  final String bookingTimeSlot; // Ví dụ: "7:00 AM - 7:30 AM"
  final String duration; // Ví dụ: "30 minutes"
  final String? durationContext; // Ví dụ: "in HNL" (tùy chọn)
  final String price; // Ví dụ: "50.000 VND"
  final String chargerType; // Ví dụ: "DC post"
  final String maxPower; // Ví dụ: "30 kW"
  final String? customerName; // Tên khách hàng (tùy chọn)
  final String? stationAddress; // Địa chỉ trạm (tùy chọn)
  final String? paymentMethod; // Phương thức thanh toán (tùy chọn)
  final String? carImageAsset; // Đường dẫn ảnh xe (tùy chọn)
  // Thêm các trường khác nếu cần, ví dụ: trạng thái đặt chỗ (đã hoàn thành, đã hủy,...)


  BookingDetail({
    required this.bookingId,
    required this.stationName,
    required this.stationCode,
    required this.bookingDate,
    required this.bookingTimeSlot,
    required this.duration,
    this.durationContext,
    required this.price,
    required this.chargerType,
    required this.maxPower,
    this.customerName,
    this.stationAddress,
    this.paymentMethod,
    this.carImageAsset,
  });
}
