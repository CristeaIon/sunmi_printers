import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(PigeonOptions(
  dartOut: 'lib/src/messages.dart',
  dartOptions: DartOptions(),
  kotlinOut: 'android/src/main/kotlin/com/example/sunmi_printers/Messages.g.kt',
  kotlinOptions: KotlinOptions(),
  dartPackageName: 'sunmi_printers',
))
enum PrinterStatus { unknown, normal, outOfPaper, }

@HostApi()
abstract class SunmiPrinterApi {
  
  bool hasPrinter();

  
  PrinterStatus getPrinterStatus();
}
