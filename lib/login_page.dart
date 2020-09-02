import 'package:flutter/material.dart';
import 'package:flutterappfaldonado/firebase_islemleri.dart';
import 'package:flutterappfaldonado/kayit_ol.dart';
import 'package:provider/provider.dart';

class LoginEkrani extends StatefulWidget {
  @override
  _LoginEkraniState createState() => _LoginEkraniState();
}

class _LoginEkraniState extends State<LoginEkrani> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _email;
  TextEditingController _sifre;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _email = TextEditingController(text: "");
    _sifre = TextEditingController(text: "");
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
      ),
      body: Stack(
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
              height: 250,
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
                            obscureText: true,
                            onTap: () {},
                            onChanged: (value) {},
                            autofocus: false,
                            decoration: InputDecoration(
                              hintText: "Şifreniz",
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
                        if (!await userRepo.signIn(_email.text, _sifre.text)) {
                          debugPrint("Email veya şifre farklı");
                        }else{
                          CircularProgressIndicator();
                        }
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
                        "Giriş Yap",
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
            bottom: 50,
            width: 250,
            child: Column(
              children: <Widget>[
                Text(
                  "Hesabın yok mu?",
                  style: TextStyle(
                      color: Colors.black38,
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>KayitOl(),),);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        colors: [
                          Colors.deepOrange,
                          Colors.orangeAccent,
                        ],
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    height: 40,
                    child: Center(
                        child: Text(
                      "Hesap Oluştur",
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
        ],
      ),
    );
  }
}
