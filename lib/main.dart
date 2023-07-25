// ignore_for_file: non_constant_identifier_names, unused_element, avoid_print, unused_field, avoid_unnecessary_containers, use_build_context_synchronously

import 'dart:developer';
import 'package:ams_printer/ip/priter_services.dart';
import 'package:ams_printer/widget/Drop.dart';
import 'package:ams_printer/widget/Snack_Bar.dart';
import 'package:ams_printer/widget/text_Filed.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scan_bluetooth/flutter_scan_bluetooth.dart';
import 'dart:io';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'bluetooth/printer_manager.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: appNavigatorKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ipController = TextEditingController();

  final ctrl = TextEditingController();
  final name_print = TextEditingController();

  bool isToggled = false;

  String? selectedValue;

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

// Bluetooth ========================================================================================================

  late FlutterScanBluetooth _scanBluetooth;
  late List<BluetoothDevice> _devices;
  BluetoothDevice? _selectedDevice;
  late File imgFile;
  bool isScanning = true;

  @override
  void initState() {
    super.initState();
    _devices = [];
    _scanBluetooth = FlutterScanBluetooth();
    _startScan();
    _initImg();
  }

  _startScan() async {
    setState(() {
      isScanning = true;
    });
    await _scanBluetooth.startScan();

    _scanBluetooth.devices.listen((dev) {
      if (!_isDeviceAdded(dev)) {
        setState(() {
          _devices.add(dev);
        });
      }
    });

    await Future.delayed(const Duration(seconds: 10));
    _stopScan();
  }

  _stopScan() {
    _scanBluetooth.stopScan();
    setState(() {
      isScanning = false;
    });
  }

  bool _isDeviceAdded(BluetoothDevice device) => _devices.contains(device);

  _initImg() async {
    try {
      ByteData byteData = await rootBundle.load("images/flutter.png");
      Uint8List buffer = byteData.buffer.asUint8List();
      String path = (await getTemporaryDirectory()).path;
      imgFile = File("$path/img.png");
      imgFile.writeAsBytes(buffer);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('الطابعة', style: TextStyle(fontSize: 26)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              Custom_Field(
                hint_text: "أسم الطابعة",
                TEXT_controller: name_print,
              ),
              const SizedBox(height: 10),
              // طراز الطابعة  ==============================================================================================

              const Custom_Drop1(hintText: "طراز الطابعة"),
              const SizedBox(height: 15),

              //الواجهة الطابعة =============================================================================================

              custom_dropdown(),

              // ==============================================================================================

              const Custom_Drop2(hintText: 'حجم الورقة'),

              // ==============================================================================================

              ElevatedButton(
                onPressed: () {
                  _print2();
                  Snak_Bar(context, 'تم بنجاح الطباعة');
                },
                child: Container(
                  width: 200,
                  alignment: Alignment.center,
                  child: const Text(
                    'إختبار الطابعة',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ),

              //  -------------------------------------------------------------------------
              // const SizedBox(height: 10),
              // Card(
              //   child: Padding(
              //     padding: const EdgeInsets.all(20),
              //     child: Column(
              //       children: [
              //         Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           children: [
              //             coustom_switch(isToggled: isToggled),
              //             Container(
              //               alignment: Alignment.center,
              //               child: const Text("طابعة  الفواتير",
              //                   style: TextStyle(fontSize: 15)),
              //             ),
              //           ],
              //         ),
              //         const SizedBox(height: 15),
              //         Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           children: [
              //             coustom_switch(isToggled: isToggled),
              //             Container(
              //               alignment: Alignment.center,
              //               child: const Text("طابعة  الايصالات",
              //                   style: TextStyle(fontSize: 15)),
              //             ),
              //           ],
              //         ),
              //         const SizedBox(height: 15),
              //         Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           children: [
              //             coustom_switch(isToggled: isToggled),
              //             Container(
              //               alignment: Alignment.center,
              //               child: const Text("طابعة  المستندات",
              //                   style: TextStyle(fontSize: 15)),
              //             ),
              //           ],
              //         ),
              //         const SizedBox(height: 15),
              //         Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           children: [
              //             coustom_switch(isToggled: isToggled),
              //             Container(
              //               alignment: Alignment.center,
              //               child: const Text("طابعة  الطلبات",
              //                   style: TextStyle(fontSize: 15)),
              //             ),
              //           ],
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              // const SizedBox(height: 30),

              // ==============================================================================================

              ElevatedButton(
                onPressed: () async {
                  await _print2();

                  if (_selectedDevice?.name != null) {
                    await PrinterManager.connect(_selectedDevice!.address);
                    await PrinterManager.printImg(imgFile.path);
                  }
                },
                child: Container(
                  width: 200,
                  alignment: Alignment.center,
                  child: const Text(
                    ' تأكيد',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //  search_Bluetooth  ==============================================================================================

  Row search_BL(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElevatedButton(
          onPressed: () {
            showModalBottomSheet(
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                builder: (context) {
                  return SizedBox(
                    height: 700,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ..._devices.map((dev) => _buildDev(dev)),
                      ],
                    ),
                  );
                });
          },
          child: const Text("بحث"),
        ),
        ConditionalBuilder(
          condition: _selectedDevice != null,
          builder: (context) => Column(
            children: [
              Container(
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(13),
                      child: Text(_selectedDevice!.name,
                          style: const TextStyle(
                              color: Colors.lightBlue,
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(width: 20),
                  ],
                ),
              ),
            ],
          ),
          fallback: (context) => Container(
            child: const Text("لم يتم تحديد طابعة"),
          ),
        ),
      ],
    );
  }
  //  dropdown  ==============================================================================================

  Form custom_dropdown() {
    return Form(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        DropdownButtonFormField(
            decoration: const InputDecoration(
              filled: true,
              hintText: "الواجهة",
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

        // ```````````````````````````````

        selectedValue == 'Internet'
            ? Column(
                children: [
                  const SizedBox(height: 10),
                  TextField(
                      controller: ctrl,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'IP Address',
                      )),
                ],
              )
            : const Text(''),

        // '''''''''''''''''''''''''''''''

        selectedValue == 'Bluetooth'
            ? SizedBox(
                height: 80,
                width: 300,
                child: Center(
                  child: search_BL(context),
                ),
              )
            : const Text(''),

        // ''''''''''''''''''''''''''''''''''
        selectedValue == 'USB'
            ? const SizedBox(
                height: 80,
                width: 300,
                child: Center(child: RefreshProgressIndicator()),
              )
            : const Text(''),
      ],
    ));
  }
  //  print  ==============================================================================================

  _print2() {
    log(ctrl.text);
    printTest(ctrl.text, context);
  }

  //  BluetoothDevice ==============================================================================================

  Widget _buildDev(BluetoothDevice dev) => GestureDetector(
        onTap: () {
          setState(() {
            _selectedDevice = dev;
            Navigator.pop(context);
          });
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 175, 224, 177),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              Text(dev.name,
                  style: const TextStyle(
                      color: Colors.lightBlue,
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 10,
              ),
              Text(dev.address,
                  style: const TextStyle(color: Colors.grey, fontSize: 14))
            ],
          ),
        ),
      );
}
