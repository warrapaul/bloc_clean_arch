import 'package:flutter/material.dart';

class CustomDropdownMenu extends StatefulWidget {
  final dynamic items; // Accepts either a List or a Map
  final String? selectedKey;
  final ValueChanged<String?> onChanged;
  final TextEditingController controller;
  final String hintText;
  final bool enableFilter;

  const CustomDropdownMenu({
    super.key,
    required this.items,
    required this.hintText,
    required this.onChanged,
    required this.controller,
    this.selectedKey,
    this.enableFilter = true,
  });

  @override
  _CustomDropdownMenuState createState() => _CustomDropdownMenuState();
}

class _CustomDropdownMenuState extends State<CustomDropdownMenu> {
  late List<DropdownMenuEntry<String>> _dropdownItems;
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
        return DropdownMenuEntry<String>(value: entry.key, label: entry.value);
      }).toList();
    } else if (widget.items is List<String>) {
      _dropdownItems = (widget.items as List<String>).map((value) {
        return DropdownMenuEntry<String>(value: value, label: value);
      }).toList();
    } else {
      _dropdownItems = [];
    }

    // // Ensure _selectedValue is valid
    //   // if (_selectedValue != null &&
    //   //     !_dropdownItems.any((item) => item.value == _selectedValue)) {
    //   //   _selectedValue = null;
    //   // }
    //   // // Add a default "No items" entry if the list is empty
    //   // if (_dropdownItems.isEmpty) {
    //   //   _dropdownItems = [DropdownMenuEntry(value: '', label: 'No items')];
    //   // }
  }

  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
      requestFocusOnTap: true,
      expandedInsets: const EdgeInsets.all(16),
      controller: widget.controller,
      initialSelection: _selectedValue,
      hintText: widget.hintText,
      leadingIcon: const Icon(Icons.search),
      // trailingIcon: Icon(Icons.chevron_right),
      label: Text(widget.hintText),
      // errorText: '',
      // initialSelection: 'three' ,
      // searchCallback: ,
      // filterCallback: ,
      width: 400,
      dropdownMenuEntries: _dropdownItems,
      enableFilter: widget.enableFilter,
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      menuStyle: MenuStyle(
        padding: WidgetStateProperty.all<EdgeInsets>(EdgeInsets.zero),
      ),
      searchCallback: (entries, query) {
        final String searchText = widget.controller.value.text.toLowerCase();
        if (searchText.isEmpty) {
          return null;
        }
        final int index = _dropdownItems.indexWhere((DropdownMenuEntry entry) =>
            entry.label.toLowerCase().contains(searchText));

        return index != -1 ? index : null;
      },
    );
  }
}
