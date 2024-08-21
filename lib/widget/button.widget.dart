import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ButtonWidget extends StatelessWidget {
  final Function()? onPressed;
  final Widget child;
  const ButtonWidget({super.key, required this.onPressed, required this.child});

  @override
  Widget build(BuildContext context) {
    try {
      if (defaultTargetPlatform == TargetPlatform.iOS ||
          defaultTargetPlatform == TargetPlatform.macOS) {
        return CupertinoButton(
          color: CupertinoColors.activeBlue,
          onPressed: onPressed,
          child: child,
        );
      } else {
        return ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          onPressed: onPressed,
          child: child,
        );
      }
    } catch (e) {
      return ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
        onPressed: onPressed,
        child: child,
      );
    }
  }
}
