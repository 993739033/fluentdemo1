import 'package:fluent_ui/fluent_ui.dart';
import 'package:fluentdemo1/utils/LogUtil.dart';
import 'package:fluentdemo1/widgets/card_highlight.dart';

import '../../mixin/pagemixin.dart';

class ThemeView extends StatefulWidget {
  const ThemeView({super.key});

  @override
  State<ThemeView> createState() => _ThemeViewState();
}

class _ThemeViewState extends State<ThemeView> with PageMixin {
  double fontScale = 1.0;

  @override
  Widget build(BuildContext context) {
    Typography typography = FluentTheme.of(context).typography;
    typography = typography.apply(displayColor: Colors.green);
    LogUtil.e("rebuild");
    return ScaffoldPage.scrollable(
        header: PageHeader(
          title: Text("ThemeStyle"),
        ),
        children: [
          subtitle(content: Text("typography")),
          CardHighlight(
              child: SizedBox(
                height: 400,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Text(
                            "Display",
                            style: typography.display
                                ?.apply(fontSizeFactor: fontScale),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Title Large",
                            style: typography.titleLarge
                                ?.apply(fontSizeFactor: fontScale),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Title",
                            style: typography.title
                                ?.apply(fontSizeFactor: fontScale),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Sub Title",
                            style: typography.subtitle
                                ?.apply(fontSizeFactor: fontScale),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Body Large",
                            style: typography.bodyLarge
                                ?.apply(fontSizeFactor: fontScale),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Body",
                            style: typography.body
                                ?.apply(fontSizeFactor: fontScale),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Caption",
                            style: typography.caption
                                ?.apply(fontSizeFactor: fontScale),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    )),
                    Slider(
                        vertical: true,
                        min: 0.5,
                        max: 2,
                        value: fontScale,
                        label: fontScale.toStringAsFixed(2),
                        onChanged: (v) {
                          LogUtil.e("slider value:${v}");
                          setState(() {
                            fontScale = v;
                          });
                        })
                  ],
                ),
              ),
              codeSnippet: '''
           Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: Column(
                    children: [
                      Text(
                        "Display",
                        style: typography.display?.apply(fontSizeFactor: fontScale),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Title Large",
                        style:
                        typography.titleLarge?.apply(fontSizeFactor: fontScale),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Title",
                        style: typography.title?.apply(fontSizeFactor: fontScale),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Sub Title",
                        style:
                        typography.subtitle?.apply(fontSizeFactor: fontScale),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Body Large",
                        style:
                        typography.bodyLarge?.apply(fontSizeFactor: fontScale),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Body",
                        style: typography.body?.apply(fontSizeFactor: fontScale),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Caption",
                        style: typography.caption?.apply(fontSizeFactor: fontScale),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  )),
              Slider(
                  vertical: true,
                  min: 0.5,
                  max: 2,
                  value: fontScale,
                  label: fontScale.toStringAsFixed(2),
                  onChanged: (v) {
                    LogUtil.e("slider value:\${v}");
                    setState(() {
                      fontScale = v;
                    });
                  })
            ],
          )
          ''')
        ]);
  }
}
