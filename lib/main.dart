import 'package:fluentdemo1/config/AppThemeConfig.dart';
import 'package:fluentdemo1/screens/home/home.dart';
import 'package:fluentdemo1/utils/LogUtil.dart';
import 'package:fluentdemo1/widgets/deferred_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:system_theme/system_theme.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart' as flutter_acrylic;
import 'package:url_launcher/url_launcher.dart';
import 'package:window_manager/window_manager.dart';
import 'package:provider/provider.dart';
import 'generated/l10n.dart';
import 'routes/inputs.dart' deferred as inputs;
import 'routes/forms.dart' deferred as forms;
import 'routes/navigations.dart' deferred as navigations;
import 'routes/popups.dart' deferred as popups;
import 'routes/surfaces.dart' deferred as surfaces;
import 'routes/themes.dart' deferred as themes;
import 'routes/settings.dart' deferred as settings;
import 'package:fluent_ui/fluent_ui.dart' hide Page;

import 'package:go_router/go_router.dart';

const String appTitle = 'FluentDemo1';

bool get isDesktop {
  if (kIsWeb) return false;
  return [TargetPlatform.windows, TargetPlatform.linux, TargetPlatform.macOS]
      .contains(defaultTargetPlatform);
}

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  if (!kIsWeb &&
      [TargetPlatform.windows, TargetPlatform.android]
          .contains(defaultTargetPlatform)) {
    SystemTheme.accentColor.load();
  }

  if (isDesktop) {
    await flutter_acrylic.Window.initialize();
    await flutter_acrylic.Window.hideWindowControls();
    await WindowManager.instance.ensureInitialized();
    windowManager.waitUntilReadyToShow().then((value) async {
      //隐藏window bar一层ui显示
      await windowManager.setTitleBarStyle(TitleBarStyle.hidden,
          windowButtonVisibility: false);
      await windowManager.setMinimumSize(const Size(480, 600));
      await windowManager.show();
      await windowManager.setPreventClose(true); //预防点击关闭键退出
      await windowManager.setSkipTaskbar(false); //是否隐藏图标在任务栏中
    });
  }
  AppThemeConfig().init().then((v) async {
    if (isDesktop) {
      await windowManager.setSize(Size(v.window_w * 1.0, v.window_h * 1.0));
    }
    runApp(const MyApp());
  });
  //延迟加载包
  Future.wait([
    DeferredWidget.preload(inputs.loadLibrary),
    DeferredWidget.preload(forms.loadLibrary),
    DeferredWidget.preload(navigations.loadLibrary),
    DeferredWidget.preload(popups.loadLibrary),
    DeferredWidget.preload(surfaces.loadLibrary),
    DeferredWidget.preload(themes.loadLibrary),
    DeferredWidget.preload(settings.loadLibrary),
  ]);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    LogUtil.e("Main Rebuild");
    FlutterNativeSplash.remove();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppThemeConfig()..init()),
      ],
      child: Consumer<AppThemeConfig>(
        builder: (BuildContext context, AppThemeConfig appThemeConfig,
            Widget? child) {
          appThemeConfig.temp = 3;
          return FluentApp.router(
            title: appTitle,
            themeMode: appThemeConfig.mode,
            debugShowCheckedModeBanner: false,
            color: appThemeConfig.color,
            localizationsDelegates: [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            localeResolutionCallback: (_locale, supportedLocales) {
              //开始时会返回系统支持的_locale 之后会调用local:的设置
              if (appThemeConfig.locale != null) {
                return appThemeConfig.locale;
              } else {
                Locale locale;
                if (supportedLocales.contains(_locale)) {
                  locale = _locale!;
                } else {
                  //如果系统语言不是中文简体或英语，则默认使用英语
                  locale = Locale('en');
                }
                // LogUtil.e("locale:${_locale!.languageCode}");
                return locale;
              }
            },
            theme: FluentThemeData(
                fontFamily: "YozaiMedium",
                accentColor: appThemeConfig.color,
                visualDensity: VisualDensity.standard,
                focusTheme: FocusThemeData(
                  glowFactor: is10footScreen(context) ? 2.0 : 0.0,
                )),
            darkTheme: FluentThemeData(
                fontFamily: "YozaiMedium",
                brightness: Brightness.dark,
                accentColor: appThemeConfig.color,
                visualDensity: VisualDensity.standard,
                focusTheme: FocusThemeData(
                    glowFactor: is10footScreen(context) ? 2.0 : 0.0)),
            locale: appThemeConfig.locale,
            routeInformationParser: router.routeInformationParser,
            routerDelegate: router.routerDelegate,
            routeInformationProvider: router.routeInformationProvider,
            builder: (context, child) {
              return Directionality(
                textDirection: appThemeConfig.textDirection,
                child: NavigationPaneTheme(
                  data: NavigationPaneThemeData(
                    backgroundColor: appThemeConfig.windowEffect !=
                            flutter_acrylic.WindowEffect.disabled
                        ? Colors.transparent
                        : null,
                  ),
                  child: child!,
                ),
              );
            },
          );
        },
      ),
    );
  }
}

final rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();
final router = GoRouter(navigatorKey: rootNavigatorKey, routes: [
  ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        return AppShell(child, _shellNavigatorKey.currentContext);
      },
      routes: [
        /// Home
        GoRoute(path: '/', builder: (context, state) => const HomePage()),

        ///Setting
        GoRoute(
          path: '/setting',
          builder: (context, state) => DeferredWidget(
            settings.loadLibrary,
            () => settings.SettingPage(),
          ),
        ),

        /// Inputs
        /// Button
        GoRoute(
          path: '/inputs/button',
          builder: (context, state) => DeferredWidget(
            inputs.loadLibrary,
            () => inputs.ButtonRoute(),
          ),
        ),

        /// InputOtherWidget
        GoRoute(
          path: '/inputs/inputwidgets',
          builder: (context, state) => DeferredWidget(
            inputs.loadLibrary,
            () => inputs.InputWidgets(),
          ),
        ),

        GoRoute(
          path: '/forms/formbox',
          builder: (context, state) => DeferredWidget(
            forms.loadLibrary,
            () => forms.FormBox(),
          ),
        ),

        GoRoute(
          path: '/forms/formpicker',
          builder: (context, state) => DeferredWidget(
            forms.loadLibrary,
            () => forms.FormPicker(),
          ),
        ),

        GoRoute(
          path: '/navigations/navigationview',
          builder: (context, state) => DeferredWidget(
            navigations.loadLibrary,
            () => navigations.NavigationView1(),
          ),
        ),

        GoRoute(
          path: '/popups/popupview',
          builder: (context, state) => DeferredWidget(
            popups.loadLibrary,
            () => popups.PopupView(),
          ),
        ),

        GoRoute(
          path: '/surfaces/surfaceview',
          builder: (context, state) => DeferredWidget(
            surfaces.loadLibrary,
            () => surfaces.SurfaceView(),
          ),
        ),

        GoRoute(
          path: '/themes/themeview',
          builder: (context, state) => DeferredWidget(
            themes.loadLibrary,
            () => themes.ThemeView(),
          ),
        ),
        GoRoute(
          path: '/themes/icons',
          builder: (context, state) => DeferredWidget(
            themes.loadLibrary,
            () => themes.IconsPage(),
          ),
        ),
        GoRoute(
          path: '/themes/reveal_focus',
          builder: (context, state) => DeferredWidget(
            themes.loadLibrary,
            () => themes.RevealFocusPage(),
          ),
        ),
      ])
]);

class AppShell extends StatefulWidget {
  final Widget child;
  final BuildContext? shellContext;

