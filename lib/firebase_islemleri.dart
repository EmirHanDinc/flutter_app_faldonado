import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutterappfaldonado/model/fal_bilgisi.dart';
import 'package:uuid/uuid.dart';

enum UserDurumu { Idle, OturumAcilmamis, OturumAciliyor, OturumAcik }

class UserRepository with ChangeNotifier {
  FirebaseAuth _auth;
  FirebaseUser _user;
  UserDurumu _durum = UserDurumu.Idle;
  Firestore _firestore;
  int _coinDurumu;
  String _falBilgisi = "Falınız gönderiliyor. Lütfen bu ekranı kapatmayın!";

  UserRepository() {
    _auth = FirebaseAuth.instance;
    _firestore = Firestore.instance;
    _auth.onAuthStateChanged.listen(_onAuthStateChanged);
  }

  String get falBilgisi => _falBilgisi;

  set falBilgisi(String value) {
    _falBilgisi = value;
    notifyListeners();
  }

  int get coinDurumu => _coinDurumu;

  set coinDurumu(int value) {
    _coinDurumu = value;
    notifyListeners();
  }

  FirebaseUser get user => _user;

  set user(FirebaseUser value) {
    _user = value;
  }

  UserDurumu get durum => _durum;

  set durum(UserDurumu value) {
    _durum = value;
  }

  Future<bool> signIn(String email, String sifre) async {
    try {
      _durum = UserDurumu.OturumAciliyor;
      notifyListeners();
      await _auth.signInWithEmailAndPassword(email: email, password: sifre);
      return true;
    } catch (e) {
      _durum = UserDurumu.OturumAcilmamis;
      notifyListeners();
      return false;
    }
  }

  Future<bool> signUp(String email, String sifre) async{
    try{
      _durum = UserDurumu.OturumAciliyor;
      notifyListeners();
      AuthResult kayitOlanUser = await _auth.createUserWithEmailAndPassword(email: email, password: sifre);
      debugPrint("Kayıt olan kullanıcı email: " +kayitOlanUser.user.email);
      await _firestore.collection("users").document(_user.email).setData({
        'Cinsiyet' : 'boş',
        'Doğum Tarihi' : '19.19.1995',
        'ad' : 'boş',
        'coin' : 0,
        'email': _user.email,
        'İlişki Durumu': 'boş',
      });
      return true;
    }catch (e){
      _durum = UserDurumu.OturumAcilmamis;
      notifyListeners();
      return false;
    }
  }


  Future signOut() async {
    _auth.signOut();
    _durum = UserDurumu.OturumAcilmamis;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  Future<int> coinSorgula() async {
    DocumentSnapshot documentSnapshot =
        await _firestore.document("users/${_user.email}").get();
    int gelenCoin = documentSnapshot.data['coin'];
    return gelenCoin;
  }

  Future veriEkle(
      {String isim,
      String dTarih,
      String cinsiyet,
      String iliski,
      List<File> secilenResimListesi}) async {
    if (coinDurumu >= 100) {
      List<String> resimlerinLinkleri = List<String>();
      var falID = Uuid();
      var falIDUret = falID.v1();
      //Seçilen fincan fotoğraflarını storage e yükleyip, linklerini veritabanına kaydeden blok
      for (int i = 0; i < secilenResimListesi.length; i++) {
        var uuid = Uuid();
        var v1 = uuid.v1();
        StorageReference ref = FirebaseStorage.instance
            .ref()
            .child("falresimleri")
            .child("falfotosu$v1.png");
        StorageUploadTask uploadTask = ref.putFile(secilenResimListesi[i]);

        var url = await (await uploadTask.onComplete).ref.getDownloadURL();
        resimlerinLinkleri.add(url);
        debugPrint(url);
      }
      

      
      _firestore.collection("fallar").document(/*_user.email*/).setData({
        'fal_id': '$falIDUret',
        'isim': '$isim',
        'resim1': resimlerinLinkleri[0],
        'resim2': resimlerinLinkleri[1],
        'resim3': resimlerinLinkleri[2],
        'dogum_tarihi': '$dTarih',
        'cinsiyet': '$cinsiyet',
        'iliski': '$iliski',
        'userID': _user.email,
        'tarih': FieldValue.serverTimestamp(),
      }, merge: true).then((value) {
        falBilgisi = "Fal Gönderildi!";
      });
      _firestore.collection("users").document(_user.email).updateData({
        'coin': coinDurumu - 100,
      }).then((value) => debugPrint("Coin 100 azaldı."));
      coinDurumu = coinDurumu - 100;

      _firestore.collection("yorum").document(/*_user.email*/).setData({
        'fal_id': '$falIDUret',
        'falcevap': 'hayır',
        'user_id': _user.email,
        'yorum': "boş",
      }, merge: true).then((value) {
        falBilgisi = "Fal, yorum tablosuna eklendi";
      });
    } else {
      debugPrint("fal göndermek için coin yeterli değil");
    }
  }

  Future<List<FalBilgisi>> verileriOkuveListeYap() async {
    List<FalBilgisi> tumFalBilgileriListesi = List<FalBilgisi>();
    await _firestore
        .collection("fallar")
        .limit(10)
        .where("userID", isEqualTo: "${_user.email}")
        .orderBy("tarih", descending: false)
        .getDocuments()
        .then((snapshots) {
      debugPrint("Fal koleksiyonundaki eleman sayısı: " +
          snapshots.documents.length.toString());

      for (int i = 0; i < snapshots.documents.length; i++) {
        tumFalBilgileriListesi.add(FalBilgisi.firebaseDenOkudugunVeriyiDonustur(
            snapshots.documents[i].data));
      }
    });
    return tumFalBilgileriListesi;
  }
  Future<FalYorum> falCevabiSorgula(String falID) async {
    FalYorum falYorumu;
    await _firestore
        .collection("yorum")
        .where("fal_id", isEqualTo: "$falID")
        .getDocuments()
        .then((snapshots) {
      debugPrint("Fal yorumu " + snapshots.documents.length.toString());

      falYorumu = FalYorum.firebaseDenGelenFalYorumunuObjeyeDonustur(
          snapshots.documents[0].data);
      debugPrint("Gelen Fal ID: " + falID);
      debugPrint("Gelen Falın Sahibi: " + falYorumu.user_id);
    });

    return falYorumu;
  }

  Future<void> _onAuthStateChanged(FirebaseUser user) async {
    if (user == null) {
      _durum = UserDurumu.OturumAcilmamis;
    } else {
      _user = user;
      _durum = UserDurumu.OturumAcik;
      coinSorgula().then((value) => coinDurumu = value);
    }

    notifyListeners();
  }
}
