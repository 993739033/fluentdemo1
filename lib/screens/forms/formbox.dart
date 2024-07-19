import 'package:fluent_ui/fluent_ui.dart';
import 'package:fluentdemo1/mixin/pagemixin.dart';
import 'package:fluentdemo1/widgets/card_highlight.dart';

class FormBox extends StatefulWidget {
  const FormBox({super.key});

  @override
  State<FormBox> createState() => _FormBoxState();
}

class _FormBoxState extends State<FormBox> with PageMixin {
  final asgbKey = GlobalKey<AutoSuggestBoxState>(
    debugLabel: 'Manually controlled AutoSuggestBox',
  );

  final comboboxKey = GlobalKey<ComboBoxState>(debugLabel: 'Combobox Key');
  PasswordRevealMode revealMode = PasswordRevealMode.peek;

  String? selectedColor = 'Green';
  double fontSize = 20.0;
  int? numberBoxValue1 = 0;
  double? numberBoxValue2 = 0;

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.scrollable(
        header: const PageHeader(
          title: const Text("FormBox Sample1"),
        ),
        children: [
          subtitle(content: const Text('InputBox')),
          CardHighlight(
              child: Row(
                children: [
                  Expanded(
                      child: const TextBox(
                    placeholder: "input ..",
                    expands: false,
                    maxLines: null,
                  )),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                      child: TextBox(
                    placeholder: "custom textstyle",
                    style: TextStyle(
                      fontSize: 18.0,
                      letterSpacing: 8.0,
                      color: Color(0xFF5178BE),
                      fontStyle: FontStyle.italic,
                    ),
                    expands: false,
                  )),
                ],
              ),
              codeSnippet: ''' InfoLabel(
                      label: "Enter PassWord",
                      child: const TextBox(
                        placeholder: "input ..",
                        expands: false,
                      )),
                  SizedBox(
                    width: 5,
                  ),
                  InfoLabel(
                      label: "Custom TextStyle",
                      child: const TextBox(
                        placeholder: "this is custom textstyle",
                        style: TextStyle(
                          fontFamily: 'Arial',
                          fontSize: 24.0,
                          letterSpacing: 8.0,
                          color: Color(0xFF5178BE),
                          fontStyle: FontStyle.italic,
                        ),
                        expands: false,
                      )),'''),
          subtitle(content: const Text("AutoSuggestBox")),
          CardHighlight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 300,
                    child: AutoSuggestBox<String>(
                        key: asgbKey,
                        placeholder: "select item",
                        enabled:
                            asgbKey.currentState?.isOverlayVisible ?? false,
                        items: cats.map<AutoSuggestBoxItem<String>>((e) {
                          return AutoSuggestBoxItem<String>(
                              value: e,
                              label: e,
                              onFocusChange: (focused) {
                                if (focused) debugPrint('Focused $e');
                              });
                        }).toList()),
                  ),
                  Spacer(),
                  ToggleSwitch(
                      checked: asgbKey.currentState?.isOverlayVisible ?? false,
                      onChanged: (v) {
                        final asgbState = asgbKey.currentState;
                        if (asgbState == null) return;
                        if (asgbState.isOverlayVisible) {
                          asgbState.dismissOverlay();
                        } else {
                          asgbState.showOverlay();
                        }
                        setState(() {});
                      })
                ],
              ),
              codeSnippet: '''AutoSuggestBox<String>(
                    placeholder: "select item",
                    enabled: true,
                    items: cats.map<AutoSuggestBoxItem<String>>((e) {
                      return AutoSuggestBoxItem<String>(
                          value: e,
                          label: e,
                          onFocusChange: (focused) {
                            if (focused) debugPrint('Focused e');
                          });
                    }).toList())'''),
          subtitle(content: const Text("ComboBox")),
          CardHighlight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 100,
                    child: ComboBox<String>(
                      isExpanded: false,
                      popupColor: colors[selectedColor],
                      value: selectedColor,
                      items: colors.entries.map((e) {
                        return ComboBoxItem(
                          value: e.key,
                          child: Text("${e.key}"),
                        );
                      }).toList(),
                      onChanged: (color) {
                        selectedColor = color;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: 100,
                    child: EditableComboBox<int>(
                      key: comboboxKey,
                      isExpanded: false,
                      value: fontSize.toInt(),
                      items: fontSizes.map((fontSize) {
                        return ComboBoxItem<int>(
                            value: fontSize.toInt(),
                            child: Text("${fontSize.toInt()}"));
                      }).toList(),
                      onChanged: (v) {
                        setState(() {
                          fontSize = (v ?? fontSize).toDouble();
                        });
                      },
                      placeholder: const Text("font size"),
                      onFieldSubmitted: (String text) {
                        try {
                          final newSize = int.parse(text);
                          if (newSize < 8 || newSize > 100) {
                            throw UnsupportedError(
                                "The font size must between 8 and 100");
                          }
                          setState(() => fontSize = newSize.toDouble());
                        } catch (e) {
                          String msg = e.toString();
                          showDialog(
                            context: context,
                            builder: (context) {
                              return ContentDialog(
                                content: Text(
                                  "${msg}",
                                ),
                                actions: [
                                  FilledButton(
                                    onPressed: Navigator.of(context).pop,
                                    child: const Text('Close'),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                        return '${fontSize.toInt()}';
                      },
                    ),
                  ),
                  Spacer(),
                  Button(
                      child: const Text("switch"),
                      onPressed: () {
                        comboboxKey.currentState?.openPopup();
                      })
                ],
              ),
              codeSnippet: ''' SizedBox(
                    width: 100,
                    child: ComboBox<String>(
                      isExpanded: false,
                      popupColor: colors[selectedColor],
                      value: selectedColor,
                      items: colors.entries.map((e) {
                        return ComboBoxItem(
                          value: e.key,
                          child: Text("e.key"),
                        );
                      }).toList(),
                      onChanged: (color) {
                        selectedColor = color;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: 100,
                    child: EditableComboBox<int>(
                      key: comboboxKey,
                      isExpanded: false,
                      value: fontSize.toInt(),
                      items: fontSizes.map((fontSize) {
                        return ComboBoxItem<int>(
                            value: fontSize.toInt(),
                            child: Text("fontSize.toInt()"));
                      }).toList(),
                      onChanged: (v) {
                        setState(() {
                          fontSize = (v ?? fontSize).toDouble();
                        });
                      },
                      placeholder: const Text("font size"),
                      onFieldSubmitted: (String text) {
                        try {
                          final newSize = int.parse(text);
                          if (newSize < 8 || newSize > 100) {
                            throw UnsupportedError(
                                "The font size must between 8 and 100");
                          }
                          setState(() => fontSize = newSize.toDouble());
                        } catch (e) {
                          String msg = e.toString();
                          showDialog(
                            context: context,
                            builder: (context) {
                              return ContentDialog(
                                content: Text(
                                  "msg",
                                ),
                                actions: [
                                  FilledButton(
                                    onPressed: Navigator.of(context).pop,
                                    child: const Text('Close'),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                        return '${fontSize.toInt()}';
                      },
                    ),
                  ),'''),
          subtitle(content: const Text("NumberBox")),
          CardHighlight(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  NumberBox(
                    min: 0,
                    max: 20,
                    placeholder: "inline",
                    value: numberBoxValue1,
                    onChanged: (v) {
                      setState(() {
                        numberBoxValue1 = v;
                      });
                    },
                    mode: SpinButtonPlacementMode.inline,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  NumberBox(
                    placeholder: "compact",
                    value: numberBoxValue1,
                    onChanged: (v) {
                      setState(() {
                        numberBoxValue1 = v;
                      });
                    },
                    mode: SpinButtonPlacementMode.compact,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  NumberBox(
                    placeholder: "none",
                    value: numberBoxValue1,
                    onChanged: (v) {
                      setState(() {
                        numberBoxValue1 = v;
                      });
                    },
                    mode: SpinButtonPlacementMode.none,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  NumberBox(
                    placeholder: "none",
                    value: numberBoxValue2,
                    smallChange: 0.1,
                    onChanged: (v) {
                      setState(() {
                        numberBoxValue2 = v;
                      });
                    },
                    mode: SpinButtonPlacementMode.none,
                  ),
                ],
              ),
              codeSnippet: '''
             NumberBox(
                    min: 0,
                    max: 20,
                    placeholder: "inline",
                    value: numberBoxValue1,
                    onChanged: (v) {
                      setState(() {
                        numberBoxValue1 = v;
                      });
                    },
                    mode: SpinButtonPlacementMode.inline,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  NumberBox(
                    placeholder: "compact",
                    value: numberBoxValue1,
                    onChanged: (v) {
                      setState(() {
                        numberBoxValue1 = v;
                      });
                    },
                    mode: SpinButtonPlacementMode.compact,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  NumberBox(
                    placeholder: "none",
                    value: numberBoxValue1,
                    onChanged: (v) {
                      setState(() {
                        numberBoxValue1 = v;
                      });
                    },
                    mode: SpinButtonPlacementMode.none,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  NumberBox(
                    placeholder: "none",
                    value: numberBoxValue2,
                    smallChange: 0.1,
                    onChanged: (v) {
                      setState(() {
                        numberBoxValue2 = v;
                      });
                    },
                    mode: SpinButtonPlacementMode.none,
                  ),
          '''),
          subtitle(content: const Text("PasswordBox")),
          CardHighlight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      child: PasswordBox(
                    revealMode: revealMode,
                  )),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: PasswordFormBox(
                    autovalidateMode: AutovalidateMode.always,
                    validator: (text) {
                      if (text == null) return null;
                      if (text.length < 8) return 'At least 8 characters';
                      return null;
                    },
                    revealMode: revealMode,
                  )),
                  SizedBox(
                    width: 10,
                  ),
                  ComboBox(
                      value: revealMode,
                      onChanged: (e) {
                        setState(() {
                          revealMode = e ?? PasswordRevealMode.peek;
                        });
                      },
                      items: PasswordRevealMode.values.map((e) {
                        return ComboBoxItem(value: e, child: Text(e.name));
                      }).toList()),
                ],
              ),
              codeSnippet: '''
          Expanded(
                      child: PasswordBox(
                    revealMode: revealMode,
                  )),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: PasswordFormBox(
                    autovalidateMode: AutovalidateMode.always,
                    validator: (text) {
                      if (text == null) return null;
                      if (text.length < 8) return 'At least 8 characters';
                      return null;
                    },
                    revealMode: revealMode,
                  )),
                  SizedBox(
                    width: 10,
                  ),
                  ComboBox(
                      value: revealMode,
                      onChanged: (e) {
                        setState(() {
                          revealMode = e ?? PasswordRevealMode.peek;
                        });
                      },
                      items: PasswordRevealMode.values.map((e) {
                        return ComboBoxItem(value: e, child: Text(e.name));
                      }).toList())
          '''),
        ]);
  }
}

