import 'package:flutter/material.dart';
import 'package:flutterappfaldonado/ana_sayfa.dart';
import 'package:flutterappfaldonado/fal_cevap.dart';
import 'package:flutterappfaldonado/fal_gonder.dart';
import 'package:flutterappfaldonado/profil.dart';
import 'package:provider/provider.dart';
import 'fal_listesi.dart';
import 'firebase_islemleri.dart';

class KullaniciEkrani extends StatefulWidget {
  @override
  _KullaniciEkraniState createState() => _KullaniciEkraniState();
}

class _KullaniciEkraniState extends State<KullaniciEkrani> {
  int secilenMenuItem = 0;
  List<Widget> tumSayfalar;
  AnaSayfa sayfaAna;
  ProfilSayfasi sayfaProfil;
  FalGonder sayfaFalGonder;
  FalListesi sayfaFalListesi;
  var _color = const Color(0xFF853FE1);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sayfaAna = AnaSayfa();
    sayfaFalGonder = FalGonder("nav");
    sayfaProfil = ProfilSayfasi();
    sayfaFalListesi = FalListesi();
    tumSayfalar = [sayfaAna, sayfaFalListesi, sayfaProfil];
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, UserRepository userRepo, widget) => Scaffold(
        appBar: AppBar(
          backgroundColor: _color,
          elevation: 0,
          centerTitle: true,
          title: Text("Faldonado"),
        ),
        body: tumSayfalar[secilenMenuItem],
        bottomNavigationBar: bottomNavMenu(),
      ),
    );
  }

  BottomNavigationBar bottomNavMenu() {
    return BottomNavigationBar(
      backgroundColor: _color,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
            color: Colors.white,
            size: 30,
          ),
          title: Text(""),
          activeIcon: Icon(
            Icons.home,
            color: Colors.white30,
            size: 30,
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.local_drink,
            color: Colors.white,
            size: 30,
          ),
          title: Text(""),
          activeIcon: Icon(
            Icons.local_drink,
            color: Colors.white30,
            size: 30,
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.person,
            color: Colors.white,
            size: 30,
          ),
          title: Text(""),
          activeIcon: Icon(
            Icons.person,
            color: Colors.white30,
            size: 30,
          ),
        ),
      ],
      currentIndex: secilenMenuItem,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      onTap: (index) {
        setState(() {
          secilenMenuItem = index;
          debugPrint(secilenMenuItem.toString());
        });
      },
    );
  }
}
