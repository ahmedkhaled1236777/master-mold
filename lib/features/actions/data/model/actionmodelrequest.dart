class Actionmodelrequest {
  final String type;
  final String date;
  final String desc;
  final int clientid;
  final int price;

  Actionmodelrequest(
      {required this.type,
      required this.date,
      required this.desc,
      required this.clientid,
      required this.price});
  tojson() => {
        "type": type,
        "client_id": clientid,
        "date": date,
        "description": desc,
        "price": price
      };
}
