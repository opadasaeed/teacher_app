import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingIndecator extends StatelessWidget {
  const LoadingIndecator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: Lottie.asset('assets/animations/loading.json'));
  }
}
