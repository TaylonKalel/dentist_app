import 'package:dentist_app/widget/text.widget.dart';
import 'package:flutter/material.dart';

class BadgeWidget extends StatelessWidget {
  const BadgeWidget({
    super.key,
    required this.text,
    this.color,
    this.colorText,
  });

  final Color? colorText;
  final Color? color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 8),
      decoration: BoxDecoration(
          color: color ?? Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(5)),
      child: TextWidget(
        text: text,
        color: colorText ?? Colors.white,
        fontSize: 15,
      ),
    );
  }
}
