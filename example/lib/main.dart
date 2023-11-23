import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:sunmi_printers/sunmi_printers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _hasPrinter = false;
  PrinterStatus _status = PrinterStatus.unknown;
  final _sunmiPrintersPlugin = SunmiPrinters();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    bool hasPrinter;
    PrinterStatus status;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      hasPrinter = await _sunmiPrintersPlugin.hasPrinter();
      status = await _sunmiPrintersPlugin.getPrinterStatus();
    } on PlatformException {
      hasPrinter = false;
      status = PrinterStatus.unknown;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _hasPrinter = hasPrinter;
      _status = status;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('Printer is connected: $_hasPrinter\n Status: ${_status.name}'),
        ),
      ),
    );
  }
}
