import 'package:fluent_ui/fluent_ui.dart';
import 'package:fluentdemo1/routes/surfaces.dart';
import 'package:fluentdemo1/utils/LogUtil.dart';
import 'package:fluentdemo1/widgets/card_highlight.dart';

import '../../mixin/pagemixin.dart';

class SurfaceView extends StatefulWidget {
  const SurfaceView({super.key});

  @override
  State<SurfaceView> createState() => _SurfaceViewState();
}

class _SurfaceViewState extends State<SurfaceView> with PageMixin {
  final commandBarItems = <CommandBarItem>[
    CommandBarBuilderItem(
        builder: (context, mode, w) {
          return Tooltip(
            message: "Add Item",
            child: w,
          );
        },
        wrappedItem: CommandBarButton(
            icon: const Icon(FluentIcons.add),
            label: const Text("New"),
            onPressed: () {
              LogUtil.e("pressed New");
            })),
    CommandBarBuilderItem(
        builder: (context, mode, w) {
          return Tooltip(
            message: "Delete Item",
            child: w,
          );
        },
        wrappedItem: CommandBarButton(
            icon: const Icon(FluentIcons.delete),
            label: const Text("Delete"),
            onPressed: () {
              LogUtil.e("pressed Delete");
            })),
    CommandBarButton(
        icon: const Icon(FluentIcons.archive),
        label: const Text("Archive"),
        onPressed: () {}),
    CommandBarButton(
        icon: const Icon(FluentIcons.move),
        label: const Text("Move"),
        onPressed: () {}),
    CommandBarButton(
        icon: const Icon(FluentIcons.cancel),
        label: const Text("Disable"),
        onPressed: () {})
  ];

  final moreBarItems = <CommandBarItem>[
    CommandBarButton(
      icon: const Icon(FluentIcons.reply),
      label: const Text('Reply'),
      onPressed: () {},
    ),
    CommandBarButton(
      icon: const Icon(FluentIcons.reply_all),
      label: const Text('Reply All'),
      onPressed: () {},
    ),
    CommandBarButton(
      icon: const Icon(FluentIcons.forward),
      label: const Text('Forward'),
      onPressed: () {},
    ),
    CommandBarButton(
      icon: const Icon(FluentIcons.search),
      label: const Text('Search'),
      onPressed: () {},
    ),
    CommandBarButton(
      icon: const Icon(FluentIcons.pin),
      label: const Text('Pin'),
      onPressed: () {},
    ),
    CommandBarButton(
      icon: const Icon(FluentIcons.unpin),
      label: const Text('Unpin'),
      onPressed: () {},
    ),
  ];

  final evenMoreCommandBarItems = <CommandBarItem>[
    CommandBarButton(
      icon: const Icon(FluentIcons.accept),
      label: const Text('Accept'),
      onPressed: () {},
    ),
    CommandBarButton(
      icon: const Icon(FluentIcons.calculator_multiply),
      label: const Text('Reject'),
      onPressed: () {},
    ),
    CommandBarButton(
      icon: const Icon(FluentIcons.share),
      label: const Text('Share'),
      onPressed: () {},
    ),
    CommandBarButton(
      icon: const Icon(FluentIcons.add_favorite),
      label: const Text('Add Favorite'),
      onPressed: () {},
    ),
    CommandBarButton(
      icon: const Icon(FluentIcons.back),
      label: const Text('Backward'),
      onPressed: () {},
    ),
    CommandBarButton(
      icon: const Icon(FluentIcons.forward),
      label: const Text('Forward'),
      onPressed: () {},
    ),
  ];

  bool isExpanderOpen1 = false;
  String selectItem1 = "";
  final expanderKey = GlobalKey<ExpanderState>(debugLabel: 'Expander key');

