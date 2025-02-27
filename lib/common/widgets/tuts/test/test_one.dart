import 'package:flutter/material.dart';

class TestOne extends StatefulWidget {
  const TestOne({super.key});

  @override
  State<TestOne> createState() => _TestOneState();
}

class _TestOneState extends State<TestOne> {
  final TextEditingController _regController = TextEditingController();

  final List<String> _regions = ['zmm', 'g44', 'lsm', 'g45'];

  final Map<String, String> _regs = {
    'zmm': 'Zimmerman',
    'g44': 'Bithurai 44',
    'g45': 'Githurai 45'
  };

  List<DropdownMenuEntry> _createDropdownEntries() {
    // return _regions.map((value) {
    //   return DropdownMenuEntry(value: value, label: value);
    // }).toList();

    return _regs.entries.map((entry) {
      return DropdownMenuEntry(value: entry.key, label: entry.value);
    }).toList();
  }

  String? selectedValue;
  final List<DropdownMenuEntry<String>> entries = [
    const DropdownMenuEntry(value: 'one', label: 'one'),
    const DropdownMenuEntry(value: 'two', label: 'two'),
    const DropdownMenuEntry(value: 'three', label: 'three'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _dropdownMenu(),
            const SizedBox(height: 20),
            _dropdownMenuTwo(),
            const SizedBox(height: 20),
            _dropdownButton(),
          ],
        ),
      ),
    );
  }

  Widget _dropdownMenu() {
    return DropdownMenu<String>(
              enableFilter: true,
              requestFocusOnTap: true,
              expandedInsets: const EdgeInsets.all(16),
              initialSelection: selectedValue,
              onSelected: (String? value) {
                setState(() {
                  selectedValue = value;
                });
              },
              dropdownMenuEntries: entries,
              inputDecorationTheme: const InputDecorationTheme(
                border: OutlineInputBorder(),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
              menuStyle: MenuStyle(
                padding: WidgetStateProperty.all<EdgeInsets>(EdgeInsets.zero),
              ),
            );




    //  return DropdownMenu<String>(
    //   enableFilter: true,
    //   requestFocusOnTap: true,
    //   expandedInsets: const EdgeInsets.all(16),
    //   initialSelection: selectedValue,
    //   onSelected: (String? value) {
    //     setState(() {
    //       selectedValue = value;
    //     });
    //   },
    //   dropdownMenuEntries: entries,
    //   inputDecorationTheme: InputDecorationTheme(
    //     border: OutlineInputBorder(),
    //     contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    //     fillColor: Colors.white,
    //     filled: true,
    //   ),
    //   menuStyle: MenuStyle(
    //     padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.zero),
    //   ),
    //   textStyle: TextStyle(color: Colors.black),
    //   leadingIcon: Icon(Icons.search),
    //   enableSearch: true,
    //   controller: TextEditingController(),
    //   filterFn: (String item, String? query) {
    //     return query == null || query.isEmpty
    //         ? true
    //         : item.toLowerCase().contains(query.toLowerCase());
    //   },
    // );
  }


  Widget _dropdownMenuTwo() {
    return DropdownMenu(
        enableFilter: true,
        leadingIcon: const Icon(Icons.search),
        // trailingIcon: Icon(Icons.chevron_right),
        label: const Text('select one'),
        hintText: 'Search',
        // errorText: '',
        // initialSelection: 'three' ,
        // searchCallback: ,
        // filterCallback: ,

        width: 400,
        controller: _regController,
        dropdownMenuEntries: _createDropdownEntries());
  }

  Widget _dropdownButton() {
    return DropdownButton<String>(
              value: null, // Set the initial value here
              hint: const Text('Select an option'), // Placeholder text
              onChanged: (String? newValue) {
                // Handle the selection here
              },
              items: <String>['one', 'two', 'three']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            );
  }
}
