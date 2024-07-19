import 'dart:ui';

extension stringEx on String {
  Color? colorFromHex() {
    var hexColor = this.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return Color(int.parse(hexColor, radix: 16));
  }
}
