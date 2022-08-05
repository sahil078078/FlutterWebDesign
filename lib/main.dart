import 'package:flutter/material.dart';
import 'package:flutter_web_design/ResponsiveLayout/responsive_web_home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          accentColor: const Color(0xffdb7c26),
        ),
        appBarTheme: AppBarTheme(
          elevation: 0.0,
          centerTitle: true,
          color: const Color(0xffdb7c26),
          actionsIconTheme: IconThemeData(
            color: Colors.black.withOpacity(0.52),
          ),
        ),
      ),
      home: const ResponsiveWebHome(),
    );
  }
}
