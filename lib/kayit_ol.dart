import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import 'firebase_islemleri.dart';


class KayitOl extends StatefulWidget {
  @override
  _KayitOlState createState() => _KayitOlState();
}

class _KayitOlState extends State<KayitOl> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _email;
  TextEditingController _sifre;
  TextEditingController _sifreTekrar;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _email = TextEditingController(text: "");
    _sifre = TextEditingController(text: "");
    _sifreTekrar = TextEditingController(text: "");
  }
  @override
  Widget build(BuildContext context) {
    const _color = const Color(0xFF853FE1);
    final userRepo = Provider.of<UserRepository>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: _color,
        elevation: 0,
        centerTitle: true,
        title: Text("Faldonado"),
      ),body: Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Positioned(
          top: 0,
          width: MediaQuery.of(context).size.width,
          child: Container(
            decoration: BoxDecoration(
              color: _color,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30)),
            ),
            width: 250,
            height: 250,
          ),
        ),
        Positioned(
          top: 15,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/drink.png"), fit: BoxFit.contain),
            ),
            width: 250,
            height: 100,
          ),
        ),
        Positioned(
          top: 150,
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.black38,
                    offset: Offset.zero,
                    blurRadius: 50,
                    spreadRadius: 5)
              ],
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            width: MediaQuery.of(context).size.width - 50,
            height: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(28.0),
                  child: Form(
                    key: _formKey,
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
                          controller: _email,
                          onTap: () {},
                          onChanged: (value) {},
                          autofocus: false,
                          decoration: InputDecoration(
                            disabledBorder: InputBorder.none,
                            hintText: "Email adresiniz",
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.email),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          controller: _sifre,
                          onTap: () {},
                          onChanged: (value) {},
                          autofocus: false,
                          decoration: InputDecoration(
                            hintText: "Şifreniz",
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.lock),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          controller: _sifreTekrar,
                          onTap: () {},
                          onChanged: (value) {},
                          autofocus: false,
                          decoration: InputDecoration(
                            hintText: "Şifrenizi Tekrar Giriniz.",
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.lock),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    if (_formKey.currentState.validate()) {
                      if(_sifre.text == _sifreTekrar.text){
                        userRepo.signUp(_email.text, _sifre.text).whenComplete(() {
                          Navigator.pop(context);
                        });
                      }else{
                        Fluttertoast.showToast(
                            msg: "Şifreleriniz uyuşmuyor!",
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );
                      }
                    }else{
                      Fluttertoast.showToast(
                          msg: "Email ve şifrenizi kontrol ediniz.",
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0
                      );
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        colors: [
                          _color,
                          Colors.purple,
                        ],
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    width: 200,
                    height: 40,
                    child: Center(
                        child: Text(
                          "Kayıt OL",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 18),
                        )),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 15,
          child: Container(
            child: Text("Kayıt olarak kullanım koşullarını kabul etmiş sayılırsınız.", style: TextStyle(color: Colors.black54),),
          ),
        ),
      ],
    ),
    );
  }
}
