import 'dart:typed_data';

import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:sunmi_printers/src/enums/text_alignment.dart';

import 'src/enums/printer_status.dart';
import 'sunmi_printers_method_channel.dart';

abstract class SunmiPrintersPlatform extends PlatformInterface {
  /// Constructs a SunmiPrintersPlatform.
  SunmiPrintersPlatform() : super(token: _token);

  static final Object _token = Object();

  static SunmiPrintersPlatform _instance = MethodChannelSunmiPrinters();

  /// The default instance of [SunmiPrintersPlatform] to use.
  ///
  /// Defaults to [MethodChannelSunmiPrinters].
  static SunmiPrintersPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [SunmiPrintersPlatform] when
  /// they register themselves.
  static set instance(SunmiPrintersPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<bool> hasPrinter() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<PrinterStatus> getPrinterStatus() {
    throw UnimplementedError('getPrinterStatus() has not been implemented.');
  }

  Future<void> printerInit() {
    throw UnimplementedError('printerInit() has not been implemented.');
  }

  Future<void> printerSelfChecking() {
    throw UnimplementedError('printerSelfChecking() has not been implemented.');
  }

  Future<String?> getPrinterSerialNumber() {
    throw UnimplementedError('getPrinterSerialNumber() has not been implemented.');
  }

  Future<String?> getPrinterModal() {
    throw UnimplementedError('getPrinterModal() has not been implemented.');
  }

  Future<String?> getPrinterVersion() {
    throw UnimplementedError('getPrinterVersion() has not been implemented.');
  }

  Future<String?> getServiceVersion() {
    throw UnimplementedError('getServiceVersion() has not been implemented.');
  }

  Future<int?> getPrintedLength() {
    throw UnimplementedError('getPrintedLength() has not been implemented.');
  }

  Future<int?> getPrinterPaper() {
    throw UnimplementedError('getPrinterPaper() has not been implemented.');
  }

  Future<void> printText(String text) {
    throw UnimplementedError('printText() has not been implemented.');
  }

  Future<void> sendRAWData(Uint8List bytes) {
    throw UnimplementedError('sendRAWData() has not been implemented.');
  }

  Future<void> setPrinterStyle(int key, int value) {
    throw UnimplementedError('setPrinterStyle() has not been implemented.');
  }

  Future<int?> getPrinterMode() {
    throw UnimplementedError('getPrinterMode() has not been implemented.');
  }

  Future<int?> getPrinterBBMDistance() {
    throw UnimplementedError('getPrinterBBMDistance() has not been implemented.');
  }

  Future<void> setAlignment(TextAlignment alignment) {
    throw UnimplementedError('setAlignment() has not been implemented.');
  }
}
