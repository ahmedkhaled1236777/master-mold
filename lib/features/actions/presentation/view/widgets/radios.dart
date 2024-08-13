import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mastermold/core/color/appcolors.dart';
import 'package:mastermold/features/actions/presentation/viewmodel/cubit/clientactions_cubit.dart';

class radios extends StatelessWidget {
  final String firstradio;
  final String secondradio;
  final String firstradiotitle;
  final String secondradiotitle;
  radios(
      {super.key,
      required this.firstradio,
      required this.secondradio,
      required this.firstradiotitle,
      required this.secondradiotitle});
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var actionbloc = BlocProvider.of<ClientactionsCubit>(context);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Radio(
              activeColor: Appcolors.primarycolor,
              value: firstradio,
              groupValue: actionbloc.type,
              onChanged: (val) {
                actionbloc.changetype(value: val!);
              }),
          Text(
            firstradiotitle,
          ),
          SizedBox(
            width: 10,
          ),
          SizedBox(
            width: 0,
          ),
          Radio(
              activeColor: Appcolors.primarycolor,
              value: secondradio,
              groupValue: actionbloc.type,
              onChanged: (val) {
                actionbloc.changetype(value: val!);
              }),
          Text(
            secondradiotitle,
          ),
        ],
      ),
    );
  }
}
