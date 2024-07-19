import 'dart:math';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:fluentdemo1/routes/navigations.dart';
import 'package:fluentdemo1/utils/LogUtil.dart';
import 'package:fluentdemo1/widgets/card_highlight.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:window_manager/window_manager.dart';

import '../../mixin/pagemixin.dart';

class NavigationView1 extends StatefulWidget {
  const NavigationView1({super.key});

  @override
  State<NavigationView1> createState() => _NavigationView1State();
}

class _NavigationView1State extends State<NavigationView1> with PageMixin {
  int currentIndex = 0;
  List<Tab>? tabs;
  var treeViewState = GlobalKey<TreeViewState>(debugLabel: "TreeView key");

  Tab generateTab(int index) {
    final allIcons = FluentIcons.allIcons.values;
    late Tab tab;
    tab = Tab(
        text: Text("Document #${index}"),
        semanticLabel: "Document #${index}",
        icon: Icon(allIcons.elementAt(Random().nextInt(allIcons.length))),
        body: Container(
          color:
              Colors.accentColors[Random().nextInt(Colors.accentColors.length)],
        ),
        onClosed: () {
          LogUtil.e("onclose");
          setState(() {
            tabs!.remove(tab);
            if (currentIndex > 0) currentIndex--;
          });
        });
    return tab;
  }

  @override
  Widget build(BuildContext context) {
    tabs ??= List.generate(3, generateTab);
    final theme = FluentTheme.of(context);

    return ScaffoldPage.scrollable(
        header: const PageHeader(
          title: const Text("NavigatorView"),
        ),
        children: [
          subtitle(content: const Text("OpenNewScreen")),
          CardHighlight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Button(
                      child: const Text("OpenNewScreen"),
                      onPressed: () {
                        Navigator.of(context, rootNavigator: true)
                            .push(FluentPageRoute(builder: (context) {
                          return const NavigationViewShellRoute();
                        }));
                      }),
                  SizedBox(
                    width: 10,
                  ),
                  Button(
                      child: const Text("OpenNewScreen2"),
                      onPressed: () {
                        Navigator.of(context, rootNavigator: false)
                            .push(FluentPageRoute(builder: (context) {
                          return const NavigationViewShellRoute();
                        }));
                      }),
                ],
              ),
              codeSnippet: '''
          Button(
                      child: const Text("OpenNewScreen"),
                      onPressed: () {
                        Navigator.of(context, rootNavigator: true)
                            .push(FluentPageRoute(builder: (context) {
                          return const NavigationViewShellRoute();
                        }));
                      }),
                  SizedBox(width: 10,),
                  Button(child: const Text("OpenNewScreen2"), onPressed: () {
                    Navigator.of(context, rootNavigator: false)
                        .push(FluentPageRoute(builder: (context) {
                      return const NavigationViewShellRoute();
                    }));
                  }),
          '''),
          subtitle(content: const Text("TabView")),
          CardHighlight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(text: () {
                    const lineBreakSpan = TextSpan(text: '\n');
                    const topicSpan = TextSpan(
                      text: '  •  ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    );
                    TextSpan shortcutSpan(String text) {
                      return TextSpan(
                        text: text,
                        style: TextStyle(
                          color: theme.accentColor
                              .defaultBrushFor(theme.brightness),
                          fontWeight: FontWeight.w600,
                        ),
                      );
                    }

                    TextSpan tipSpan(String text) {
                      return TextSpan(
                        text: text,
                        style: TextStyle(
                          color: theme.accentColor
                              .defaultBrushFor(theme.brightness),
                          fontWeight: FontWeight.w300,
                        ),
                      );
                    }

                    return TextSpan(children: [
                      TextSpan(children: [
                        topicSpan,
                        shortcutSpan('Crtl+T'),
                        tipSpan("open new tab"),
                        lineBreakSpan
                      ]),
                      TextSpan(children: [
                        topicSpan,
                        shortcutSpan('Ctrl + W'),
                        tipSpan(' or '),
                        shortcutSpan('Ctrl + F4'),
                        tipSpan(' closes the selected tab'),
                        // const TextSpan(text: ' closes the selected tab'),
                        lineBreakSpan
                      ]),
                      TextSpan(children: [
                        topicSpan,
                        shortcutSpan('Ctrl + 1'),
                        tipSpan(' + '),
                        shortcutSpan('Ctrl + 8'),
                        tipSpan(' selects that number tab'),
                        lineBreakSpan
                      ]),
                      TextSpan(children: [
                        topicSpan,
                        shortcutSpan('Ctrl + 9'),
                        tipSpan(' selects the last tab'),
                      ]),
                    ]);
                  }()),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 350,
                    child: TabView(
                      currentIndex: currentIndex,
                      tabs: tabs!,
                      onChanged: (index) => {
                        setState(() {
                          currentIndex = index;
                        })
                      },
                      tabWidthBehavior: TabWidthBehavior.sizeToContent,
                      closeButtonVisibility: CloseButtonVisibilityMode.always,
                      showScrollButtons: true,
                      onNewPressed: () {
                        setState(() {
                          final index = tabs!.length + 1;
                          final tab = generateTab(index);
                          tabs!.add(tab);
                        });
                      },
                      onReorder: (oldIndex, newIndex) {
                        setState(() {
                          if (oldIndex < newIndex) {
                            newIndex -= 1;
                          }
                          var oldItem = tabs![currentIndex];
                          final item = tabs!.removeAt(oldIndex);
                          tabs!.insert(newIndex, item);
                          currentIndex = tabs!.indexWhere(
                              (element) => oldItem.text == element.text);
                        });
                      },
                    ),
                  )
                ],
              ),
              codeSnippet: '''
              TabView(
                  currentIndex: currentIndex,
                  tabs: tabs!,
                  onChanged: (index) => {
                    setState(() {
                      currentIndex = index;
                    })
                  },
                  tabWidthBehavior: TabWidthBehavior.sizeToContent,
                  closeButtonVisibility: CloseButtonVisibilityMode.always,
                  showScrollButtons: true,
                  onNewPressed: () {
                    setState(() {
                      final index = tabs!.length + 1;
                      final tab = generateTab(index);
                      tabs!.add(tab);
                    });
                  },
                  onReorder: (oldIndex,newIndex){
                    setState(() {
                      if (oldIndex < newIndex) {
                        newIndex -= 1;
                      }
                      var oldItem = tabs![currentIndex];
                      final item = tabs!.removeAt(oldIndex);
                      tabs!.insert(newIndex, item);
                      currentIndex = tabs!
                          .indexWhere((element) => oldItem.text==element.text);
                    });
                  },
                )
          '''),
          subtitle(content: const Text("TreeView")),
          CardHighlight(
              child: TreeView(
                selectionMode: TreeViewSelectionMode.multiple,
                items: treeItems,
                onItemInvoked: (item, reason) async {
                  LogUtil.e("item:${item} reason:${reason}");
                },
                onSelectionChanged: (selectedItems) async {
                  LogUtil.e("selectedItems:${selectedItems} ");
                },
                onSecondaryTap: (item, details) async {
                  LogUtil.e("item:${item} details:${details}");
                },
              ),
              codeSnippet: '''
              TreeView(
                selectionMode: TreeViewSelectionMode.multiple,
                items: treeItems,
                onItemInvoked: (item, reason) async {
                  LogUtil.e("item:item reason:reason");
                },
                onSelectionChanged: (selectedItems) async {
                  LogUtil.e("selectedItems:selectedItems ");
                },
                onSecondaryTap: (item, details) async {
                  LogUtil.e("item:item details:details");
                },
              )
          '''),
          subtitle(content: const Text("BreadCrumb")),
          CardHighlight(
              child: BreadcrumbBar(
                items: breadCrumbItems,
                onItemPressed: (item){
                  setState(() {
                    int index = breadCrumbItems.indexOf(item);
                    breadCrumbItems.removeRange(index+1,breadCrumbItems.length);
                  });
                },
              ),
              codeSnippet: '''
              BreadcrumbBar(
                items: breadCrumbItems,
                onItemPressed: (item){
                  setState(() {
                    int index = breadCrumbItems.indexOf(item);
                    breadCrumbItems.removeRange(index+1,breadCrumbItems.length);
                  });
                },
              )
          ''')
        ]);
  }
}

