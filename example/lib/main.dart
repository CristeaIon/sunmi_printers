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
  PrinterStatus _status = PrinterStatus.UNKNOWN;
  String? _serial = 'unknown';
  String? _modal = 'unknown';
  String? _version = 'unknown';
  String? _serviceVersion = 'unknown';
  int? _paper = 0;
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
    String? serial;
    String? modal;
    String? version;
    String? serviceVersion;
    int? paper;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      hasPrinter = await _sunmiPrintersPlugin.hasPrinter();
      status = await _sunmiPrintersPlugin.getPrinterStatus();
      serial = await _sunmiPrintersPlugin.getPrinterSerialNumber();
      version = await _sunmiPrintersPlugin.getPrinterVersion();
      serviceVersion = await _sunmiPrintersPlugin.getServiceVersion();
      paper = await _sunmiPrintersPlugin.getPrinterPaper();
    } on PlatformException {
      hasPrinter = false;
      status = PrinterStatus.UNKNOWN;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _hasPrinter = hasPrinter;
      _status = status;
      _serial = serial;
      _modal = modal;
      _version = version;
      _serviceVersion = serviceVersion;
      _paper = paper;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Sunmi printer example'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Printer is connected: $_hasPrinter'),
              Text('Printer Status: ${_status.name}'),
              Text('Printer serial number: $_serial'),
              Text('Printer modal: $_modal'),
              Text('Printer version: $_version'),
              Text('Printer service version: $_serviceVersion'),
              Text('Printer paper: $_paper'),
              ElevatedButton(
                onPressed: () {
                  _sunmiPrintersPlugin.printText('text\n');
                },
                child: const Text('Print text'),
              ),
              ElevatedButton(
                onPressed: () {
                  _sunmiPrintersPlugin.printerSelfChecking();
                },
                child: const Text('Printer Self Checking'),
              ),
              ElevatedButton(
                onPressed: () {
                  _sunmiPrintersPlugin.startPrintTransaction(true);
                  _sunmiPrintersPlugin.printColumnsText(List.generate(4, (index) {
                    return TableColumn(text: 'cl $index', width: 8);
                  }));
                  _sunmiPrintersPlugin.commitPrintTransaction();
                  _sunmiPrintersPlugin.exitPrintTransaction(true);
                },
                child: const Text('Print table'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
