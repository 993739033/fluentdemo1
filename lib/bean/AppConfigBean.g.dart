// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AppConfigBean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppConfigBean _$AppConfigBeanFromJson(Map<String, dynamic> json) =>
    AppConfigBean(
      colorIndex: (json['colorIndex'] as num?)?.toInt() ?? -1,
      themeModeIndex: (json['themeModeIndex'] as num?)?.toInt() ?? 0,
      panDisplayModeIndex: (json['panDisplayModeIndex'] as num?)?.toInt() ?? 0,
      naviagtionIndicatorsModeIndex:
          (json['naviagtionIndicatorsModeIndex'] as num?)?.toInt() ?? 0,
      windowEffectModeIndex:
          (json['windowEffectModeIndex'] as num?)?.toInt() ?? 0,
      textDirectionModeIndex:
          (json['textDirectionModeIndex'] as num?)?.toInt() ?? 0,
      localeIndex: (json['localeIndex'] as num?)?.toInt() ?? 0,
      window_w: (json['window_w'] as num?)?.toInt() ?? 500,
      window_h: (json['window_h'] as num?)?.toInt() ?? 600,
    );

Map<String, dynamic> _$AppConfigBeanToJson(AppConfigBean instance) =>
    <String, dynamic>{
      'colorIndex': instance.colorIndex,
      'themeModeIndex': instance.themeModeIndex,
      'panDisplayModeIndex': instance.panDisplayModeIndex,
      'naviagtionIndicatorsModeIndex': instance.naviagtionIndicatorsModeIndex,
      'windowEffectModeIndex': instance.windowEffectModeIndex,
      'textDirectionModeIndex': instance.textDirectionModeIndex,
      'localeIndex': instance.localeIndex,
      'window_w': instance.window_w,
      'window_h': instance.window_h,
    };
