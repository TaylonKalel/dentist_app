import 'package:dentist_app/routes.dart';
import 'package:dentist_app/service_locator.dart';
import 'package:dentist_app/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

void main() {
  ServiceLocator().setup();
  Intl.defaultLocale = 'pt_BR';
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: MaterialTheme(GoogleFonts.dmSansTextTheme()).light(),
      darkTheme: MaterialTheme(GoogleFonts.dmSansTextTheme()).dark(),
      themeMode: ThemeMode.light,
      initialRoute: "/",
      routes: router(context),
    );
  }
}
