import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_islemleri.dart';
import 'kullanici_ekrani.dart';
import 'login_page.dart';

class AtlamaEkrani extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      // ignore: missing_return
      builder: (context, UserRepository userRepo, child) {
        switch (userRepo.durum) {
          case UserDurumu.Idle:
            return SplashEkran();
          case UserDurumu.OturumAciliyor:
          case UserDurumu.OturumAcilmamis:
            return LoginEkrani();
          case UserDurumu.OturumAcik:
            return KullaniciEkrani();
        }
      },
    );
  }
}

class SplashEkran extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Splash / Atlama Ekranı"),
      ),
      body: Center(child: Text("Splash Ekranı HG"),),
    );
  }
}
