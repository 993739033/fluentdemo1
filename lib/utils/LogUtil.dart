import 'package:logger/logger.dart';

class LogUtil{
  static final Logger logger = new Logger();

  static void e(String error){
    logger.e(error);
  }

  static void w(String warn){
    logger.w(warn);
  }

  static void info(String info){
    logger.i(info);
  }
}