Map<String, Color> colors = {
  'Blue': Colors.blue,
  'Green': Colors.green,
  'Red': Colors.red,
  'Yellow': Colors.yellow,
  'Grey': Colors.grey,
  'Magenta': Colors.magenta,
  'Orange': Colors.orange,
  'Purple': Colors.purple,
  'Teal': Colors.teal,
};

const fontSizes = <double>[
  8,
  9,
  10,
  11,
  12,
  14,
  16,
  18,
  20,
  24,
  28,
  36,
  48,
  72,
];

const cats = <String>[
  'Abyssinian',
  'Aegean',
  'American Bobtail',
  'American Curl',
  'American Ringtail',
  'American Shorthair',
  'American Wirehair',
  'Aphrodite Giant',
  'Arabian Mau',
  'Asian cat',
  'Asian Semi-longhair',
  'Australian Mist',
  'Balinese',
  'Bambino',
  'Bengal',
  'Birman',
  'Bombay',
  'Brazilian Shorthair',
  'British Longhair',
  'British Shorthair',
  'Burmese',
  'Burmilla',
  'California Spangled',
  'Chantilly-Tiffany',
  'Chartreux',
  'Chausie',
  'Colorpoint Shorthair',
  'Cornish Rex',
  'Cymric',
  'Cyprus',
  'Devon Rex',
  'Donskoy',
  'Dragon Li',
  'Dwelf',
  'Egyptian Mau',
  'European Shorthair',
  'Exotic Shorthair',
  'Foldex',
  'German Rex',
  'Havana Brown',
  'Highlander',
  'Himalayan',
  'Japanese Bobtail',
  'Javanese',
  'Kanaani',
  'Khao Manee',
  'Kinkalow',
  'Korat',
  'Korean Bobtail',
  'Korn Ja',
  'Kurilian Bobtail',
  'Lambkin',
  'LaPerm',
  'Lykoi',
  'Maine Coon',
  'Manx',
  'Mekong Bobtail',
  'Minskin',
  'Napoleon',
  'Munchkin',
  'Nebelung',
  'Norwegian Forest Cat',
  'Ocicat',
  'Ojos Azules',
  'Oregon Rex',
  'Oriental Bicolor',
  'Oriental Longhair',
  'Oriental Shorthair',
  'Persian (modern)',
  'Persian (traditional)',
  'Peterbald',
  'Pixie-bob',
  'Ragamuffin',
  'Ragdoll',
  'Raas',
  'Russian Blue',
  'Russian White',
  'Sam Sawet',
  'Savannah',
  'Scottish Fold',
  'Selkirk Rex',
  'Serengeti',
  'Serrade Petit',
  'Siamese',
  'Siberian or´Siberian Forest Cat',
  'Singapura',
  'Snowshoe',
  'Sokoke',
  'Somali',
  'Sphynx',
  'Suphalak',
  'Thai',
  'Thai Lilac',
  'Tonkinese',
  'Toyger',
  'Turkish Angora',
  'Turkish Van',
  'Turkish Vankedisi',
  'Ukrainian Levkoy',
  'Wila Krungthep',
  'York Chocolate',
];
