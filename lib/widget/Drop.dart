// ignore_for_file: camel_case_types, file_names, non_constant_identifier_names, prefer_const_constructors, avoid_print, must_be_immutable

import 'package:flutter/material.dart';

class Custom_Drop extends StatefulWidget {
  Custom_Drop({
    super.key,
    selectedValue,
    required this.controller,
    required this.hintText,
  });
  final String? hintText;
  var controller = TextEditingController();

  @override
  State<Custom_Drop> createState() => Custom_DropState();
}

class Custom_DropState extends State<Custom_Drop> {
  String? selectedValue;
  TextEditingController controller = TextEditingController();

  dynamic v_1 = "Internet";
  dynamic v_2 = "Bluetooth";
  dynamic v_3 = "USB";

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(value: v_1, child: Text(v_1)),
      DropdownMenuItem(value: v_2, child: Text(v_2)),
      DropdownMenuItem(value: v_3, child: Text(v_3)),
    ];
    return menuItems;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        DropdownButtonFormField(
            decoration: InputDecoration(
              filled: true,
              hintText: widget.hintText,
              fillColor: Colors.transparent,
            ),
            dropdownColor: const Color.fromARGB(255, 245, 244, 244),
            value: selectedValue,
            onChanged: (String? newValue) {
              setState(() {
                selectedValue = newValue!;
                print(newValue);
              });
            },
            items: dropdownItems),

        // `````````````````````````````````````````````````````````````````

        selectedValue == 'Internet'
            ? TextField(
                controller: widget.controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'IP Address',
                ))
            : Text(''),

        // `````````````````````````````````````````````````````````````````

        selectedValue == 'Bluetooth'
            ? SizedBox(
                height: 80,
                width: 300,
                child: Center(child: RefreshProgressIndicator()),
              )
            : Text(''),

        // `````````````````````````````````````````````````````````````````

        selectedValue == 'USB'
            ? SizedBox(
                height: 80,
                width: 300,
                child: Center(child: RefreshProgressIndicator()),
              )
            : Text(''),
      ],
    ));
  }
}

// ========================================================================================================
class Custom_Drop1 extends StatefulWidget {
  const Custom_Drop1({
    super.key,
    selectedValue,
    required this.hintText,
  });
  final String? hintText;
  @override
  State<Custom_Drop1> createState() => Custom_Drop1State();
}

class Custom_Drop1State extends State<Custom_Drop1> {
  String? selectedValue;

  dynamic v_1 = "MFP 135w";
  dynamic v_2 = "LBP6030B";
  dynamic v_3 = "hp 1025";
  dynamic v_4 = "vB690B";

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(value: v_1, child: Text(v_1)),
      DropdownMenuItem(value: v_2, child: Text(v_2)),
      DropdownMenuItem(value: v_3, child: Text(v_3)),
      DropdownMenuItem(value: v_4, child: Text(v_4)),
    ];
    return menuItems;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        DropdownButtonFormField(
            decoration: InputDecoration(
              filled: true,
              hintText: widget.hintText,
              fillColor: Colors.transparent,
            ),
            dropdownColor: const Color.fromARGB(255, 245, 244, 244),
            value: selectedValue,
            onChanged: (String? newValue) {
              setState(() {
                selectedValue = newValue!;
              });
            },
            items: dropdownItems),
      ],
    ));
  }
}

// ==========================================================================
class Custom_Drop2 extends StatefulWidget {
  const Custom_Drop2({
    super.key,
    selectedValue,
    required this.hintText,
  });
  final String? hintText;
  @override
  State<Custom_Drop2> createState() => Custom_Drop2State();
}

class Custom_Drop2State extends State<Custom_Drop2> {
  String? selectedValue;

  dynamic v_1 = "80 m";
  dynamic v_2 = "85 m";

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(value: v_1, child: Text(v_1)),
      DropdownMenuItem(value: v_2, child: Text(v_2)),
    ];
    return menuItems;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        DropdownButtonFormField(
            decoration: InputDecoration(
              filled: true,
              hintText: widget.hintText,
              fillColor: Colors.transparent,
            ),
            dropdownColor: const Color.fromARGB(255, 245, 244, 244),
            value: selectedValue,
            onChanged: (String? newValue) {
              setState(() {
                selectedValue = newValue!;
              });
            },
            items: dropdownItems),
        const SizedBox(height: 20),
        Text(
          selectedValue == null ? "" : selectedValue.toString(),
          style: const TextStyle(fontSize: 20),
        )
      ],
    ));
  }
}
