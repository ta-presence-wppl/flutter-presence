import 'dart:convert';

class MHistori {
  String? tanggal;
  String? jamMsk;
  String? fotoMsk;
  bool? statusMsk;
  String? jamPlg;
  bool? statusPlg;
  String? fotoPlg;

  MHistori({
    this.tanggal,
    this.jamMsk,
    this.fotoMsk,
    this.statusMsk,
    this.jamPlg,
    this.statusPlg,
    this.fotoPlg,
  });

  factory MHistori.fromJson(Map<String, dynamic> map) {
    return MHistori(
      tanggal: map["tanggal"],
      jamMsk: map["jam_msk"],
      fotoMsk: map["foto_msk"],
      statusMsk: map["false"],
      jamPlg: map["jam_plg"],
      statusPlg: map["status_plg"],
      fotoPlg: map["foto_plg"] ?? '',
    );
  }
}

responseHistori(String? jsonData) {
  final data = json.decode(jsonData!)["data"];
  return List<MHistori>.from(
    data.map(
      (item) => MHistori.fromJson(item),
    ),
  );
}
