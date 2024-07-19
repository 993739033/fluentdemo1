import 'package:fluent_ui/fluent_ui.dart';
import 'package:fluentdemo1/config/AppThemeConfig.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_acrylic/window_effect.dart';
import 'package:provider/provider.dart';

import '../../generated/l10n.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

const List<String> accentColorNames = [
  'System',
  'Yellow',
  'Orange',
  'Red',
  'Magenta',
  'Purple',
  'Blue',
  'Teal',
  'Green',
];

bool get kIsWindowEffectsSupported {
  return !kIsWeb &&
      [
        TargetPlatform.windows,
        TargetPlatform.linux,
        TargetPlatform.macOS,
      ].contains(defaultTargetPlatform);
}

List<WindowEffect> get currentWindowEffects {
  if (kIsWeb) return [];

  if (defaultTargetPlatform == TargetPlatform.windows) {
    return _WindowsWindowEffects;
  } else if (defaultTargetPlatform == TargetPlatform.linux) {
    return _LinuxWindowEffects;
  } else if (defaultTargetPlatform == TargetPlatform.macOS) {
    return _MacosWindowEffects;
  }

  return [];
}

const _LinuxWindowEffects = [
  WindowEffect.disabled,
  WindowEffect.transparent,
];

const _WindowsWindowEffects = [
  WindowEffect.disabled,
  WindowEffect.solid,
  WindowEffect.transparent,
  WindowEffect.aero,
  WindowEffect.acrylic,
  WindowEffect.mica,
  WindowEffect.tabbed,
];

