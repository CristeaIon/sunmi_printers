import '../../sunmi_printers.dart';

class TableColumn {
  final String text;
  final int width;
  final TextAlignment align;

  TableColumn({
    required this.text,
    required this.width,
    this.align = TextAlignment.LEFT,
  });
}
