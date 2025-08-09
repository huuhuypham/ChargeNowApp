import 'package:flutter/material.dart';

class BookingDetailsRow extends StatelessWidget {
  final String label;
  final String value;

  const BookingDetailsRow({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFFF2F2F2),
            fontSize: 16,
            fontWeight: FontWeight.w400,
            fontFamily: 'Poppins',
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            color: Color(0xFFF2F2F2),
            fontSize: 16,
            fontWeight: FontWeight.w700,
            fontFamily: 'Poppins',
            height: 1,
          ),
        ),
      ],
    );
  }
}
