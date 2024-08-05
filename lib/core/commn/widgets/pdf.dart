import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';

import '../../../features/actions/data/model/actionmodel/datum.dart';

class pdfservice {
  static Future<File> generatepdf(
      List<Datum> m, String name, Uint8List bytes, int maden, int daen) async {
    final pdf = pw.Document();
    final theme = pw.ThemeData.withFont(
      base: Font.ttf(await rootBundle
          .load('assets/fonts/Cairo-VariableFont_slnt,wght.ttf')),
      bold: Font.ttf(await rootBundle
          .load('assets/fonts/Cairo-VariableFont_slnt,wght.ttf')),
    );

    pdf.addPage(pw.MultiPage(
      theme: theme,
      textDirection: TextDirection.rtl,
      build: (context) => [
        pw.Row(children: [
          pw.Expanded(
              child: pw.Container(
                  child: pw.Column(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                      children: [
                        pw.Row(children: [
                          pw.SizedBox(width: 5),
                          pw.Text("Master Mold Hassan Fathy",
                              style: pw.TextStyle(color: PdfColors.red)),
                          pw.Spacer(),
                          pw.Text("ماستر مولد حسن فتحي",
                              style: pw.TextStyle(color: PdfColors.red)),
                          pw.SizedBox(width: 5),
                        ]),
                        pw.Row(children: [
                          pw.SizedBox(width: 5),
                          pw.Text("For Tools, Molds",
                              style: pw.TextStyle(color: PdfColors.blue700)),
                          pw.Spacer(),
                          pw.Text("للعدد والقوالب",
                              style: pw.TextStyle(color: PdfColors.blue700)),
                          pw.SizedBox(width: 5),
                        ]),
                        pw.Row(children: [
                          pw.SizedBox(width: 5),
                          pw.Text("And Spare Parts",
                              style: pw.TextStyle(color: PdfColors.cyan900)),
                          pw.Spacer(),
                          pw.Text("وقطع الغيار",
                              style: pw.TextStyle(color: PdfColors.cyan900)),
                          pw.SizedBox(width: 5),
                        ])
                      ]),
                  height: 85,
                  decoration: pw.BoxDecoration(
                      gradient: pw.LinearGradient(
                          begin: pw.Alignment.bottomCenter,
                          end: pw.Alignment.topCenter,
                          colors: [PdfColors.blue500, PdfColors.white])))),
          pw.SizedBox(width: 5),
          pw.Container(
            decoration: pw.BoxDecoration(
                border: pw.Border(
              bottom: pw.BorderSide(color: PdfColors.black),
            )),
            alignment: pw.Alignment.center,
            height: 85,
            child: pw.Image(pw.MemoryImage(bytes)),
          )
        ]),
        pw.SizedBox(height: 10),
        pw.Row(children: [
          pw.Text("الحسابات",
              style: pw.TextStyle(
                  fontSize: 15,
                  fontBold: Font.courier(),
                  decoration: pw.TextDecoration.underline)),
          pw.Spacer(),
          pw.Text(
              "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}"
                  .toString(),
              style: pw.TextStyle(
                  fontSize: 15,
                  fontBold: Font.courier(),
                  decoration: pw.TextDecoration.underline)),
        ]),
        pw.Row(mainAxisAlignment: pw.MainAxisAlignment.center, children: [
          pw.Text("كشف حساب السيد /",
              style: pw.TextStyle(
                  fontSize: 15,
                  fontBold: Font.courier(),
                  color: PdfColors.purple)),
          pw.Text(name,
              style: pw.TextStyle(
                  fontSize: 15,
                  fontBold: Font.courier(),
                  color: PdfColors.red)),
        ]),
        pw.SizedBox(height: 10),
        pw.Table.fromTextArray(
            headerHeight: 10,
            cellHeight: 10,
            columnWidths: {
              0: pw.FixedColumnWidth(PdfPageFormat.cm * 2),
              1: pw.FixedColumnWidth(PdfPageFormat.cm * 2),
              2: pw.FixedColumnWidth(PdfPageFormat.cm * 3),
              3: pw.FixedColumnWidth(PdfPageFormat.cm * 3),
            },
            cellAlignment: pw.Alignment.center,
            headerAlignment: pw.Alignment.center,
            headerDecoration: pw.BoxDecoration(color: PdfColors.amber),
            headers: [
              "مبلغ الصيانه",
              "المبلغ المدفوع",
              "البيان",
              "التاريخ",
            ],
            data: m.map((item) {
              return [
                item.type == "maintenance" ? item.price : "",
                item.type == "payment" ? item.price : "",
                item.description,
                item.date,
              ];
            }).toList()),
        pw.Container(
            width: PdfPageFormat.cm * 50,
            child: pw.Text("اجمالي الرصيد والحركه",
                textAlign: pw.TextAlign.center,
                style: pw.TextStyle(color: PdfColors.white)),
            decoration: pw.BoxDecoration(
                color: PdfColors.blue800,
                border: pw.Border(
                    bottom: pw.BorderSide(color: PdfColors.black),
                    top: pw.BorderSide(color: PdfColors.black),
                    right: pw.BorderSide(color: PdfColors.black),
                    left: pw.BorderSide(color: PdfColors.black)))),
        pw.Container(
            width: PdfPageFormat.cm * 50,
            child: pw.Row(children: [
              pw.Container(
                  width: PdfPageFormat.cm * 3,
                  padding: pw.EdgeInsets.symmetric(horizontal: 20),
                  child: pw.Text("مدين",
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(color: PdfColors.blue800)),
                  decoration: pw.BoxDecoration(
                      border: pw.Border(
                          left: pw.BorderSide(color: PdfColors.black)))),
              pw.Expanded(
                child: pw.Text(maden.toString(),
                    textAlign: pw.TextAlign.center,
                    style: pw.TextStyle(color: PdfColors.blue800)),
              )
            ]),
            decoration: pw.BoxDecoration(
                border: pw.Border(
                    bottom: pw.BorderSide(color: PdfColors.black),
                    top: pw.BorderSide(color: PdfColors.black),
                    right: pw.BorderSide(color: PdfColors.black),
                    left: pw.BorderSide(color: PdfColors.black)))),
        pw.Container(
            width: PdfPageFormat.cm * 50,
            child: pw.Row(children: [
              pw.Container(
                  width: PdfPageFormat.cm * 3,
                  child: pw.Text("دائن",
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(color: PdfColors.blue800)),
                  decoration: pw.BoxDecoration(
                      border: pw.Border(
                          left: pw.BorderSide(color: PdfColors.black)))),
              pw.Expanded(
                child: pw.Text(daen.toString(),
                    textAlign: pw.TextAlign.center,
                    style: pw.TextStyle(color: PdfColors.blue800)),
              )
            ]),
            decoration: pw.BoxDecoration(
                border: pw.Border(
                    bottom: pw.BorderSide(color: PdfColors.black),
                    top: pw.BorderSide(color: PdfColors.black),
                    right: pw.BorderSide(color: PdfColors.black),
                    left: pw.BorderSide(color: PdfColors.black)))),
      ],
    ));

    return await savepdf(name, pdf);
  }

  static Future<File> savepdf(String filename, pw.Document pdf) async {
    final bytes = await pdf.save();
    var dir = await getExternalStorageDirectory();
    final file = File('${dir!.path}/$filename.pdf');
    await file.writeAsBytes(bytes);
    return file;
  }

  static Future openfile(File file) async {
    final url = file.path;
    return await OpenFile.open(url);
  }
}
