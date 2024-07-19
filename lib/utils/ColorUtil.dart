import 'dart:math';
import 'dart:ui';

class ColorUtil {
  static Color getRandomColor() {
    return Color.fromARGB(
      255, // 不透明度（0到255）
      Random().nextInt(255), // 红色（0到255）
      Random().nextInt(255), // 绿色（0到255）
      Random().nextInt(255), // 蓝色（0到255）
    );
  }
}
