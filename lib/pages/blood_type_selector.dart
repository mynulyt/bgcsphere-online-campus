import 'package:flutter/material.dart';

class BloodTypeSelector extends StatelessWidget {
  final List<String> bloodTypes;
  final String selectedType;
  final Function(String) onSelected;

  const BloodTypeSelector({
    super.key,
    required this.bloodTypes,
    required this.selectedType,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
       
        const SizedBox(height: 12),

     
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: bloodTypes.sublist(0, 5).map((type) {
            final isSelected = type == selectedType;
            return GestureDetector(
              onTap: () => onSelected(type),
              child: Container(
                width: 55,
                height: 55,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelected ? const Color(0xFF6677CC) : Colors.transparent,
                  border: Border.all(color: const Color(0xFF6677CC)),
                ),
                alignment: Alignment.center,
                child: Text(
                  type,
                  style: TextStyle(
                    color: isSelected ? Colors.white : const Color(0xFF536471),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            );
          }).toList(),
        ),

        const SizedBox(height: 12),

        // Last 3 types in a Row
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: bloodTypes.sublist(5).map((type) {
            final isSelected = type == selectedType;
            return GestureDetector(
              onTap: () => onSelected(type),
              child: Container(
                width: 55,
                height: 55,
                margin: const EdgeInsets.symmetric(horizontal: 6),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelected ? const Color(0xFF6677CC) : Colors.transparent,
                  border: Border.all(color: const Color(0xFF6677CC)),
                ),
                alignment: Alignment.center,
                child: Text(
                  type,
                  style: TextStyle(
                    color: isSelected ? Colors.white : const Color(0xFF536471),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
