import 'package:flutter/material.dart';
import 'package:popweb/src/page/home.dart';


class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "工业信息物理系统科普网",
      theme: ThemeData(
          fontFamily: '仿宋',
          visualDensity: VisualDensity.adaptivePlatformDensity,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          iconTheme: const IconThemeData(
            shadows: [
              Shadow(
                blurRadius: 1.0,
                color: Colors.black,
                offset: Offset(1, 1),
              ),
            ],
          ),
          useMaterial3: true,
          pageTransitionsTheme: const PageTransitionsTheme(builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            TargetPlatform.windows: CupertinoPageTransitionsBuilder(),
          })),
      home: HomePage(),
    );
  }
}
