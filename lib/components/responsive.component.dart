import 'package:dentist_app/components/models/responsive.modal.dart';
import 'package:flutter/material.dart';

class ResponsiveComponent extends StatelessWidget {
  final ResponsiveModel responsiveLayout;
  const ResponsiveComponent({
    super.key,
    required this.responsiveLayout,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 400) {
          if (responsiveLayout.mobilebWidget == null) {
            throw Exception("Widget não pode ser vazio");
          }
          return responsiveLayout.mobilebWidget!;
        }
        if (constraints.maxWidth >= 400 && constraints.maxWidth < 800) {
          if (responsiveLayout.mobilebWidget == null) {
            throw Exception("Widget não pode ser vazio");
          }
          return responsiveLayout.mobilebWidget!;
        }
        if (constraints.maxWidth >= 800) {
          if (responsiveLayout.webWidget == null) {
            throw Exception("Widget não pode ser vazio");
          }
          return responsiveLayout.webWidget!;
        }
        return const Center(child: Text("Tela não padronizado"));
      },
    );
  }
}
