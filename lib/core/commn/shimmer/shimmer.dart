import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mastermold/core/color/appcolors.dart';
import 'package:shimmer/shimmer.dart';

class loadingshimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: ListView.separated(
          separatorBuilder: (context, index) {
            return Divider();
          },
          itemBuilder: (context, index) {
            return ListTile(
              title: Container(
                constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height / 21),
                color: Colors.white,
              ),
            );
          },
          itemCount: 7,
        ));
  }
}

class loadingnotificationshimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: ListView.separated(
          separatorBuilder: (context, index) {
            return Divider();
          },
          itemBuilder: (context, index) {
            return Container(
              padding: EdgeInsets.only(top: 10),
              child: Center(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.white,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Container(
                        constraints: BoxConstraints(
                            minHeight: MediaQuery.of(context).size.height / 21),
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ),
              constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height / 21),
            );
          },
          itemCount: 7,
        ));
  }
}

class loadingmohomeshimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            alignment: Alignment.center,
            width: double.infinity,
            child: GridView(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount:
                      MediaQuery.sizeOf(context).width > 550 ? 3 : 2,
                  childAspectRatio: 1.4,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10),
              children: mo
                  .map((e) => Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.black26, width: 1),
                            borderRadius: BorderRadius.circular(5)),
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                      ))
                  .toList(),
            )));
  }
}

List mo = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
List dmo = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 1, 2, 3, 4, 5];

class loadingdehomeshimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.15,
          color: Appcolors.maincolor,
          child: Column(
            children: [
              SizedBox(
                height: 15,
              ),
              Expanded(
                child: ListView(
                    children: dmo
                        .map((e) => Column(
                              children: [
                                Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[100]!,
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Container(
                                        width: 25,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: Colors.white,
                                        ),
                                        height: 20,
                                      ),
                                      SizedBox(
                                        width: 7,
                                      ),
                                      Expanded(
                                        child: Container(
                                          height: 20,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: Colors.white),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 22,
                                )
                              ],
                            ))
                        .toList()),
              ),
            ],
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.85,
          height: MediaQuery.of(context).size.width * 1,
          alignment: Alignment.center,
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              padding: const EdgeInsets.all(25),
              alignment: Alignment.center,
              width: double.infinity,
              height: double.infinity,
              child: GridView(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5,
                      childAspectRatio: 1.53,
                      crossAxisSpacing: 5.w,
                      mainAxisSpacing: 5.w),
                  children: mo
                      .map((e) => Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border:
                                    Border.all(color: Colors.black26, width: 1),
                                borderRadius: BorderRadius.circular(5)),
                            padding: EdgeInsets.symmetric(horizontal: 5.w),
                          ))
                      .toList()),
            ),
          ),
        ),
      ],
    );
  }
}
