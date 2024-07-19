import 'dart:convert';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:fluentdemo1/states/base/BaseNotifier.dart';
import 'package:fluentdemo1/utils/LogUtil.dart';
import 'package:fluentdemo1/utils/sp/SpKey.dart';
import 'package:fluentdemo1/utils/sp/SpUtil.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:system_theme/system_theme.dart';
import 'package:window_manager/window_manager.dart';

import '../bean/AppConfigBean.dart';
import '../generated/l10n.dart';

enum NavigationIndicators { sticky, end }

class AppThemeConfig extends BaseNotifier<AppConfigBean> {

  //主题颜色
  AccentColor? _color;

  AccentColor get color => _color ?? systemAccentColor;

  set color(AccentColor value) {
    _color = value;
    notifyListeners();
  }

  //白天、黑夜模式切换
  ThemeMode _mode = ThemeMode.system;

  ThemeMode get mode => _mode;

  set mode(ThemeMode value) {
    _mode = value;
    notifyListeners();
  }

  //pane显示模式
  PaneDisplayMode _displayMode = PaneDisplayMode.auto;

  PaneDisplayMode get displayMode => _displayMode;

  set displayMode(PaneDisplayMode value) {
    _displayMode = value;
    notifyListeners();
  }

  //下标横线显示模式
  NavigationIndicators _indicator = NavigationIndicators.sticky;

  NavigationIndicators get indicator => _indicator;

  set indicator(NavigationIndicators value) {
    _indicator = value;
    notifyListeners();
  }

  //界面亚克力风格接入
  WindowEffect _windowEffect = WindowEffect.disabled;

  WindowEffect get windowEffect => _windowEffect;

  set windowEffect(WindowEffect value) {
    _windowEffect = value;
    notifyListeners();
  }

  void setEffect(WindowEffect effect, BuildContext context) {
    Window.setEffect(
      effect: effect,
      color: [
        WindowEffect.solid,
        WindowEffect.acrylic,
      ].contains(effect)
          ? FluentTheme.of(context).micaBackgroundColor.withOpacity(0.05)
          : Colors.transparent,
      dark: FluentTheme.of(context).brightness.isDark,
    );
  }

  //文字方向
  TextDirection _textDirection = TextDirection.ltr;

  TextDirection get textDirection => _textDirection;

  set textDirection(TextDirection value) {
    _textDirection = value;
    notifyListeners();
  }

  Locale? _locale;

  Locale? get locale => _locale;

  set locale(Locale? value) {
    _locale = value;
    notifyListeners();
  }

  @override
  Future<AppConfigBean> init() async {
    try{
      var _config = await SpUtil.getString(SpKey.APP_CONFIG);
      LogUtil.e("load Config:  ${_config}");
      if (_config != "" && _config != "null") {
        try {
          data = AppConfigBean.fromJson(jsonDecode(_config));
        } catch (e) {
          data = AppConfigBean();
          LogUtil.e("err: ${e.toString()}");
        }
      } else {
        data = AppConfigBean();
      }
      this._color = data.colorIndex != -1
          ? Colors.accentColors[data.colorIndex]
          : systemAccentColor;
      this._mode = ThemeMode.values[data.themeModeIndex];
      this._displayMode = PaneDisplayMode.values[data.panDisplayModeIndex];
      this._indicator = NavigationIndicators.values[data.naviagtionIndicatorsModeIndex];
      this._windowEffect = WindowEffect.values[data.windowEffectModeIndex];
      this._textDirection = TextDirection.values[data.textDirectionModeIndex];
      this._locale = S.delegate.supportedLocales[data.localeIndex!=-1?data.localeIndex:0];
      notifyListeners();
    }catch(e){
      LogUtil.e("err: ${e.toString()}");
    }
    return data;
  }

  @override
  void saveData(AppConfigBean data) async {
    LogUtil.e("Config Saving");
    try{
      data.colorIndex = Colors.accentColors.indexOf(color);
      data.themeModeIndex = this.mode.index;
      data.panDisplayModeIndex = this.displayMode.index;
      data.naviagtionIndicatorsModeIndex = this.indicator.index;
      data.windowEffectModeIndex = this.windowEffect.index;
      data.textDirectionModeIndex = this.textDirection.index;
      data.localeIndex = S.delegate.supportedLocales
          .indexOf(this.locale ?? Locale("zh"));
      if(!kIsWeb) {
        Size windowSize =  await windowManager.getSize();
        data.window_w = windowSize.width.toInt();
        data.window_h=windowSize.height.toInt();
      }
      await SpUtil.setString(SpKey.APP_CONFIG, jsonEncode(data));
    }catch(e){
      LogUtil.e("config save err:${e.toString()}");
    }
    LogUtil.e("save Config:  ${await SpUtil.getString(SpKey.APP_CONFIG)}");
  }

}

//获取系统颜色集合
AccentColor get systemAccentColor {
  if ((defaultTargetPlatform == TargetPlatform.windows ||
          defaultTargetPlatform == TargetPlatform.android) &&
      !kIsWeb) {
    return AccentColor.swatch({
      'darkest': SystemTheme.accentColor.darkest,
      'darker': SystemTheme.accentColor.darker,
      'dark': SystemTheme.accentColor.dark,
      'normal': SystemTheme.accentColor.accent,
      'light': SystemTheme.accentColor.light,
      'lighter': SystemTheme.accentColor.lighter,
      'lightest': SystemTheme.accentColor.lightest,
    });
  }
  return Colors.blue;
}
