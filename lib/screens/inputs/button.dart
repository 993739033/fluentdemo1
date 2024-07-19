import 'package:fluent_ui/fluent_ui.dart';
import 'package:fluentdemo1/widgets/card_highlight.dart';
import 'package:flutter/widgets.dart';
import 'package:fluentdemo1/mixin/pagemixin.dart';

class ButtonRoute extends StatefulWidget {
  const ButtonRoute({super.key});

  @override
  State<ButtonRoute> createState() => _ButtonRouteState();
}

class _ButtonRouteState extends State<ButtonRoute> with PageMixin {
  bool simpleButtonDisabled = false;
  bool toggleButtonStatus = false;

  AccentColor splitButtonColor = Colors.red;
  int radioButtonSelected = -1;

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);

    final splitButtonFlyout = FlyoutContent(
        constraints: BoxConstraints(maxWidth: 300),
        child: Wrap(
          runSpacing: 10,
          spacing: 8,
          children: Colors.accentColors.map((color) {
            return IconButton(
              autofocus: splitButtonColor == color,
              style: ButtonStyle(
                padding: ButtonState.all(
                  EdgeInsets.all(4.0),
                ),
              ),
              onPressed: () {
                setState(() => splitButtonColor = color);
                Navigator.of(context).pop(color);
              },
              icon: Container(
                height: 42,
                width: 50,
                color: color,
              ),
            );
          }).toList(),
        ));

    return ScaffoldPage.scrollable(
        header: const PageHeader(
          title: Text("Button"),
        ),
        children: [
          const Text("Button Example"),
          subtitle(content: const Text("A Simple Button")),
          description(content: const Text("A Normal Button Performance")),
          CardHighlight(
              child: Row(
                children: [
                  Button(
                      child: const Text("Simple Button"),
                      onPressed: simpleButtonDisabled ? null : () {}),
                  SizedBox(
                    width: 20,
                  ),
                  FilledButton(
                      child: const Text("Filled Button"),
                      onPressed: simpleButtonDisabled ? null : () {}),
                  SizedBox(
                    width: 20,
                  ),
                  HyperlinkButton(
                      child: const Text("HyperLinkButton"),
                      onPressed: simpleButtonDisabled ? null : () {}),
                  const Spacer(),
                  ToggleSwitch(
                    checked: simpleButtonDisabled,
                    onChanged: (v) {
                      setState(() {
                        simpleButtonDisabled = v;
                      });
                    },
                    content: const Text('Disabled'),
                  )
                ],
              ),
              codeSnippet: '''
              Button(
                      child: const Text("Simple Button"),
                      onPressed: simpleButtonDisabled ? null : () {})'''),
          subtitle(content: const Text("Extra Button")),
          description(
              content: const Text("IconButton,ToggleButton,DropdownButton")),
          CardHighlight(
              child: Row(
                children: [
                  IconButton(
                      icon: Icon(
                        FluentIcons.access_logo,
                        size: 40,
                      ),
                      onPressed: simpleButtonDisabled ? null : () {}),
                  SizedBox(
                    width: 20,
                  ),
                  ToggleButton(
                    child: const Text("Toggle Button"),
                    onChanged: simpleButtonDisabled
                        ? null
                        : (v) {
                            toggleButtonStatus = v;
                            setState(() {});
                          },
                    checked: toggleButtonStatus,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  DropDownButton(
                    disabled: simpleButtonDisabled,
                    title: Row(
                      children: [
                        Icon(FluentIcons.account_browser),
                        SizedBox(
                          width: 10,
                        ),
                        const Text("DropDownButton")
                      ],
                    ),
                    items: [
                      MenuFlyoutItem(
                          text: const Text("item1"),
                          leading: Icon(FluentIcons.add_favorite),
                          onPressed: () {}),
                      MenuFlyoutSeparator(),
                      MenuFlyoutItem(
                          text: const Text("item2"),
                          leading: Icon(FluentIcons.add_bookmark),
                          onPressed: () {}),
                      MenuFlyoutItem(
                          text: const Text("item3"),
                          leading: Icon(FluentIcons.add_group),
                          onPressed: () {})
                    ],
                  ),
                  const Spacer(),
                  ToggleSwitch(
                    checked: simpleButtonDisabled,
                    onChanged: (v) {
                      setState(() {
                        simpleButtonDisabled = v;
                      });
                    },
                    content: const Text('Disabled'),
                  )
                ],
              ),
              codeSnippet: '''
              Button(
                      child: const Text("Simple Button"),
                      onPressed: simpleButtonDisabled ? null : () {})'''),
          subtitle(content: const Text("Extra Button1")),
          description(content: const Text("SplitButton,RadioButton")),
          CardHighlight(
              child: Row(
                children: [
                  SplitButton(
                    enabled: !simpleButtonDisabled,
                    flyout: splitButtonFlyout,
                    child: Container(
                      decoration: BoxDecoration(
                        color: simpleButtonDisabled
                            ? splitButtonColor
                                .secondaryBrushFor(theme.brightness)
                            : splitButtonColor,
                        borderRadius: const BorderRadiusDirectional.horizontal(
                          start: Radius.circular(4.0),
                        ),
                      ),
                      height: 42,
                      width: 50,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  RadioButton(
                      content: const Text("RadioBtn1"),
                      checked: radioButtonSelected == 1,
                      onChanged: simpleButtonDisabled
                          ? null
                          : (selected) {
                              if (selected) {
                                setState(() {
                                  radioButtonSelected = 1;
                                });
                              }
                            }),
                  SizedBox(
                    width: 20,
                  ),
                  RadioButton(
                      content: const Text("RadioBtn2"),
                      checked: radioButtonSelected == 2,
                      onChanged: simpleButtonDisabled
                          ? null
                          : (selected) {
                              if (selected) {
                                setState(() {
                                  radioButtonSelected = 2;
                                });
                              }
                            }),
                  Spacer(),
                  ToggleSwitch(
                    checked: simpleButtonDisabled,
                    onChanged: (v) {
                      setState(() {
                        simpleButtonDisabled = v;
                      });
                    },
                    content: const Text('Disabled'),
                  )
                ],
              ),
              codeSnippet: '''
              Button(
                      child: const Text("Simple Button"),
                      onPressed: simpleButtonDisabled ? null : () {})'''),
        ]);
  }
}
