import 'package:dentist_app/components/models/responsive.modal.dart';
import 'package:dentist_app/components/responsive.component.dart';
import 'package:dentist_app/pages/home/home.mobile.widget.dart';
import 'package:dentist_app/pages/home/home.web.widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveComponent(
        responsiveLayout: ResponsiveModel(
            mobilebWidget: const HomeMobileWidget(),
            tableWidget: const HomeMobileWidget(),
            webWidget: const HomeWebWidget()));
  }
}
