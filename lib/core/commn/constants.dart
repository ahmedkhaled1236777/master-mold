import 'package:flutter/material.dart';

Map show = {
  "empty_villa": "فيلا فارغه",
  "furnished_apartment": "شقه مفروشه",
  "empty_apartment": "شقه فارغه",
  "furnished_villa": "فيلا مفروشه",
  "shop": "محل",
  "rent": "ايجار",
  "sale": "بيع",
  "real_state_owner": "صاحب عقار",
  "real_state_company": "شركة عقارات",
  "empty_office": "مكتب ادارى فارغ",
  "furnished_office": "مكتب ادارى مفروش"
};
Map request = {
  "شقه مفروشه": "furnished_apartment",
  "شقه فارغه": "empty_apartment",
  "فيلا مفروشه": "furnished_villa",
  "فيلا فارغه": "empty_villa",
  "محل": "shop",
  "ايجار": "rent",
  "بيع": "sale",
  "صاحب عقار": "real_state_owner",
  "شركة عقارات": "real_state_company",
  "صاحب الارض": "real_state_owner",
  "مكتب ادارى فارغ": "empty_office",
  "مكتب ادارى مفروش": "furnished_office"
};
Map requestland = {
  "شركة عقارات": "real_state_company",
  "صاحب الارض": "real_state_owner"
};
Map showland = {
  "real_state_company": "شركة عقارات",
  "real_state_owner": "صاحب الارض",
};
Map commessionrequest = {"العموله بالنسبه": "per", "العموله بالمبلغ": "val"};
Map commessionresponse = {"per": "العموله بالنسبه", "val": "العموله بالمبلغ"};
Map clientstatussrequest = {
  "انتظار": "waiting",
  "معاينه": "inspection",
  "معاينه مقبوله": "inspection_accepted",
  "معاينه مرفوضه": "inspection_refused",
};
Map clientstatussresponse = {
  "waiting": "انتظار",
  "inspection": "معاينه",
  "inspection_accepted": "معاينه مقبوله",
  "inspection_refused": "معاينه مرفوضه",
};
Map clientsdepartementrequest = {
  "عقار بيع": "state_sale",
  "عقار ايجار": "state_rent",
  "ارض بيع": "land_sale",
};
Map clientsdepartementresponse = {
  "state_sale": "عقار بيع",
  "state_rent": "عقار ايجار",
  "land_sale": "ارض بيع",
};
var refreshicon = Icons.refresh;
bool inhome = false;
bool insplash = true;
Map clientstyperesponsr = {
  "client": "عميل مباشر",
  "company": "شركة عقارات",
};
Map clientstyperequest = {
  "عميل مباشر": "client",
  "شركة عقارات": "company",
};