  int sliderValue1 = 0;
  String selectItemName = "";

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.scrollable(
        header: PageHeader(
          commandBar: CommandBar(
            primaryItems: [
              ...commandBarItems,
            ],
          ),
          title: const Text("Surface Sample"),
        ),
        children: [
          subtitle(content: const Text("CommandBar")),
          CardHighlight(
              child: CommandBar(
                overflowBehavior: CommandBarOverflowBehavior.scrolling,
                primaryItems: [
                  ...commandBarItems,
                  const CommandBarSeparator(),
                  ...moreBarItems
                ],
              ),
              codeSnippet: '''
              CommandBar(
                overflowBehavior: CommandBarOverflowBehavior.wrap,
                primaryItems: [
                  ...commandBarItems,
                  const CommandBarSeparator(),
                  ...moreBarItems
                ],
          '''),
          SizedBox(
            height: 20,
          ),
          CardHighlight(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxHeight: 300),
                child: CommandBar(
                  compactBreakpointWidth: 300,
                  overflowBehavior: CommandBarOverflowBehavior.dynamicOverflow,
                  primaryItems: [
                    ...commandBarItems,
                    const CommandBarSeparator(
                        thickness: 3, color: Color(0xff66ccff)),
                    ...moreBarItems
                  ],
                  secondaryItems: [...evenMoreCommandBarItems],
                ),
              ),
              codeSnippet: '''
              ConstrainedBox(
                constraints: BoxConstraints(maxHeight: 300),
                child: CommandBar(
                  compactBreakpointWidth: 300,
                  overflowBehavior: CommandBarOverflowBehavior.dynamicOverflow,
                  primaryItems: [
                    ...commandBarItems,
                    const CommandBarSeparator(),
                    ...moreBarItems
                  ],
                  secondaryItems: [...evenMoreCommandBarItems],
                ),
          '''),
          SizedBox(
            height: 20,
          ),
          CardHighlight(
              child: CommandBarCard(
                child: Row(
                  children: [
                    Expanded(
                        child: CommandBar(
                            overflowItemAlignment: MainAxisAlignment.end,
                            overflowBehavior:
                                CommandBarOverflowBehavior.dynamicOverflow,
                            primaryItems: [
                          ...commandBarItems,
                          const CommandBarSeparator(),
                          ...moreBarItems
                        ])),
                    CommandBar(
                      primaryItems: [
                        CommandBarButton(
                            onPressed: () {},
                            label: Text("Refresh"),
                            icon: const Icon(FluentIcons.refresh))
                      ],
                      overflowBehavior: CommandBarOverflowBehavior.noWrap,
                    )
                  ],
                ),
              ),
              codeSnippet: '''
               CommandBarCard(
                child: Row(
                  children: [
                    Expanded(
                        child: CommandBar(
                            overflowBehavior:
                                CommandBarOverflowBehavior.dynamicOverflow,
                            primaryItems: [
                          ...commandBarItems,
                          const CommandBarSeparator(),
                          ...moreBarItems
                        ])),
                    CommandBar(
                      primaryItems: [
                        CommandBarButton(
                            onPressed: () {},
                            label: Text("Refresh"),
                            icon: const Icon(FluentIcons.refresh))
                      ],
                      overflowBehavior: CommandBarOverflowBehavior.noWrap,
                    )
                  ],
                ),
              )
          '''),
          subtitle(content: const Text("Expander")),
          CardHighlight(
              child: Column(
                children: [
                  Expander(
                    trailing: isExpanderOpen1 ? null : Text("$selectItem1"),
                    header: const Text("Choose Your Like"),
                    onStateChanged: (open) {
                      setState(() {
                        isExpanderOpen1 = open;
                      });
                    },
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...itemList1.map((e) {
                          return Padding(
                            padding:
                                const EdgeInsetsDirectional.only(bottom: 8),
                            child: Expanded(
                              child: RadioButton(
                                content: Text("${e}"),
                                checked: e == selectItem1,
                                onChanged: (selected) {
                                  if (selected)
                                    setState(() {
                                      selectItem1 = e;
                                    });
                                },
                              ),
                            ),
                          );
                        }).toList()
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Expander(
                    key: expanderKey,
                    header: const Text("Scroll Content"),
                    onStateChanged: (open) {
                      setState(() {
                        isExpanderOpen1 = open;
                      });
                    },
                    content: SizedBox(
                      height: 150,
                      child: SelectableText(
                          selectionControls: fluentTextSelectionControls,
                          '''
                   CardHighlight(
              child:Column(children: [
                Expander(
                  trailing: isExpanderOpen1 ? null : Text("selectItem1"),
                  header: const Text("Choose Your Like"),
                  onStateChanged: (open) {
                    setState(() {
                      isExpanderOpen1 = open;
                    });
                  },
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...itemList1.map((e) {
                        return Padding(
                          padding: const EdgeInsetsDirectional.only(bottom: 8),
                          child: Expanded(
                            child: RadioButton(
                              content: Text("213"),
                              checked: e == selectItem1,
                              onChanged: (selected) {
                                if (selected)
                                  setState(() {
                                    selectItem1 = e;
                                  });
                              },
                            ),
                          ),
                        );
                      }).toList()
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                Expander(
                  trailing: isExpanderOpen1 ? null : Text("selectItem1"),
                  header: const Text("Choose Your Like"),
                  onStateChanged: (open) {
                    setState(() {
                      isExpanderOpen1 = open;
                    });
                  },
                  content: SizedBox(height: 200,child: SelectableText(''),),
                ),
              ],),
              codeSnippet: '''
                          ''')
                  '''),
                    ),
                  ),
                ],
              ),
              codeSnippet: '''
          '''),
          subtitle(content: const Text("InfoBar")),
          CardHighlight(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Button(
                        child: Text("ShowInfoBar"),
                        onPressed: () {
                          displayInfoBar(context, alignment: Alignment.center,
                              builder: (context, close) {
                            return InfoBar(
                              title: Text("This is Title"),
                              content: Text("This is Content"),
                              isLong: false,
                              severity: InfoBarSeverity.warning,
                              action: IconButton(
                                icon: Icon(FluentIcons.clear),
                                onPressed: close,
                              ),
                            );
                          });
                        },
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: InfoBar(
                        title: Text("This is Title"),
                        content: Text(
                            "This is Content This is Content This is Content This is Content This is Content This is Content This is Content This is Content "),
                        isLong: true,
                        severity: InfoBarSeverity.error,
                        action: Button(
                          child: Text("Close"),
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              codeSnippet: '''
              Container(
                    width: double.infinity,
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Button(
                        child: Text("ShowInfoBar"),
                        onPressed: () {
                          displayInfoBar(context, alignment: Alignment.center,
                              builder: (context, close) {
                            return InfoBar(
                              title: Text("This is Title"),
                              content: Text("This is Content"),
                              isLong: false,
                              severity: InfoBarSeverity.warning,
                              action: IconButton(
                                icon: Icon(FluentIcons.clear),
                                onPressed: close,
                              ),
                            );
                          });
                        },
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: InfoBar(
                        title: Text("This is Title"),
                        content: Text(
                            "This is Content This is Content This is Content This is Content This is Content This is Content This is Content This is Content "),
                        isLong: true,
                        severity: InfoBarSeverity.error,
                        action: Button(
                          child: Text("Close"),
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ),
          '''),
          subtitle(content: const Text("InfoBar")),
          CardHighlight(
              child: Column(
                children: [
                  Container(
                    child: RepaintBoundary(
                      child: Row(
                        children: [
                          ProgressBar(),
                          SizedBox(
                            width: 20,
                          ),
                          ProgressRing()
                        ],
                      ),
                    ),
                    width: double.infinity,
                  ),
                  Container(
                    child: Row(
                      children: [
                        ProgressBar(
                          value: sliderValue1.toDouble(),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        ProgressRing(
                          value: sliderValue1.toDouble(),
                        )
                      ],
                    ),
                    width: double.infinity,
                  ),
                  Slider(
                      label: "$sliderValue1",
                      value: sliderValue1.toDouble(),
                      onChanged: (v) {
                        sliderValue1 = v.toInt();
                        setState(() {});
                      })
                ],
              ),
              codeSnippet: '''
               Container(
                    child: RepaintBoundary(
                      child: Row(
                        children: [
                          ProgressBar(),
                          SizedBox(
                            width: 20,
                          ),
                          ProgressRing()
                        ],
                      ),
                    ),
                    width: double.infinity,
                  ),
                  Container(
                    child: Row(
                      children: [
                        ProgressBar(
                          value: sliderValue1.toDouble(),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        ProgressRing(
                          value: sliderValue1.toDouble(),
                        )
                      ],
                    ),
                    width: double.infinity,
                  ),
                  Slider(
                      label: "$sliderValue1",
                      value: sliderValue1.toDouble(),
                      onChanged: (v) {
                        sliderValue1 = v.toInt();
                        setState(() {});
                      })
          '''),
          subtitle(content: const Text("TilePage")),
          CardHighlight(
              child: Container(
                height: 300,
                width: double.infinity,
                child: ListView.builder(
                    controller: ScrollController(),
                    shrinkWrap: true,
                    itemCount: listItems.length,
                    itemBuilder: (context, index) {
                      final item = listItems[index];
                      return ListTile.selectable(
                        title: Text("$item"),
                        selected: selectItem1 == item,
                        onSelectionChange: (v) {
                          setState(() {
                            selectItem1 = item;
                          });
                        },
                      );
                    }),
              ),
              codeSnippet: '''
               ListView.builder(
                    controller: ScrollController(),
                    shrinkWrap: true,
                    itemCount: listItems.length,
                    itemBuilder: (context, index) {
                      final item = listItems[index];
                      return ListTile.selectable(
                        title: Text("item"),
                        selected: selectItem1 == item,
                        onSelectionChange: (v) {
                          setState(() {
                            selectItem1 = item;
                          });
                        },
                      );
                    })
          ''')
        ]);
  }
}

final itemList1 = ["DDSaa", "NKlls", "GSD", "SGFG"];
final listItems = [
  "sadf",
  "asdg",
  "dh",
  "Atwte",
  "sdhf",
  "asgs",
  "zxcb",
  "bszs",
  "gasdg"
];
