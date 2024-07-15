import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mastermold/core/color/appcolors.dart';
import 'package:mastermold/features/actions/presentation/viewmodel/cubit/clientactions_cubit.dart';

class Editdeleteradio extends StatelessWidget {
  final String firstradio;
  final String secondradio;
  final String firstradiotitle;
  final String secondradiotitle;
  Editdeleteradio(
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
              groupValue: actionbloc.editordelete,
              onChanged: (val) {
                actionbloc.changeedittype(value: val!);
              }),
          Text(
            firstradiotitle,
            style: TextStyle(fontFamily: "cairo"),
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
              groupValue: actionbloc.editordelete,
              onChanged: (val) {
                actionbloc.changeedittype(value: val!);
              }),
          Text(
            secondradiotitle,
            style: TextStyle(fontFamily: "cairo"),
          ),
        ],
      ),
    );
  }
}
