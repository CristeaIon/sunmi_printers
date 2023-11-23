import 'package:flutter_test/flutter_test.dart';
import 'package:sunmi_printers/sunmi_printers.dart';
import 'package:sunmi_printers/sunmi_printers_platform_interface.dart';
import 'package:sunmi_printers/sunmi_printers_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockSunmiPrintersPlatform with MockPlatformInterfaceMixin implements SunmiPrintersPlatform {
  @override
  Future<bool> hasPrinter() => Future.value(false);

  @override
  Future<PrinterStatus> getPrinterStatus() {
    return Future.value(PrinterStatus.unknown);
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
