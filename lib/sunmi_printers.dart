import 'package:sunmi_printers/src/messages.dart';

import 'sunmi_printers_platform_interface.dart';
export 'src/messages.dart' show PrinterStatus;

class SunmiPrinters {
  Future<bool> hasPrinter() {
    return SunmiPrintersPlatform.instance.hasPrinter();
  }

  Future<PrinterStatus> getPrinterStatus() {
    return SunmiPrintersPlatform.instance.getPrinterStatus();
  }
}
