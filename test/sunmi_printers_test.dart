import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:sunmi_printers/src/utils/table_column.dart';
import 'package:sunmi_printers/sunmi_printers.dart';
import 'package:sunmi_printers/sunmi_printers_platform_interface.dart';
import 'package:sunmi_printers/sunmi_printers_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockSunmiPrintersPlatform with MockPlatformInterfaceMixin implements SunmiPrintersPlatform {
  @override
  Future<bool> hasPrinter() => Future.value(false);

  @override
  Future<PrinterStatus> getPrinterStatus() {
    return Future.value(PrinterStatus.UNKNOWN);
  }

  @override
  Future<int?> getPrintedLength() {
    throw UnimplementedError();
  }

  @override
  Future<int?> getPrinterBBMDistance() {
    throw UnimplementedError();
  }

  @override
  Future<String?> getPrinterModal() {
    throw UnimplementedError();
  }

  @override
  Future<int?> getPrinterMode() {
    throw UnimplementedError();
  }

  @override
  Future<int?> getPrinterPaper() {
    throw UnimplementedError();
  }

  @override
  Future<String?> getPrinterSerialNumber() {
    throw UnimplementedError();
  }

  @override
  Future<String?> getPrinterVersion() {
    throw UnimplementedError();
  }

  @override
  Future<String?> getServiceVersion() {
    throw UnimplementedError();
  }

  @override
  Future<void> printText(String text) {
    throw UnimplementedError();
  }

  @override
  Future<void> printerInit() {
    throw UnimplementedError();
  }

  @override
  Future<void> printerSelfChecking() {
    throw UnimplementedError();
  }

  @override
  Future<void> sendRAWData(Uint8List bytes) {
    throw UnimplementedError();
  }

  @override
  Future<void> setAlignment(TextAlignment alignment) {
    throw UnimplementedError();
  }

  @override
  Future<void> setPrinterStyle(int key, int value) {
    throw UnimplementedError();
  }

  @override
  Future<void> printColumnsString(List<TableColumn> columns) {
    throw UnimplementedError();
  }

  @override
  Future<void> printColumnsText(List<TableColumn> columns) {
    throw UnimplementedError();
  }

  @override
  Future<void> printImage(Uint8List image) {
    throw UnimplementedError();
  }

  @override
  Future<void> printImageCustom(Uint8List image) {
    throw UnimplementedError();
  }
  
  @override
  Future<void> commitPrinterBuffer() {
    throw UnimplementedError();
  }
  
  @override
  Future<void> enterPrinterBuffer(bool clean) {
    throw UnimplementedError();
  }
  
  @override
  Future<void> exitPrinterBuffer(bool commit) {
    throw UnimplementedError();
  }
  
  @override
  Future<void> lineWrap(int lines) {
    throw UnimplementedError();
  }
  
  @override
  Future<void> printBarCode(Uint8List image) {
    // TODO: implement printBarCode
    throw UnimplementedError();
  }
  
  @override
  Future<void> printQrCode(Uint8List image) {
    // TODO: implement printQrCode
    throw UnimplementedError();
  }
}

void main() {
  final SunmiPrintersPlatform initialPlatform = SunmiPrintersPlatform.instance;

  test('$MethodChannelSunmiPrinters is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelSunmiPrinters>());
  });

  test('getPlatformVersion', () async {
    SunmiPrinters sunmiPrintersPlugin = SunmiPrinters();
    MockSunmiPrintersPlatform fakePlatform = MockSunmiPrintersPlatform();
    SunmiPrintersPlatform.instance = fakePlatform;

    expect(await sunmiPrintersPlugin.hasPrinter(), false);
  });
}
