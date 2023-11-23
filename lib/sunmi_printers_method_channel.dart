// import 'package:flutter/foundation.dart';
import 'dart:typed_data';

import 'package:sunmi_printers/src/enums/text_alignment.dart';
import 'package:sunmi_printers/src/messages.dart';

import 'src/enums/printer_status.dart';
import 'sunmi_printers_platform_interface.dart';

/// An implementation of [SunmiPrintersPlatform] that uses method channels.
class MethodChannelSunmiPrinters extends SunmiPrintersPlatform {
  /// The method channel used to interact with the native platform.
  // @visibleForTesting
  final api = SunmiPrinterApi();

  @override
  Future<bool> hasPrinter() async {
    return await api.hasPrinter();
  }

  @override
  Future<PrinterStatus> getPrinterStatus() async {
    final statusCode = await api.getPrinterStatus();
    return switch (statusCode) {
      1 => PrinterStatus.NORMAL,
      2 => PrinterStatus.PREPARING,
      3 => PrinterStatus.ABNORMAL_COMUNICATION,
      4 => PrinterStatus.OUT_OF_PAPER,
      5 => PrinterStatus.OVERHEATED,
      6 => PrinterStatus.OPENED_LID,
      7 => PrinterStatus.ABNORMAL_CUTTER,
      8 => PrinterStatus.CUTTER_RECOVERED,
      9 => PrinterStatus.NO_BLACK_MARK,
      505 => PrinterStatus.NOT_DETECTED,
      507 => PrinterStatus.FAILED_FIRMWARE_UPGRADE,
      _ => PrinterStatus.UNKNOWN,
    };
  }

  @override
  Future<void> printerInit() {
    return api.printerInit();
  }

  @override
  Future<void> printerSelfChecking() {
    return api.printerSelfChecking();
  }

  @override
  Future<String?> getPrinterSerialNumber() {
    return api.getPrinterSerialNumber();
  }

  @override
  Future<String?> getPrinterModal() {
    return api.getPrinterModal();
  }

  @override
  Future<String?> getPrinterVersion() {
    return api.getPrinterVersion();
  }

  @override
  Future<String?> getServiceVersion() {
    return api.getServiceVersion();
  }

  @override
  Future<int?> getPrintedLength() {
    return api.getPrintedLength();
  }

  @override
  Future<int?> getPrinterPaper() {
    return api.getPrinterPaper();
  }

  @override
  Future<void> printText(String text) {
    return api.printText(text);
  }

  @override
  Future<void> sendRAWData(Uint8List bytes) {
    return api.sendRAWData(bytes);
  }

  @override
  Future<void> setPrinterStyle(int key, int value) {
    return api.setPrinterStyle(key, value);
  }

  @override
  Future<int?> getPrinterMode() {
    return api.getPrinterMode();
  }

  @override
  Future<int?> getPrinterBBMDistance() {
    return api.getPrinterBBMDistance();
  }

  @override
  Future<void> setAlignment(TextAlignment alignment) {
    return api.setAlignment(switch (alignment) {
      TextAlignment.LEFT => 0,
      TextAlignment.CENTER => 1,
      TextAlignment.RIGHT => 2,
    });
  }
}
