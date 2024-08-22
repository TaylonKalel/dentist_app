import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingComponent extends StatelessWidget {
  const LoadingComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Container(
        alignment: Alignment.center,
        width: 100,
        height: 100,
        // child: const CircularProgressIndicator()
        child: Lottie.asset('assets/lottie/dental_loading.json'),
      ),
    );
  }
}
