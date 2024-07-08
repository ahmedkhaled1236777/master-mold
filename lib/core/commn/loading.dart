import 'package:flutter/material.dart';
import 'package:mastermold/core/color/appcolors.dart';

class loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: Appcolors.primarycolor,
      ),
    );
  }
}

class deleteloading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        height: 32,
        width: 32,
        child: CircularProgressIndicator(
          strokeWidth: 3,
          color: Colors.green,
        ),
      ),
    );
  }
}
