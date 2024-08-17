import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(PigeonOptions(
  dartOut: 'lib/src/messages.dart',
  dartOptions: DartOptions(),
  kotlinOut: 'android/src/main/kotlin/com/example/sunmi_printers/Messages.g.kt',
  kotlinOptions: KotlinOptions(),
  dartPackageName: 'sunmi_printers',
))
class TransBean {
  int? type;
  String? text;
  Uint8List? data;
  // int get datalength => data?.length ?? 0;
}

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

  void printColumnsText(List<String> columns, List<int> colsWidth, List<int> colsAlign);

  void printColumnsString(List<String> columns, List<int> colsWidth, List<int> colsAlign);

  void printBitmap(Uint8List image);

  void printBitmapCustom(Uint8List image, int type);

  void printBarCode(String data, int symbology, int height, int width, int textPosition);

  void printQrCode(String data, int moduleSize, int errorLevel);

  void print2DCode(String data, int symbology, int moduleSize, int errorLevel);

  void commitPrint(List<TransBean> transBean);

  void enterPrinterBuffer(bool clean);

  void exitPrinterBuffer(bool commit);

  void commitPrinterBuffer();

  void lineWrap(int lines);

  void setFontSize(int size);

  void setBold(bool bold);
}
