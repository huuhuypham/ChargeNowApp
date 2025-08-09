import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateSelectorWidget extends StatelessWidget {
  final DateTime selectedDate;
  final Function(DateTime) onDateSelected;

  const DateSelectorWidget({
    Key? key,
    required this.selectedDate,
    required this.onDateSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: _buildDateItems(),
      ),
    );
  }

  List<Widget> _buildDateItems() {
    final now = DateTime.now();
    final dates = List.generate(
      7,
          (index) => now.add(Duration(days: index)),
    );

    return dates.map((date) {
      final isSelected = DateUtils.isSameDay(date, selectedDate);
      return _buildDateItem(date, isSelected);
    }).toList();
  }

  Widget _buildDateItem(DateTime date, bool isSelected) {
    final monthName = DateFormat('MMM').format(date);
    final dayNumber = DateFormat('dd').format(date);

    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: GestureDetector(
        onTap: () => onDateSelected(date),
        child: Container(
          width: 52,
          child: Column(
            children: [
              Container(
                width: 52,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  color: isSelected
                      ? const Color(0xFF07B686)
                      : const Color(0xFF1C1C1C),
                ),
                padding: const EdgeInsets.only(top: 19, bottom: 4),
                child: Column(
                  children: [
                    Text(
                      monthName,
                      style: TextStyle(
                        color: isSelected
                            ? Colors.black
                            : const Color(0xFFF2F2F2),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Poppins',
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 17),
                      width: double.infinity,
                      height: 44,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: isSelected
                            ? const Color(0xFF1D1D1D)
                            : const Color(0xFF3B3B3B),
                      ),
                      child: Center(
                        child: Text(
                          dayNumber,
                          style: const TextStyle(
                            color: Color(0xFFF2F2F2),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Poppins',
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
