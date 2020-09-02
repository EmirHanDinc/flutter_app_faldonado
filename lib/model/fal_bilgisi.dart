import 'package:cloud_firestore/cloud_firestore.dart';

class FalBilgisi {
  String resim1;
  String resim2;
  String resim3;
  Timestamp tarih;
  String cinsiyet;
  String user_id;
  String fal_id;
  String isim;
  String iliski;
  String dogum_tarihi;

  FalBilgisi(
      {this.resim1,
      this.resim2,
      this.resim3,
      this.tarih,
      this.isim,
      this.iliski,
      this.cinsiyet,
      this.dogum_tarihi,
      this.fal_id,
      this.user_id});

    FalBilgisi.firebaseDenOkudugunVeriyiDonustur(Map<dynamic, dynamic> map){

        this.resim1 = map['resim1'];
        this.resim2 = map['resim2'];
        this.resim3 = map['resim3'];
        this.tarih = map['tarih'];
        this.iliski = map['iliski'];
        this.cinsiyet = map['cinsiyet'];
        this.dogum_tarihi = map['dogum_tarihi'];
        this.fal_id = map['fal_id'];
        this.isim = map['isim'];
        this.user_id = map['userID'];

    }
}

class FalYorum{

  String fal_id;
  String falcevap;
  String user_id;
  String yorum;

  FalYorum({this.fal_id, this.user_id, this.falcevap, this.yorum});

  FalYorum.firebaseDenGelenFalYorumunuObjeyeDonustur(Map<dynamic, dynamic> map){

    fal_id = map["fal_id"];
    falcevap = map["falcevap"];
    user_id = map["user_id"];
    yorum = map["yorum"];

  }
}
