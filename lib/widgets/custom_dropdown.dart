import 'package:flutter/material.dart';

class CustomDropdown extends StatelessWidget {
  final List<String> options;
  final String selectedOption;
  final ValueChanged<String> onChanged;
  final bool showButtons;

  const CustomDropdown({
    super.key,
    required this.options,
    required this.selectedOption,
    required this.onChanged,
    this.showButtons = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8.0),
        if (showButtons)
          Wrap(
            spacing: 8.0,
            children: options.map((option) {
              return ElevatedButton(
                onPressed: () {
                  onChanged(option);
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
                    return selectedOption == option ? Colors.blue : Colors.grey[300]!;
                  }),
                ),
                child: Text(option),
              );
            }).toList(),
          ),
      ],
    );
  }
}