const _MacosWindowEffects = [
  WindowEffect.disabled,
  WindowEffect.titlebar,
  WindowEffect.selection,
  WindowEffect.menu,
  WindowEffect.popover,
  WindowEffect.sidebar,
  WindowEffect.headerView,
  WindowEffect.sheet,
  WindowEffect.windowBackground,
  WindowEffect.hudWindow,
  WindowEffect.fullScreenUI,
  WindowEffect.toolTip,
  WindowEffect.contentBackground,
  WindowEffect.underWindowBackground,
  WindowEffect.underPageBackground,
];

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    var appThemeConfig = context.watch<AppThemeConfig>();
    var s = S.of(context);
    var supportLocalList = S.delegate.supportedLocales;
    const spacer = SizedBox(height: 10.0);
    const biggerSpacer = SizedBox(height: 40.0);

    return ScaffoldPage.scrollable(
        header: PageHeader(
          title: Text("Setting"),
        ),
        children: [
          Text('Theme mode',
              style: FluentTheme.of(context).typography.subtitle),
          spacer,
          ...List.generate(ThemeMode.values.length, (index) {
            final mode = ThemeMode.values[index];
            return Padding(
              padding: const EdgeInsetsDirectional.only(bottom: 8),
              child: RadioButton(
                checked: appThemeConfig.mode == mode,
                onChanged: (v) {
                  if (v) {
                    appThemeConfig.mode = mode;
                    if (kIsWindowEffectsSupported) {
                      appThemeConfig.setEffect(
                          appThemeConfig.windowEffect, context);
                    }
                  }
                },
                content: Text('$mode'.replaceAll('ThemeMode.', '')),
              ),
            );
          }),
          biggerSpacer,
          Text(
            'Navigation Pane Display Mode',
            style: FluentTheme.of(context).typography.subtitle,
          ),
          spacer,
          ...List.generate(PaneDisplayMode.values.length, (index) {
            final panMode = PaneDisplayMode.values[index];
            return Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: RadioButton(
                checked: appThemeConfig.displayMode == panMode,
                onChanged: (v) {
                  if (v) {
                    appThemeConfig.displayMode = panMode;
                  }
                },
                content:
                    Text(panMode.toString().replaceAll("PaneDisplayMode.", "")),
              ),
            );
          }),
          biggerSpacer,
          Text(
            'Navigation Indicator',
            style: FluentTheme.of(context).typography.subtitle,
          ),
          spacer,
          ...List.generate(NavigationIndicators.values.length, (index) {
            final indicatorMode = NavigationIndicators.values[index];
            return Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: RadioButton(
                checked: appThemeConfig.indicator == indicatorMode,
                onChanged: (v) {
                  if (v) {
                    appThemeConfig.indicator = indicatorMode;
                  }
                },
                content: Text(indicatorMode.toString()),
              ),
            );
          }),
          biggerSpacer,
          Text(
            'AccentColors',
            style: FluentTheme.of(context).typography.subtitle,
          ),
          spacer,
          Wrap(
            children: [
              ...List.generate(Colors.accentColors.length, (index) {
                final color = Colors.accentColors[index];
                return Tooltip(
                  message: "${color.toString()}",
                  child: _buildColorBlock(appThemeConfig, color),
                );
              })
            ],
          ),
          biggerSpacer,
          Text(
            'Effects',
            style: FluentTheme.of(context).typography.subtitle,
          ),
          if (kIsWindowEffectsSupported) ...[
            biggerSpacer,
            Text(
              'Window Transparency (${defaultTargetPlatform.toString().replaceAll('TargetPlatform.', '')})',
              style: FluentTheme.of(context).typography.subtitle,
            ),
            spacer,
            ...List.generate(currentWindowEffects.length, (index) {
              final mode = currentWindowEffects[index];
              return Padding(
                padding: const EdgeInsetsDirectional.only(bottom: 8.0),
                child: RadioButton(
                  checked: appThemeConfig.windowEffect == mode,
                  onChanged: (value) {
                    if (value) {
                      appThemeConfig.windowEffect = mode;
                      appThemeConfig.setEffect(mode, context);
                    }
                  },
                  content: Text(
                    mode.toString().replaceAll('WindowEffect.', ''),
                  ),
                ),
              );
            }),
            biggerSpacer,
          ],
          Text('Text Direction',
              style: FluentTheme.of(context).typography.subtitle),
          spacer,
          ...List.generate(TextDirection.values.length, (index) {
            final direction = TextDirection.values[index];
            return Padding(
              padding: const EdgeInsetsDirectional.only(bottom: 8.0),
              child: RadioButton(
                checked: appThemeConfig.textDirection == direction,
                onChanged: (value) {
                  if (value) {
                    appThemeConfig.textDirection = direction;
                  }
                },
                content: Text(
                  '$direction'
                      .replaceAll('TextDirection.', '')
                      .replaceAll('rtl', 'Right to left')
                      .replaceAll('ltr', 'Left to right'),
                ),
              ),
            );
          }),
          biggerSpacer,
          Text(s.localesetting,
              style: FluentTheme.of(context).typography.subtitle),
          spacer,
          Wrap(
            spacing: 15.0,
            runSpacing: 10.0,
            children: List.generate(
              supportLocalList.length,
              (index) {
                final locale = supportLocalList[index];
                return Padding(
                  padding: const EdgeInsetsDirectional.only(bottom: 8.0),
                  child: RadioButton(
                    checked: appThemeConfig.locale == locale,
                    onChanged: (value) {
                      if (value) {
                        appThemeConfig.locale = locale;
                      }
                    },
                    content: Text('$locale'),
                  ),
                );
              },
            ),
          ),
        ]);
  }
}

Widget _buildColorBlock(AppThemeConfig config, AccentColor color) {
  return Padding(
    padding: EdgeInsets.all(2),
    child: Button(
      onPressed: () {
        config.color = color;
      },
      style: ButtonStyle(
          padding: ButtonState.all(EdgeInsets.zero),
          backgroundColor: ButtonState.resolveWith((states) {
            if (states.isPressing) {
              return color.light;
            } else if (states.isHovering) {
              return color.lighter;
            }
            return color;
          })),
      child: Container(
        height: 40,
        width: 40,
        alignment: AlignmentDirectional.center,
        child: config.color == color
            ? Icon(FluentIcons.check_mark,
                color: color.basedOnLuminance(), size: 22)
            : null,
      ),
    ),
  );
}
