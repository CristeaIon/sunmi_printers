import 'dart:typed_data';

import 'src/enums/printer_status.dart';
import 'src/enums/text_alignment.dart';
import 'sunmi_printers_platform_interface.dart';

export 'src/enums/printer_status.dart';
export 'src/enums/text_alignment.dart';

class SunmiPrinters {
  Future<bool> hasPrinter() {
    return SunmiPrintersPlatform.instance.hasPrinter();
  }

  Future<PrinterStatus> getPrinterStatus() {
    return SunmiPrintersPlatform.instance.getPrinterStatus();
  }

  Future<void> printerInit() {
    return SunmiPrintersPlatform.instance.printerInit();
  }

  Future<void> printerSelfChecking() {
    return SunmiPrintersPlatform.instance.printerSelfChecking();
  }

  Future<String?> getPrinterSerialNumber() {
    return SunmiPrintersPlatform.instance.getPrinterSerialNumber();
  }

  Future<String?> getPrinterModal() {
    return SunmiPrintersPlatform.instance.getPrinterModal();
  }

  Future<String?> getPrinterVersion() {
    return SunmiPrintersPlatform.instance.getPrinterVersion();
  }

  Future<String?> getServiceVersion() {
    return SunmiPrintersPlatform.instance.getServiceVersion();
  }

  Future<int?> getPrintedLength() {
    return SunmiPrintersPlatform.instance.getPrintedLength();
  }

  Future<int?> getPrinterPaper() {
    return SunmiPrintersPlatform.instance.getPrinterPaper();
  }

  Future<void> printText(String text) {
    return SunmiPrintersPlatform.instance.printText(text);
  }

  Future<void> sendRawData(Uint8List bytes) {
    return SunmiPrintersPlatform.instance.sendRAWData(bytes);
  }

  Future<void> setPrinterStyle(int key, int value) {
    return SunmiPrintersPlatform.instance.setPrinterStyle(key, value);
  }

  Future<int?> getPrinterMode() {
    return SunmiPrintersPlatform.instance.getPrinterMode();
  }

  Future<int?> getPrinterBBMDistance() {
    return SunmiPrintersPlatform.instance.getPrinterBBMDistance();
  }

  Future<void> setAlignment(TextAlignment alignment) {
    return SunmiPrintersPlatform.instance.setAlignment(alignment);
  }
}
