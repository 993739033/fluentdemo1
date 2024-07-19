import 'dart:math';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:fluentdemo1/main.dart';
import 'package:fluentdemo1/mixin/pagemixin.dart';
import 'package:fluentdemo1/utils/LogUtil.dart';
import 'package:fluentdemo1/widgets/card_highlight.dart';

class PopupView extends StatefulWidget {
  const PopupView({super.key});

  @override
  State<PopupView> createState() => _PopupViewState();
}

class _PopupViewState extends State<PopupView> with PageMixin {
  final icons = FluentIcons.allIcons.values;
  final attachKey1 = GlobalKey();
  final controller1 = FlyoutController();

  final attachKey2 = GlobalKey();
  final controller2 = FlyoutController();

  final attachKey3 = GlobalKey();
  final controller3 = FlyoutController();

  final contextController = FlyoutController();
  final contextAttachKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.scrollable(
        header: PageHeader(
          title: Text("Popup Example"),
        ),
        children: [
          subtitle(content: const Text("A Simple Popup")),
          description(content: const Text("Popup Performance")),
          CardHighlight(
              child: Row(
                children: [
                  Button(
                      child: Text("showDialog"),
                      onPressed: () async {
                        String? result = await showContentDialog(context);
                        LogUtil.e("Result $result");
                      })
                ],
              ),
              codeSnippet: '''
               Future<String?> showContentDialog(BuildContext context) async {
    return await showDialog<String>(
        context: context,
        builder: (context) {
          return ContentDialog(
            title: const Text("Are You Sure?"),
            content: Text("Do You Want?"),
            actions: [
              Button(child: Text("Ok"), onPressed: (){
                Navigator.pop(context,"enter");
              }),
              FilledButton(child: Text("No"), onPressed: (){
                Navigator.pop(context,"cancel");
              })
            ],
          );
        });
  }
          '''),
          subtitle(content: const Text("ToolTip")),
          CardHighlight(
              child: Row(
                children: [
                  ...List.generate(6, (index) {
                    var icon = icons.elementAt(Random().nextInt(icons.length));
                    return Tooltip(
                      message: "message${index}",
                      useMousePosition: false,
                      style: const TooltipThemeData(
                          preferBelow: true, waitDuration: Duration()),
                      child: IconButton(
                        icon: Icon(
                          icon,
                          size: 22,
                        ),
                        onPressed: () {},
                      ),
                    );
                  }),
                ],
              ),
              codeSnippet: '''
                  ...List.generate(6, (index) {
                    var icon = icons.elementAt(Random().nextInt(icons.length));
                    return Tooltip(
                      message: "message index",
                      useMousePosition: false,
                      style: const TooltipThemeData(
                          preferBelow: true, waitDuration: Duration()),
                      child: IconButton(
                        icon: Icon(
                          icon,
                          size: 25,
                        ),
                        onPressed: () {},
                      ),
                    );
                  })
          '''),
          subtitle(content: const Text("Flyout")),
          CardHighlight(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: FlyoutTarget(
                      key: attachKey1,
                      controller: controller1,
                      child: Container(
                        child: Button(
                          child: Text("ShowFlyout1"),
                          onPressed: () async {
                            LogUtil.e("flyout1 pressed");
                            controller1.showFlyout(
                                autoModeConfiguration: FlyoutAutoConfiguration(
                                    preferredMode:
                                        FlyoutPlacementMode.topCenter),
                                barrierDismissible: true,
                                dismissOnPointerMoveAway: false,
                                dismissWithEsc: true,
                                navigatorKey: rootNavigatorKey.currentState,
                                builder: (context) {
                                  return FlyoutContent(
                                      child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text("this is flyout"),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Button(
                                          child: Text("OK"),
                                          onPressed: () {
                                            Flyout.of(context).close();
                                          })
                                    ],
                                  ));
                                });
                          },
                        ),
                        width: double.infinity,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: FlyoutTarget(
                      key: attachKey2,
                      controller: controller2,
                      child: Container(
                        child: Button(
                          child: Text("ShowFlyout2"),
                          onPressed: () async {
                            LogUtil.e("flyout2 pressed");
                            controller1.showFlyout(
                                autoModeConfiguration: FlyoutAutoConfiguration(
                                    preferredMode:
                                        FlyoutPlacementMode.topCenter),
                                barrierDismissible: true,
                                dismissOnPointerMoveAway: false,
                                dismissWithEsc: false,
                                navigatorKey: rootNavigatorKey.currentState,
                                builder: (context) {
                                  return MenuFlyout(
                                    items: [
                                      MenuFlyoutItem(
                                          text: Text("Share"),
                                          leading: Icon(FluentIcons.share),
                                          onPressed: () {
                                            Flyout.of(context).close();
                                          }),
                                      MenuFlyoutItem(
                                          text: Text("Copy"),
                                          leading: Icon(FluentIcons.copy),
                                          onPressed: () {
                                            Flyout.of(context).close();
                                          }),
                                      MenuFlyoutItem(
                                          text: Text("Delete"),
                                          leading: Icon(FluentIcons.delete),
                                          onPressed: () {
                                            Flyout.of(context).close();
                                          }),
                                      MenuFlyoutItem(
                                          text: Text("Select"),
                                          onPressed: () {
                                            Flyout.of(context).close();
                                          }),
                                      MenuFlyoutSeparator(),
                                      MenuFlyoutSubItem(
                                          text: Text("SendTo"),
                                          items: (context) => [
                                                MenuFlyoutItem(
                                                    text: Text("BlueTooth"),
                                                    onPressed: () {
                                                      Flyout.of(context)
                                                          .close();
                                                    }),
                                                MenuFlyoutItem(
                                                    text: Text("Desktop"),
                                                    onPressed: () {
                                                      Flyout.of(context)
                                                          .close();
                                                    }),
                                              ]),
                                      MenuFlyoutSubItem(
                                        text: const Text('Compressed file'),
                                        items: (context) => [
                                          MenuFlyoutItem(
                                            text: const Text(
                                                'Compress and email'),
                                            onPressed: Flyout.of(context).close,
                                          ),
                                          MenuFlyoutItem(
                                            text: const Text('Compress to .7z'),
                                            onPressed: Flyout.of(context).close,
                                          ),
                                          MenuFlyoutItem(
                                            text:
                                                const Text('Compress to .zip'),
                                            onPressed: Flyout.of(context).close,
                                          ),
                                        ],
                                      ),
                                    ],
                                  );
                                });
                          },
                        ),
                        width: double.infinity,
                      ),
                    ),
                  ),
                ],
              ),
              codeSnippet: '''
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: FlyoutTarget(
                      key: attachKey1,
                      controller: controller1,
                      child: Container(
                        child: Button(
                          child: Text("ShowFlyout1"),
                          onPressed: () async {
                            LogUtil.e("flyout1 pressed");
                            controller1.showFlyout(
                                autoModeConfiguration: FlyoutAutoConfiguration(
                                    preferredMode:
                                        FlyoutPlacementMode.topCenter),
                                barrierDismissible: true,
                                dismissOnPointerMoveAway: false,
                                dismissWithEsc: true,
                                navigatorKey: rootNavigatorKey.currentState,
                                builder: (context) {
                                  return FlyoutContent(
                                      child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text("this is flyout"),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Button(
                                          child: Text("OK"),
                                          onPressed: () {
                                            Flyout.of(context).close();
                                          })
                                    ],
                                  ));
                                });
                          },
                        ),
                        width: double.infinity,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: FlyoutTarget(
                      key: attachKey2,
                      controller: controller2,
                      child: Container(
                        child: Button(
                          child: Text("ShowFlyout2"),
                          onPressed: () async {
                            LogUtil.e("flyout2 pressed");
                            controller1.showFlyout(
                                autoModeConfiguration: FlyoutAutoConfiguration(
                                    preferredMode:
                                        FlyoutPlacementMode.topCenter),
                                barrierDismissible: true,
                                dismissOnPointerMoveAway: false,
                                dismissWithEsc: false,
                                navigatorKey: rootNavigatorKey.currentState,
                                builder: (context) {
                                  return MenuFlyout(
                                    items: [
                                      MenuFlyoutItem(
                                          text: Text("Share"),
                                          leading: Icon(FluentIcons.share),
                                          onPressed: () {
                                            Flyout.of(context).close();
                                          }),
                                      MenuFlyoutItem(
                                          text: Text("Copy"),
                                          leading: Icon(FluentIcons.copy),
                                          onPressed: () {
                                            Flyout.of(context).close();
                                          }),
                                      MenuFlyoutItem(
                                          text: Text("Delete"),
                                          leading: Icon(FluentIcons.delete),
                                          onPressed: () {
                                            Flyout.of(context).close();
                                          }),
                                      MenuFlyoutItem(
                                          text: Text("Select"),
                                          onPressed: () {
                                            Flyout.of(context).close();
                                          }),
                                      MenuFlyoutSeparator(),
                                      MenuFlyoutSubItem(
                                          text: Text("SendTo"),
                                          items: (context) => [
                                                MenuFlyoutItem(
                                                    text: Text("BlueTooth"),
                                                    onPressed: () {
                                                      Flyout.of(context)
                                                          .close();
                                                    }),
                                                MenuFlyoutItem(
                                                    text: Text("Desktop"),
                                                    onPressed: () {
                                                      Flyout.of(context)
                                                          .close();
                                                    }),
                                              ]),
                                      MenuFlyoutSubItem(
                                        text: const Text('Compressed file'),
                                        items: (context) => [
                                          MenuFlyoutItem(
                                            text: const Text(
                                                'Compress and email'),
                                            onPressed: Flyout.of(context).close,
                                          ),
                                          MenuFlyoutItem(
                                            text: const Text('Compress to .7z'),
                                            onPressed: Flyout.of(context).close,
                                          ),
                                          MenuFlyoutItem(
                                            text:
                                                const Text('Compress to .zip'),
                                            onPressed: Flyout.of(context).close,
                                          ),
                                        ],
                                      ),
                                    ],
                                  );
                                });
                          },
                        ),
                        width: double.infinity,
                      ),
                    ),
                  ),
                ],
              )
          '''),
          subtitle(content: Text("Flyout1")),
          CardHighlight(
            codeSnippet: '''final contextController = FlyoutController();
final contextAttachKey = GlobalKey();

return GestureDetector(
  onSecondaryTapUp: (d) {

    // This calculates the position of the flyout according to the parent navigator
    final targetContext = contextAttachKey.currentContext;
    if (targetContext == null) return;
    final box = targetContext.findRenderObject() as RenderBox;
    final position = box.localToGlobal(
      d.localPosition,
      ancestor: Navigator.of(context).context.findRenderObject(),
    );

    contextController.showFlyout(
      barrierColor: Colors.black.withOpacity(0.1),
      position: position,
      builder: (context) {
        return FlyoutContent(
          child: SizedBox(
            width: 130.0,
            child: CommandBar(
              primaryItems: [
                CommandBarButton(
                  icon: const Icon(FluentIcons.add_favorite),
                  label: const Text('Favorite'),
                  onPressed: () {},
                ),
                CommandBarButton(
                  icon: const Icon(FluentIcons.copy),
                  label: const Text('Copy'),
                  onPressed: () {},
                ),
                CommandBarButton(
                  icon: const Icon(FluentIcons.share),
                  label: const Text('Share'),
                  onPressed: () {},
                ),
                CommandBarButton(
                  icon: const Icon(FluentIcons.save),
                  label: const Text('Save'),
                  onPressed: () {},
                ),
                CommandBarButton(
                  icon: const Icon(FluentIcons.delete),
                  label: const Text('Delete'),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        );
      },
    );
  },
  child: FlyoutTarget(
    key: contextAttachKey,
    controller: contextController,
    child: const FlutterLogo(size: 400.0),
  ),
);
''',
            child: GestureDetector(
              onSecondaryTapUp: (d) {
                final targetContext = contextAttachKey.currentContext;
                if (targetContext == null) return;

                final box = targetContext.findRenderObject() as RenderBox;
                final position = box.localToGlobal(
                  d.localPosition,
                  ancestor: Navigator.of(context).context.findRenderObject(),
                );

                contextController.showFlyout(
                  barrierColor: Colors.blue.withOpacity(0.1),
                  position: position,
                  builder: (context) {
                    return FlyoutContent(
                      child: SizedBox(
                        width: 130,
                        child: CommandBar(
                          isCompact: true,
                          primaryItems: [
                            CommandBarButton(
                              icon: const Icon(FluentIcons.add_favorite),
                              label: const Text('Favorite'),
                              onPressed: () {},
                            ),
                            CommandBarButton(
                              icon: const Icon(FluentIcons.copy),
                              label: const Text('Copy'),
                              onPressed: () {},
                            ),
                            CommandBarButton(
                              icon: const Icon(FluentIcons.share),
                              label: const Text('Share'),
                              onPressed: () {},
                            ),
                            CommandBarButton(
                              icon: const Icon(FluentIcons.save),
                              label: const Text('Save'),
                              onPressed: () {},
                            ),
                            CommandBarButton(
                              icon: const Icon(FluentIcons.delete),
                              label: const Text('Delete'),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              child: FlyoutTarget(
                key: contextAttachKey,
                controller: contextController,
                child: const FlutterLogo(
                  size: 400.0,
                ),
              ),
            ),
          ),
        ]);
  }

  Future<String?> showContentDialog(BuildContext context) async {
    return await showDialog<String>(
        context: context,
        builder: (context) {
          return ContentDialog(
            title: const Text("Are You Sure?"),
            content: Text("Do You Want?"),
            actions: [
              Button(
                  child: Text("Ok"),
                  onPressed: () {
                    Navigator.pop(context, "enter");
                  }),
              FilledButton(
                  child: Text("No"),
                  onPressed: () {
                    Navigator.pop(context, "cancel");
                  })
            ],
          );
        });
  }
}
