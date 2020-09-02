import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_islemleri.dart';
import 'model/fal_bilgisi.dart';

class FalCevap extends StatefulWidget {
  String gelenFalID;

  FalCevap({this.gelenFalID});

  @override
  _FalCevapState createState() => _FalCevapState();
}

class _FalCevapState extends State<FalCevap> {
  var userRepo;
  var _color = const Color(0xFF853FE1);

  @override
  Widget build(BuildContext context) {
    userRepo = Provider.of<UserRepository>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: _color,
        title: Text("Fal Yorumu"),
      ),
      body: FutureBuilder(
        future: userRepo.falCevabiSorgula(widget.gelenFalID),
        builder: (BuildContext context, AsyncSnapshot<FalYorum> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.falcevap == "hayır") {
              debugPrint(
                  "Falınız henüz yorumlanmamış." + snapshot.data.falcevap);
              return Container(
                width: MediaQuery.of(context).size.width,
                color: _color,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Falınız Yorumlanıyor...", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),),
                  ],
                ),
              );
            } else {
              debugPrint("user repo fal id si: " + snapshot.data.fal_id);
              return Container(
                color: _color,
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Positioned(
                      width: MediaQuery.of(context).size.width - 50,
                      top: 80,
                      child: Container(
                        child: Padding(
                          padding: EdgeInsets.only(right: 10, left: 10, top: 40, bottom: 10),
                          child: SingleChildScrollView(
                            child: Text(snapshot.data.yorum, style: TextStyle(color: Colors.black87, fontSize: 18),),
                            scrollDirection: Axis.vertical,
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10))
                        ),
                        width: 250,
                        height: MediaQuery.of(context).size.height * 0.7,
                      ),
                    ),
                    Positioned(
                      width: MediaQuery.of(context).size.width - 50,
                      top: 60,
                      left: 20,
                      child: Center(
                        child: Container(
                          child: Center(child: Text("Fal Yorumunuz", style: TextStyle(color: Colors.black54, fontSize: 18, fontWeight: FontWeight.bold),)),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [
                                  Colors.orange,
                                  Colors.yellow,
                                ],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter),
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                10,
                              ),
                            ),
                          ),
                          width: 220,
                          height: 50,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
