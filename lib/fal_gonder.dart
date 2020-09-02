import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'firebase_islemleri.dart';
import 'package:flushbar/flushbar.dart';

class FalGonder extends StatefulWidget {
  String gelenVeri;

  FalGonder(this.gelenVeri);

  @override
  _FalGonderState createState() => _FalGonderState();
}

class _FalGonderState extends State<FalGonder> {
  var _color = const Color(0xFF853FE1);
  var formKey = GlobalKey<FormState>();
  var isimControl = TextEditingController();
  var dtControl = TextEditingController();
  var cinsiyetControl = TextEditingController();
  var iliskiControl = TextEditingController();
  var ekstraBilgiControl = TextEditingController();
  File _secilenResim1;
  File _secilenResim2;
  File _secilenResim3;
  final picker = ImagePicker();
  List<File> _secilenResimListesi = List<File>();
  String _falDurumu = "";
  var yeniUserRepo;

  @override
  Widget build(BuildContext context) {
    yeniUserRepo = Provider.of<UserRepository>(context);
    return widget.gelenVeri == "nav"
        ? Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: _color,
            child: Column(
              children: <Widget>[
                Container(
                  width: 250,
                  height: 250,
                  child: Hero(
                    tag: 'assets/drink.png',
                    child: Image.asset("assets/drink.png"),
                  ),
                ),
              ],
            ),
          )
        : Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              backgroundColor: _color,
              elevation: 0,
              centerTitle: true,
              title: Text("Faldonado"),
            ),
            body: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: _color,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width - 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.black38,
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          15,
                        ),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "Fincan Fotoğraflarınızı Seçiniz",
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black38,
                            offset: new Offset(0, 0),
                            blurRadius: 20.0,
                            spreadRadius: 5.0)
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    width: MediaQuery.of(context).size.width - 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            secilenBirinciResim();
                          },
                          child: _secilenResim1 == null
                              ? Icon(
                                  Icons.add_box,
                                  size: 100,
                                )
                              : Container(
                                  width: 100,
                                  height: 100,
                                  child: Image.file(
                                    _secilenResim1,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                        ),
                        GestureDetector(
                          onTap: () {
                            secilenIkinciResim();
                          },
                          child: _secilenResim2 == null
                              ? Icon(
                                  Icons.add_box,
                                  size: 100,
                                )
                              : Container(
                                  width: 100,
                                  height: 100,
                                  child: Image.file(
                                    _secilenResim2,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                        ),
                        GestureDetector(
                          onTap: () {
                            secilenUcuncuResim();
                          },
                          child: _secilenResim3 == null
                              ? Icon(
                                  Icons.add_box,
                                  size: 100,
                                )
                              : Container(
                                  width: 100,
                                  height: 100,
                                  child: Image.file(
                                    _secilenResim3,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black38,
                            offset: new Offset(0, 0),
                            blurRadius: 20.0,
                            spreadRadius: 5.0)
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    width: MediaQuery.of(context).size.width - 50,
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              validator: (deger) {
                                if (deger.length < 0) {
                                  return "Lütfen geçerli bir mail adresi giriniz.";
                                } else {
                                  return null;
                                }
                              },
                              controller: isimControl,
                              onTap: () {},
                              onChanged: (value) {},
                              autofocus: false,
                              decoration: InputDecoration(
                                disabledBorder: InputBorder.none,
                                hintText: "Adınızı giriniz.",
                                border: OutlineInputBorder(),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              validator: (deger) {
                                if (deger.length < 0) {
                                  return "Lütfen geçerli bir mail adresi giriniz.";
                                } else {
                                  return null;
                                }
                              },
                              controller: dtControl,
                              onTap: () {},
                              onChanged: (value) {},
                              autofocus: false,
                              decoration: InputDecoration(
                                disabledBorder: InputBorder.none,
                                hintText: "Doğum Tarihiniz. ör: (17.07.1987)",
                                border: OutlineInputBorder(),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              validator: (deger) {
                                if (deger.length < 0) {
                                  return "Lütfen geçerli bir mail adresi giriniz.";
                                } else {
                                  return null;
                                }
                              },
                              controller: cinsiyetControl,
                              onTap: () {},
                              onChanged: (value) {},
                              autofocus: false,
                              decoration: InputDecoration(
                                disabledBorder: InputBorder.none,
                                hintText: "Cinsiyetiniz...",
                                border: OutlineInputBorder(),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              validator: (deger) {
                                if (deger.length < 0) {
                                  return "Lütfen geçerli bir ilişki durumu";
                                } else {
                                  return null;
                                }
                              },
                              controller: iliskiControl,
                              onTap: () {},
                              onChanged: (value) {},
                              autofocus: false,
                              decoration: InputDecoration(
                                disabledBorder: InputBorder.none,
                                hintText: "İlişki Durumu",
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (yeniUserRepo.coinDurumu <= 100) {
                        Fluttertoast.showToast(
                            msg: "Fal göndermek için 100 altın gerekmektedir.",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      } else if (_secilenResim1 == null || _secilenResim2 == null || _secilenResim3 == null
                      || isimControl == null || dtControl == null || cinsiyetControl == null || iliskiControl == null) {
                        Fluttertoast.showToast(
                            msg: "Bilgileri lütfen eksiksiz giriniz.",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      } else {
                        showDefaultSnackbar(context);
                        yeniUserRepo.verileriOkuveListeYap();
                        setState(() {
                          debugPrint(yeniUserRepo.falBilgisi);
                        });
                        yeniUserRepo
                            .veriEkle(
                                isim: isimControl.text,
                                dTarih: dtControl.text,
                                cinsiyet: cinsiyetControl.text,
                                iliski: iliskiControl.text,
                                secilenResimListesi: _secilenResimListesi)
                            .whenComplete(() {
                          setState(() {
                            yeniUserRepo.falBilgisi =
                                "Falınız başarıyla gönderildi. En kısa sürede yorumlanacak";
                            showDefaultSnackbar(context);
                            Future.delayed(Duration(milliseconds: 3200))
                                .then((value) {
                              Navigator.pop(context);
                            });
                            debugPrint("Repo içerisinden gelen: " +
                                yeniUserRepo.falBilgisi);
                          });
                        });
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                              Colors.orange,
                              Colors.yellow,
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        color: Colors.white,
                      ),
                      width: 250,
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Hero(
                            tag: 'assets/drink.png',
                            child: Image.asset("assets/drink.png"),
                          ),
                          Text(
                            "Falı Gönder!",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black54),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }

  void secilenBirinciResim() async {
    var resim = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _secilenResim1 = resim;
      _secilenResimListesi.add(_secilenResim1);
    });
  }

  void secilenIkinciResim() async {
    var resim = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _secilenResim2 = resim;
      _secilenResimListesi.add(_secilenResim2);
    });
  }

  void secilenUcuncuResim() async {
    var resim = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _secilenResim3 = resim;
      _secilenResimListesi.add(_secilenResim3);
      debugPrint(
          "Resimlerin listesi: " + _secilenResimListesi.length.toString());
    });
  }

  void showDefaultSnackbar(BuildContext context) {
    debugPrint(
        "Snackbar kısmında gelen falbilgisi: " + yeniUserRepo.falBilgisi);
    Flushbar(
      title: "Bilgi Mesajı",
      duration: Duration(seconds: 3),
      message: "${yeniUserRepo.falBilgisi}",
      backgroundColor: Colors.red,
      boxShadows: [
        BoxShadow(
          color: Colors.blue[800],
          offset: Offset(0.0, 2.0),
          blurRadius: 3.0,
        )
      ],
    )..show(context);
  }
}
