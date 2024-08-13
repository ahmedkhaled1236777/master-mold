import 'package:flutter/material.dart';
import 'package:mastermold/core/color/appcolors.dart';

class Gridelement extends StatelessWidget {
  final String text;
  final String image;
  void Function()? onTap;
  Gridelement({super.key, required this.text, required this.image, this.onTap});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            border: Border.all(color: Appcolors.primarycolor)),
        child: Column(
          children: [
            Expanded(
                child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(7),
                topRight: Radius.circular(7),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  image,
                  fit: BoxFit.fill,
                ),
              ),
            )),
            Container(
                decoration: BoxDecoration(
                    color: Appcolors.primarycolor,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(7),
                        bottomRight: Radius.circular(7))),
                padding: const EdgeInsets.symmetric(vertical: 5),
                width: double.infinity,
                child: Center(
                    child: Text(
                  text,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                )))
          ],
        ),
      ),
    );
  }
}
