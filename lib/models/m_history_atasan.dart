import 'dart:convert';

class MHistoriAtasan {
  String? tanggal;
  String? jamMsk;
  String? fotoMsk;
  bool? statusMsk;
  String? jamPlg;
  bool? statusPlg;
  String? fotoPlg;
  String? namaPegawai;

  MHistoriAtasan({
    this.tanggal,
    this.jamMsk,
    this.fotoMsk,
    this.statusMsk,
    this.jamPlg,
    this.statusPlg,
    this.fotoPlg,
    this.namaPegawai,
  });

  factory MHistoriAtasan.fromJson(Map<String, dynamic> map) {
    return MHistoriAtasan(
      tanggal: map["tanggal"],
      jamMsk: map["jam_msk"],
      fotoMsk: map["foto_msk"],
      statusMsk: map["status_msk"],
      jamPlg: map["jam_plg"],
      statusPlg: map["status_plg"],
      fotoPlg: map["foto_plg"] ?? '',
      namaPegawai: map["pegawai"]['nama'] ?? '-',
    );
  }
}

responseHistoriAtasan(String? jsonData) {
  final data = json.decode(jsonData!)["data"];
  return List<MHistoriAtasan>.from(
    data.map(
      (item) => MHistoriAtasan.fromJson(item),
    ),
  );
}
