import 'package:flutter/material.dart';

class CustomDropdownButton extends StatefulWidget {
  const CustomDropdownButton(
      {super.key,
      this.items,
      this.selectedKey,
      required this.onChanged,
      required this.controller,
      required this.hintText,
      });
  final dynamic items; // Accepts either a List or a Map
  final String? selectedKey;
  final ValueChanged<String?> onChanged;
  final TextEditingController controller;
  final String hintText;
  @override
  State<CustomDropdownButton> createState() => _CustomDropdownButtonState();
}

class _CustomDropdownButtonState extends State<CustomDropdownButton> {
  late List<DropdownMenuItem<String>> _dropdownItems;
  String? _selectedValue;
  @override
  void initState() {
    super.initState();
    _createDropdownEntries();
  }

  _createDropdownEntries() {
    if (widget.items is Map<String, String>) {
      _dropdownItems =
          (widget.items as Map<String, String>).entries.map((entry) {
        return DropdownMenuItem<String>(value: entry.key, child: Text(entry.value));
      }).toList();
    } else if (widget.items is List<String>) {
      _dropdownItems = (widget.items as List<String>).map((value) {
        return DropdownMenuItem<String>(value: value, child: Text(value));
      }).toList();
    } else {
      _dropdownItems = [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: null, // Set the initial value here
      hint: Text(widget.hintText), // Placeholder text
      onChanged: (String? newValue) {
        // Handle the selection here
      },
      items: _dropdownItems,
    );
  }
}
