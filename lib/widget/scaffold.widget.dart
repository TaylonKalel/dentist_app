import 'package:dentist_app/components/models/responsive.modal.dart';
import 'package:dentist_app/components/responsive.component.dart';
import 'package:flutter/material.dart';

class ScaffoldWidget extends StatefulWidget {
  final AppBar? appBar;
  final Widget body;
  final Widget? bottomNavigationBar;
  const ScaffoldWidget(
      {super.key, required this.body, this.appBar, this.bottomNavigationBar});

  @override
  State<ScaffoldWidget> createState() => _ScaffoldWidgetState();
}

class _ScaffoldWidgetState extends State<ScaffoldWidget>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveComponent(
        responsiveLayout: ResponsiveModel(
            mobilebWidget: _mobile(),
            tableWidget: _mobile(),
            webWidget: _web()));
  }

  Widget _mobile() {
    return Scaffold(
      appBar: widget.appBar,
      body: widget.body,
      bottomNavigationBar: widget.bottomNavigationBar,
    );
  }

  Widget _web() {
    return SafeArea(
      child: Scaffold(
        appBar: widget.appBar ?? AppBar(),
        body: widget.body,
      ),
    );
  }
}