  AppShell(this.child, this.shellContext);

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> with WindowListener {
  final viewKey = GlobalKey(debugLabel: 'Navigation View Key');
  final searchKey = GlobalKey(debugLabel: 'Search Bar Key');
  final searchFocusNode = FocusNode();
  final searchController = TextEditingController();
  AppThemeConfig? appConfig;
  late S s;

  late final List<NavigationPaneItem> originalItems = [
    PaneItem(
      key: const ValueKey('/'),
      icon: const Icon(FluentIcons.home),
      title: const Text('Home'),
      body: const SizedBox.shrink(),
    ),
    PaneItemHeader(header: const Text('Inputs')),
    PaneItem(
      key: const ValueKey('/inputs/button'),
      icon: const Icon(FluentIcons.button_control),
      title: const Text('Button'),
      body: const SizedBox.shrink(),
    ),
    PaneItem(
      key: const ValueKey('/inputs/inputwidgets'),
      icon: const Icon(FluentIcons.album),
      title: const Text('InputWidgets'),
      body: const SizedBox.shrink(),
    ),
    PaneItemHeader(header: const Text('Forms')),
    PaneItem(
      key: const ValueKey('/forms/formbox'),
      icon: const Icon(FluentIcons.form_library),
      title: const Text('FormBox'),
      body: const SizedBox.shrink(),
    ),
    PaneItem(
      key: const ValueKey('/forms/formpicker'),
      icon: const Icon(FluentIcons.form_processing),
      title: const Text('FormPicker'),
      body: const SizedBox.shrink(),
    ),
    PaneItemHeader(header: const Text('Navigation')),
    PaneItem(
      infoBadge: const InfoBadge(source: Text('8')),
      key: const ValueKey('/navigations/navigationview'),
      icon: const Icon(FluentIcons.navigate_forward),
      title: const Text('NavigationView'),
      body: const SizedBox.shrink(),
    ),
    PaneItemHeader(header: const Text('Popup')),
    PaneItem(
      key: const ValueKey('/popups/popupview'),
      icon: const Icon(FluentIcons.pop_expand),
      title: const Text('PopupView'),
      body: const SizedBox.shrink(),
    ),
    PaneItemHeader(header: const Text('Surface')),
    PaneItem(
      key: const ValueKey('/surfaces/surfaceview'),
      icon: const Icon(FluentIcons.survey_questions),
      title: const Text('Surface'),
      body: const SizedBox.shrink(),
    ),
    PaneItemHeader(header: const Text('Theme')),
    PaneItem(
      key: const ValueKey('/themes/themeview'),
      icon: const Icon(FluentIcons.edit_style),
      title: const Text('Theme'),
      body: const SizedBox.shrink(),
    ),
    PaneItem(
      key: const ValueKey('/themes/icons'),
      icon: const Icon(FluentIcons.edit_style),
      title: const Text('Icons'),
      body: const SizedBox.shrink(),
    ),
    PaneItem(
      key: const ValueKey('/themes/reveal_focus'),
      icon: const Icon(FluentIcons.edit_style),
      title: const Text('RevealFocusPage'),
      body: const SizedBox.shrink(),
    ),
    PaneItemExpander(
      initiallyExpanded: true,
      icon: const Icon(FluentIcons.account_management),
      title: const Text('Account'),
      items: [
        PaneItem(
            title: Text("${s.moudlue1}"),
            icon: const Icon(FluentIcons.add_in),
            body: const SizedBox.shrink()),
        PaneItem(
            title: Text("${s.moudlue2}"),
            icon: const Icon(FluentIcons.add_phone),
            body: const SizedBox.shrink()),
        PaneItem(
            title: Text("${s.moudlue3}"),
            icon: const Icon(FluentIcons.add_phone),
            body: const SizedBox.shrink()),
      ],
      body: ScaffoldPage.withPadding(content: Text("Expander")),
    )
  ].map((e) {
    if (e is PaneItemExpander) {
      return e;
    } else if (e is PaneItem) {
      return PaneItem(
        infoBadge: e.infoBadge,
        key: e.key,
        icon: e.icon,
        title: e.title,
        body: e.body,
        onTap: () {
          final path = (e.key as ValueKey).value;
          if (GoRouterState.of(context).uri.toString() != path) {
            context.go(path);
          }
          e.onTap?.call();
        },
      );
    }
    return e;
  }).toList();

  late final List<NavigationPaneItem> footerItems = [
    PaneItemSeparator(),
    PaneItem(
      key: const ValueKey('/setting'),
      icon: const Icon(FluentIcons.settings),
      title: const Text('Setting'),
      body: const SizedBox.shrink(),
      onTap: () {
        if (GoRouterState.of(context).uri.toString() != '/setting') {
          context.go('/setting');
        }
      },
    ),
    PaneItem(
      icon: const Icon(FluentIcons.add),
      title: const Text('NewItem'),
      body: const SizedBox.shrink(),
      onTap: () {
        originalItems.add(PaneItem(
            title: const Text('A NewItem'),
            icon: const Icon(FluentIcons.indent_first_line),
            body: const SizedBox.shrink()));
        setState(() {});
      },
    ),
    _LinkPaneItemAction(
      icon: const Icon(FluentIcons.open_source),
      title: const Text('Source code'),
      link: '',
      body: const SizedBox.shrink(),
    ),
  ];

  //计算选中位置
  int _calculateSelectedIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    int indexOriginal = originalItems
        .where((item) => item.key != null)
        .toList()
        .indexWhere((item) => item.key == Key(location));

    if (indexOriginal == -1) {
      int indexFooter = footerItems
          .where((element) => element.key != null)
          .toList()
          .indexWhere((element) => element.key == Key(location));
      if (indexFooter == -1) {
        return 0;
      }
      return originalItems
              .where((element) => element.key != null)
              .toList()
              .length +
          indexFooter;
    } else {
      return indexOriginal;
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = FluentLocalizations.of(context);
    appConfig = context.watch<AppThemeConfig>();
    s = S.of(context);
    final theme = FluentTheme.of(context);
    if (widget.shellContext != null) {
      if (router.canPop() == false) {
        setState(() {});
      }
    }
    return Consumer<AppThemeConfig>(
      builder:
          (BuildContext context, AppThemeConfig appThemeConfig, Widget? child) {
        return NavigationView(
          key: viewKey,
          appBar: NavigationAppBar(
            automaticallyImplyLeading: false,
            leading: () {
              final enabled = widget.shellContext != null && router.canPop();
              final onPressed = enabled
                  ? () {
                      if (router.canPop()) {
                        context.pop();
                        setState(() {});
                      }
                    }
                  : null;
              return NavigationPaneTheme(
                data: NavigationPaneTheme.of(context)
                    .merge(NavigationPaneThemeData(
                  unselectedIconColor: ButtonState.resolveWith((states) {
                    if (states.isDisabled) {
                      return ButtonThemeData.buttonColor(context, states);
                    }
                    return ButtonThemeData.uncheckedInputColor(
                      FluentTheme.of(context),
                      states,
                    ).basedOnLuminance();
                  }),
                )),
                child: Builder(
                  //这里使用builder 方便获取到当前NavigationAppBar builderContext
                  builder: (context) => PaneItem(
                    icon: Center(
                        child: Icon(
                      FluentIcons.starburst_solid,
                      size: 24,
                    )),
                    title: Text(localizations.backButtonTooltip),
                    body: const SizedBox.shrink(),
                    enabled: enabled,
                  ).build(
                    context,
                    false,
                    onPressed,
                    displayMode: PaneDisplayMode.compact,
                  ),
                ),
              );
            }(),
            title: () {
              if (kIsWeb) {
                //web平台不拖动
                return const Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(appTitle),
                );
              }
              return const DragToMoveArea(
                child: Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(appTitle),
                ),
              );
            }(),
            actions: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(end: 8.0),
                  child: ToggleSwitch(
                    content: const Text('Dark Mode'),
                    checked: FluentTheme.of(context).brightness.isDark,
                    onChanged: (v) {
                      if (v) {
                        appThemeConfig.mode = ThemeMode.dark;
                      } else {
                        appThemeConfig.mode = ThemeMode.light;
                      }
                    },
                  ),
                ),
              ),
              if (!kIsWeb) const WindowButtons(),
            ]),
          ),
          paneBodyBuilder: (item, child) {
            final name =
                item?.key is ValueKey ? (item!.key as ValueKey).value : null;
            return FocusTraversalGroup(
                child: widget.child, key: ValueKey('body$name'));
          },
          pane: NavigationPane(
            selected: _calculateSelectedIndex(context),
            header: SizedBox(
              height: kOneLineTileHeight,
              child: ShaderMask(
                shaderCallback: (rect) {
                  final color = appThemeConfig.color.defaultBrushFor(
                    theme.brightness,
                  );
                  return LinearGradient(
                    colors: [
                      color,
                      color,
                    ],
                  ).createShader(rect);
                },
                child: const FlutterLogo(
                  style: FlutterLogoStyle.horizontal,
                  size: 80.0,
                  textColor: Colors.white,
                  duration: Duration.zero,
                ),
              ),
            ),
            displayMode: appThemeConfig.displayMode,
            indicator: () {
              switch (appThemeConfig.indicator) {
                case NavigationIndicators.end:
                  return const EndNavigationIndicator();
                case NavigationIndicators.sticky:
                default:
                  return const StickyNavigationIndicator();
              }
            }(),
            items: originalItems,
            autoSuggestBoxReplacement: const Icon(FluentIcons.search),
            autoSuggestBox: Builder(builder: (context) {
              return AutoSuggestBox(
                key: searchKey,
                focusNode: searchFocusNode,
                controller: searchController,
                unfocusedColor: Colors.transparent,
                items: originalItems.whereType<PaneItem>().map((item) {
                  assert(item.title is Text);
                  final text = (item.title as Text).data!;
                  return AutoSuggestBoxItem(
                    label: text,
                    value: text,
                    onSelected: () {
                      item.onTap?.call();
                      searchController.clear();
                      searchFocusNode.unfocus();
                      final view = NavigationView.of(context);
                      if (view.compactOverlayOpen) {
                        view.compactOverlayOpen = false;
                      } else if (view.minimalPaneOpen) {
                        view.minimalPaneOpen = false;
                      }
                    },
                  );
                }).toList(),
                trailingIcon: IgnorePointer(
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(FluentIcons.search),
                  ),
                ),
                placeholder: 'Search',
              );
            }),
            footerItems: footerItems,
          ),
          onOpenSearch: searchFocusNode.requestFocus,
        );
      },
    );
  }

  @override
  void initState() {
    windowManager.addListener(this);
    super.initState();
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    searchController.dispose();
    searchFocusNode.dispose();
    super.dispose();
  }

  @override
  void onWindowClose() async {
    bool isPreventClose = await windowManager.isPreventClose();
    if (isPreventClose && mounted) {
      showDialog(
        context: context,
        builder: (_) {
          return ContentDialog(
            title: const Text('Confirm close'),
            content: const Text('Are you sure you want to close this window?'),
            actions: [
              FilledButton(
                child: const Text('Yes'),
                onPressed: () {
                  Navigator.pop(context);
                  windowManager.destroy();
                },
              ),
              Button(
                child: const Text('No'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  void onWindowResized() {
    LogUtil.e("windowResized!");
    appConfig?.notifyListeners();
  }
}

class _LinkPaneItemAction extends PaneItem {
  _LinkPaneItemAction({
    required super.icon,
    required this.link,
    required super.body,
    super.title,
  });

  final String link;

  @override
  Widget build(
    BuildContext context,
    bool selected,
    VoidCallback? onPressed, {
    PaneDisplayMode? displayMode,
    bool showTextOnTop = true,
    bool? autofocus,
    int? itemIndex,
  }) {
    return Container(
      alignment: Alignment.center,
      child: GestureDetector(
        child: SizedBox(
          child: Image.asset(
            "assets/logo.jpeg",
          ),
          width: 30,
          height: 30,
        ),
        onTapUp: (v) {
          showDialog(
              context: context,
              builder: (context) {
                return ContentDialog(
                  title: Text("Download"),
                  content: Text("Download Windows Version?"),
                  actions: [
                    Button(
                      child: Text("Yes"),
                      onPressed: () {
                        Navigator.of(context).pop();
                        _launchURL();
                      },
                    ),
                    FilledButton(
                        child: Text("No"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        })
                  ],
                );
              });
        },
      ),
    );
  }
}

_launchURL() async {
  const url = 'https://joylinkx.xyz/upload/FluentDemo.zip';
  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url));
  } else {
    throw 'Could not launch $url';
  }
}

class WindowButtons extends StatelessWidget {
  const WindowButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final FluentThemeData theme = FluentTheme.of(context);
    return SizedBox(
      width: 138,
      height: 50,
      child: WindowCaption(
        brightness: theme.brightness,
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
