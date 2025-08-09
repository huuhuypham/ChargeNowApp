import 'package:flutter/material.dart';

class TimeSelectorWidget extends StatelessWidget {
  final String selectedTime;
  final List<String> timeOptions;
  final Function(String) onTimeSelected;

  const TimeSelectorWidget({
    Key? key,
    required this.selectedTime,
    required this.timeOptions,
    required this.onTimeSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: timeOptions.map((time) {
          final isSelected = time == selectedTime;
          return _buildTimeItem(time, isSelected);
        }).toList(),
      ),
    );
  }

  Widget _buildTimeItem(String time, bool isSelected) {
    if (isSelected) {
      return Padding(
        padding: const EdgeInsets.only(right: 16),
        child: GestureDetector(
          onTap: () => onTimeSelected(time),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(29),
              border: Border.all(
                color: const Color(0xFF07B686),
                width: 1,
              ),
              color: const Color(0xFF261D08),
            ),
            child: Text(
              time,
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
      );
    } else {
      // Calculate opacity based on position from selected time
      final index = timeOptions.indexOf(time);
      final selectedIndex = timeOptions.indexOf(selectedTime);
      final distance = (index - selectedIndex).abs();
      final opacity = distance <= 1 ? 0.8 : 0.6;

      return Padding(
        padding: const EdgeInsets.only(right: 16),
        child: GestureDetector(
          onTap: () => onTimeSelected(time),
          child: Opacity(
            opacity: opacity,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(31),
                color: const Color(0xFF1C1C1C),
              ),
              child: Text(
                time,
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
        ),
      );
    }
  }
}
