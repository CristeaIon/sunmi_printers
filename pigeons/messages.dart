import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(PigeonOptions(
  dartOut: 'lib/src/messages.dart',
  dartOptions: DartOptions(),
  kotlinOut: 'android/src/main/kotlin/com/example/sunmi_printers/Messages.g.kt',
  kotlinOptions: KotlinOptions(),
  dartPackageName: 'sunmi_printers',
))
@HostApi()
abstract class SunmiPrinterApi {
  bool hasPrinter();

  int? getPrinterStatus();

  void printerInit();

  void printerSelfChecking();

  String? getPrinterSerialNumber();

  String? getPrinterModal();

  String? getPrinterVersion();

  String? getServiceVersion();

  int? getPrintedLength();

  int? getPrinterPaper();

  void printText(String text);

  void sendRAWData(Uint8List bytes);

  void setPrinterStyle(int key, int value);

  int? getPrinterMode();

  int? getPrinterBBMDistance();

  void setAlignment(int alignment);
}
