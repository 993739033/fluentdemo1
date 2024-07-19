import 'package:fluent_ui/fluent_ui.dart';
import 'package:fluentdemo1/config/AppThemeConfig.dart';
import 'package:fluentdemo1/utils/LogUtil.dart';
import 'package:fluentdemo1/widgets/card_highlight.dart';
import 'package:provider/provider.dart';

import '../../mixin/pagemixin.dart';

class FormPicker extends StatefulWidget {
  const FormPicker({super.key});

  @override
  State<FormPicker> createState() => _FormPickerState();
}

class _FormPickerState extends State<FormPicker> with PageMixin {
  bool disabled = false;

  DateTime? time1;
  DateTime? time2;
  DateTime? time3;

  @override
  Widget build(BuildContext context) {
    var appThemeConfig = context.watch<AppThemeConfig>();
    return ScaffoldPage.scrollable(
        header: PageHeader(
          title: Text("FormPicker Sample"),
          commandBar: ToggleSwitch(
            checked: disabled,
            onChanged: (v) {
              setState(() {
                disabled = v;
              });
            },
            content: Text(disabled ? 'enable' : "disabled"),
          ),
        ),
        children: [
          subtitle(content: const Text("TimePicker")),
          CardHighlight(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TimePicker(
                    selected: time1,
                    onChanged: (v) {
                      time1 = v;
                      setState(() {});
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TimePicker(
                    hourFormat: HourFormat.HH,
                    locale: appThemeConfig.locale,
                    selected: time1,
                    minuteIncrement: 15,
                    onChanged: (v) {
                      time1 = v;
                      setState(() {});
                    },
                  ),
                  DatePicker(
                    selected: time2,
                    locale: appThemeConfig.locale,
                    header: "PickDate",
                    onChanged: (v) {
                      time2 = v;
                      setState(() {});
                    },
                    onCancel: () {
                      LogUtil.e("canceled");
                    },
                    showDay: true,
                    showMonth: true,
                    showYear: true,
                  )
                ],
              ),
              codeSnippet: ''' TimePicker(
                    selected: time1,
                    onChanged: (v) {
                      time1 = v;
                      setState(() {});
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TimePicker(
                    hourFormat: HourFormat.HH,
                    locale: Locale("Zh"),
                    selected: time1,
                    minuteIncrement: 15,
                    onChanged: (v) {
                      time1 = v;
                      setState(() {});
                    },'''),
        ]);
  }
}
