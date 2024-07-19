import 'package:fluent_ui/fluent_ui.dart';
import 'package:fluentdemo1/mixin/pagemixin.dart';
import 'package:fluentdemo1/widgets/card_highlight.dart';

class InputWidgets extends StatefulWidget {
  const InputWidgets({super.key});

  @override
  State<InputWidgets> createState() => _InputWidgetsState();
}

class _InputWidgetsState extends State<InputWidgets> with PageMixin {
  bool disabled = false;
  bool firstChecked = false;
  bool? secondChecked = false;
  double firstSliderValue = 0;

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.scrollable(
        header: const PageHeader(
          title: const Text("ExWidget Sample"),
        ),
        children: [
          subtitle(content: const Text('A 2-state Checkbox')),
          CardHighlight(
              child: Row(
                children: [
                  Checkbox(
                      content: const Text("first checkbox"),
                      checked: firstChecked,
                      onChanged: disabled
                          ? null
                          : (v) {
                              setState(() {
                                firstChecked = v!;
                              });
                            }),
                  const SizedBox(
                    width: 5,
                  ),
                  Checkbox(
                      content: const Text("second checkbox"),
                      checked: secondChecked,
                      onChanged: disabled
                          ? null
                          : (v) {
                              setState(() {
                                secondChecked = v == true
                                    ? true
                                    : v == false
                                        ? null
                                        : v == null
                                            ? false
                                            : true;
                              });
                            }),
                  Spacer(),
                  ToggleSwitch(
                    checked: disabled,
                    onChanged: (v) {
                      setState(() {
                        disabled = v;
                      });
                    },
                    content: const Text("disabled"),
                  )
                ],
              ),
              codeSnippet: '''                  Checkbox(
                      checked: firstChecked,
                      onChanged: disabled
                          ? null
                          : (v) {
                              setState(() {
                                firstChecked = v!;
                              });
                            }),
                  const SizedBox(
                    width: 5,
                  ),
                  Checkbox(
                      checked: secondChecked,
                      onChanged: disabled
                          ? null
                          : (v) {
                              setState(() {
                                secondChecked = v == true
                                    ? true
                                    : v == false
                                        ? null
                                        : v == null
                                            ? false
                                            : true;
                              });
                            }),'''),
          subtitle(content: const Text("TreeView with Multiple")),
          Card(
              child: TreeView(
            items: [
              TreeViewItem(
                  content: const Text("SelectAll"), children: treeViewItems)
            ],
            selectionMode: TreeViewSelectionMode.multiple,
            onSelectionChanged: (it) async {
              it?.forEach((element) {
                print("value : ${element.value} selected: ${element.selected}");
              });
            },
          )),
          subtitle(content: const Text("Slider")),
          Card(
              child: Slider(
            label: '${firstSliderValue.toInt()}',
            value: firstSliderValue,
            onChanged: disabled
                ? null
                : (v) {
                    setState(() {
                      firstSliderValue = v;
                    });
                  },
          )),
        ]);
  }

  final treeViewItems = [
    TreeViewItem(content: const Text("Option1"), value: "1"),
    TreeViewItem(content: const Text("Option2"), value: "2"),
    TreeViewItem(content: const Text("Option3"), value: "3"),
  ];
}