final breadCrumbItems = <BreadcrumbItem<int>>[
  BreadcrumbItem(label: Text("Home"), value: 0),
  BreadcrumbItem(label: Text("Documents"), value: 1),
  BreadcrumbItem(label: Text("Design"), value: 2),
  BreadcrumbItem(label: Text("Northwind"), value: 3),
  BreadcrumbItem(label: Text("Images"), value: 4),
  BreadcrumbItem(label: Text("Folder1"), value: 5),
  BreadcrumbItem(label: Text("Folder2"), value: 6),
];

final treeItems = [
  TreeViewItem(content: const Text("root"), children: [
    TreeViewItem(content: const Text("Item1"), children: [
      TreeViewItem(content: const Text("Item1_1")),
      TreeViewItem(content: const Text("Item1_2")),
    ]),
    TreeViewItem(content: const Text("Item2"), children: [
      TreeViewItem(content: const Text("Item2_1")),
      TreeViewItem(content: const Text("Item2_2"), children: [
        TreeViewItem(content: const Text("Item2_2_1")),
        TreeViewItem(content: const Text("Item2_2_2")),
      ]),
    ]),
    TreeViewItem(
        content: const Text("Item3"),
        children: [],
        lazy: true,
        value: "Item3",
        onExpandToggle: (item, getExpanded) async {
          if (item.children.isNotEmpty) return;
          await Future.delayed(const Duration(seconds: 2));
          item.children.addAll([
            TreeViewItem(content: const Text("Extra1"), value: 'Extra1'),
            TreeViewItem(content: const Text("Extra2"), value: 'Extra2'),
            TreeViewItem(content: const Text("Extra3"), value: 'Extra3'),
          ]);
        })
  ])
];

class NavigationViewShellRoute extends StatelessWidget {
  const NavigationViewShellRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return NavigationView(
      appBar: NavigationAppBar(
          title: () {
            const title = const Text('NavigationView');
            if (kIsWeb) return title;
            return const DragToMoveArea(child: title);
          }(),
          leading: IconButton(
            icon: const Icon(FluentIcons.back),
            onPressed: () {
              GoRouter.of(context).pop();
            },
          )),
      content: const ScaffoldPage(
        header: PageHeader(
          title: Text('New Page'),
        ),
        content: const Text("This is new Page"),
      ),
    );
  }
}
