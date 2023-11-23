import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:sunmi_printers/src/messages.dart';

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
}
