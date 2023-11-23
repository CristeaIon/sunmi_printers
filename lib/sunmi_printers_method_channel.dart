import 'package:flutter/foundation.dart';
import 'package:sunmi_printers/src/messages.dart';

import 'sunmi_printers_platform_interface.dart';

/// An implementation of [SunmiPrintersPlatform] that uses method channels.
class MethodChannelSunmiPrinters extends SunmiPrintersPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final api = SunmiPrinterApi();

  @override
  Future<bool> hasPrinter() async {
    return await api.hasPrinter();
  }

  @override
  Future<PrinterStatus> getPrinterStatus() {
    return api.getPrinterStatus();
  }
}
