// ignore_for_file: camel_case_types, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

class coustom_switch extends StatefulWidget {
  coustom_switch({super.key, required this.isToggled});

  bool isToggled = false;
  @override
  State<coustom_switch> createState() => _coustom_switchState();
}

class _coustom_switchState extends State<coustom_switch> {
  @override
  Widget build(BuildContext context) {
    return FlutterSwitch(
      height: 20.0,
      width: 40.0,
      padding: 4.0,
      toggleSize: 15.0,
      borderRadius: 10.0,
      activeColor: Colors.green,
      value: widget.isToggled,
      onToggle: (value) {
        setState(() {
          widget.isToggled = value;
        });
      },
    );
  }
}
