import 'package:json_annotation/json_annotation.dart';

part 'AppConfigBean.g.dart';

//dart run build_runner build
@JsonSerializable()
class AppConfigBean {
  int colorIndex = -1;
  int themeModeIndex = 0;
  int panDisplayModeIndex = 0;
  int naviagtionIndicatorsModeIndex = 0;
  int windowEffectModeIndex = 0;
  int textDirectionModeIndex = 1;
  int localeIndex = 0;
  int window_w = 500;
  int window_h = 600;

  AppConfigBean(
      {this.colorIndex = -1,
      this.themeModeIndex = 0,
      this.panDisplayModeIndex = 4,
      this.naviagtionIndicatorsModeIndex = 0,
      this.windowEffectModeIndex = 0,
      this.textDirectionModeIndex = 1,
      this.localeIndex = 0,
      this.window_w = 500,
      this.window_h = 600});

  factory AppConfigBean.fromJson(Map<String, dynamic> json) =>
      _$AppConfigBeanFromJson(json);

  Map<String, dynamic> toJson() => _$AppConfigBeanToJson(this);
}
