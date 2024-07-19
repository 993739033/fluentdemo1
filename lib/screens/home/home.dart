import 'package:fluent_ui/fluent_ui.dart';
import 'package:fluentdemo1/utils/LogUtil.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animationElev; //高度

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.scrollable(
      header: const PageHeader(
        title: Text("Acrylic"),
      ),
      children: [
        SizedBox(
          height: 350,
          width: 220,
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  "assets/bj2.jpg",
                  fit: BoxFit.fitWidth,
                ),
              ),
              Positioned.fill(
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: AnimatedBuilder(
                    animation: animationController,
                    builder: (context, childen) {
                      return GestureDetector(
                        onTapDown: (detail) {
                          LogUtil.e("ontapdown");
                          animationController.forward();
                        },
                        onTapUp: (details) {
                          LogUtil.e("ontapup");
                          animationController.reverse();
                        },
                        onTapCancel: () {
                          LogUtil.e("ontapcancel");
                          animationController.reverse();
                        },
                        child: Acrylic(
                            elevation: animationElev.value,
                            luminosityAlpha: 0.5,
                            blurAmount: animationElev.value,
                            tintAlpha: 0.5),
                      );
                    },
                  ),
                ),
              )
            ],
            alignment: Alignment.center,
          ),
        )
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    FlutterNativeSplash.remove();
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));

    animationElev = Tween<double>(begin: 1, end: 10).animate(CurvedAnimation(
        parent: animationController,
        curve: Curves.fastOutSlowIn));

    animationElev.addListener(() {
      LogUtil.e("elev: ${animationElev.value}");
    });
  }
}
