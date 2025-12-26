import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: FilterChipSection()),
    ),
  ));
}

class FilterChipSection extends StatefulWidget {
  const FilterChipSection({super.key});

  @override
  State<FilterChipSection> createState() => _FilterChipSectionState();
}

class _FilterChipSectionState extends State<FilterChipSection> {
  // 1. List of category names
  final List<String> categories = [
    "All",
    "Top Rated",
    "Gold",
    "Bronze",
    "Silver",
    "Platinum",
    "New",
  ];

  // 2. Variable to track the selected index (0 = "All" by default)
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Container to give specific height to the horizontal list
        SizedBox(
          height: 50,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: categories.length,

            // Spacing between chips
            separatorBuilder: (context, index) => const SizedBox(width: 12),

            itemBuilder: (context, index) {
              final isSelected = _selectedIndex == index;

              return ChoiceChip(
                label: Text(categories[index]),

                // 3. Styling Logic matches your image
                labelStyle: TextStyle(
                  color: isSelected ? Colors.white : const Color(0xFF1A237E), // White text if selected, Dark blue if not
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),

                // 4. Color Logic
                selected: isSelected,
                selectedColor: const Color(0xFF1A237E), // Dark Blue
                backgroundColor: const Color(0xFFE8EAF6), // Light Blue/Lavender

                // Remove default checkmark icon
                showCheckmark: false,

                // Remove border
                side: BorderSide.none,

                // Round shape
                shape: const StadiumBorder(),

                // 5. Selection Handling
                onSelected: (bool selected) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
              );
            },
          ),
        ),
      ],
    );
  }
}