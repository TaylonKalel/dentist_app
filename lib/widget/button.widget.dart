import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final Function()? onPressed;
  final Widget child;
  final Color? color;
  const ButtonWidget(
      {super.key, required this.onPressed, required this.child, this.color});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: color ?? Theme.of(context).colorScheme.primary),
      onPressed: onPressed,
      child: child,
    );
  }
}
