import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mastermold/core/color/appcolors.dart';
import 'package:mastermold/core/commn/widgets/custommaterialbutton.dart';
import 'package:mastermold/core/styles/style.dart';
import 'package:mastermold/features/actions/presentation/viewmodel/cubit/clientactions_cubit.dart';
import 'package:mat_month_picker_dialog/mat_month_picker_dialog.dart';

class Alertcontent extends StatefulWidget {
  final int clientid;

  const Alertcontent({super.key, required this.clientid});
  @override
  State<Alertcontent> createState() => _AlertcontentcontentState();
}

class _AlertcontentcontentState extends State<Alertcontent> {
  int? month;

  int? year;

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(children: [
              SizedBox(
                  width: MediaQuery.sizeOf(context).width > 950
                      ? MediaQuery.sizeOf(context).width * 0.25
                      : MediaQuery.sizeOf(context).width * 1,
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(0),
                        color: Colors.white,
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 20),
                      child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(children: [
                            Text('بحث بواسطة',
                                style: Appstyles.textStyle12
                                    .copyWith(color: Appcolors.maincolor),
                                textAlign: TextAlign.right),
                            const SizedBox(
                              height: 15,
                            ),
                            InkWell(
                              onTap: () async {
                                final selected = await showMonthPicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1970),
                                    lastDate: DateTime(2050),
                                    locale: Locale('ar'));
                                if (selected != null) {
                                  month = selected.month;
                                  year = selected.year;
                                  setState(() {});
                                }
                              },
                              child: Container(
                                height: 50,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: Appcolors.dropcolor,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Colors.grey)),
                                child: Center(
                                  child: Text(
                                    month == null
                                        ? "اختر التاريخ"
                                        : "${month}-${year}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "cairo"),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            custommaterialbutton(
                              button_name: "بحث",
                              onPressed: () {
                                if (year != null && month != null)
                                  BlocProvider.of<ClientactionsCubit>(context)
                                      .queryparms = {
                                    "month": this.month,
                                    "year": this.year
                                  };
                                Navigator.pop(context);
                                BlocProvider.of<ClientactionsCubit>(context)
                                    .firstloading = false;
                                BlocProvider.of<ClientactionsCubit>(context)
                                    .getactions(client_id: widget.clientid);
                              },
                            )
                          ]))))
            ])));
  }
}

Future<void> _onPressed({
  required BuildContext context,
  String? locale,
}) async {}
