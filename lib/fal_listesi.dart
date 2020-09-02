import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterappfaldonado/model/fal_bilgisi.dart';
import 'package:provider/provider.dart';

import 'fal_cevap.dart';
import 'firebase_islemleri.dart';

class FalListesi extends StatefulWidget {
  @override
  _FalListesiState createState() => _FalListesiState();
}

class _FalListesiState extends State<FalListesi> {
  var userRepo;
  var _color = const Color(0xFF853FE1);

  @override
  Widget build(BuildContext context) {
    userRepo = Provider.of<UserRepository>(context);
    return FutureBuilder(
        future: userRepo.verileriOkuveListeYap(),
        builder: (BuildContext context,
            AsyncSnapshot<List<FalBilgisi>> snapshot) {
          if (snapshot.hasData) {
            return Container(
              color: _color,
              child: ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    var geciciTarih =
                        snapshot.data[index].tarih.microsecondsSinceEpoch;
                    var date =
                    DateTime.fromMicrosecondsSinceEpoch(geciciTarih);
                    debugPrint("$date");
                    return Padding(
                      padding: const EdgeInsets.only(
                          left: 8, right: 8, top: 10),
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FalCevap(
                                    gelenFalID: snapshot.data[index].fal_id,
                                  )));
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 100,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [
                                  Colors.orange,
                                  Colors.yellow,
                                ],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter),
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                          ),
                          child: Row(
                            children: <Widget>[
                              SizedBox(
                                width: 15,
                              ),
                              Container(
                                width: 50,
                                height: 50,
                                child: Image.asset(
                                  "assets/drink.png",
                                  fit: BoxFit.contain,
                                ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Text(
                                    "Fal ID: " +
                                        snapshot.data[index].fal_id
                                            .substring(0, 8),
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "Gönderme Tarihi: " +
                                        date.day.toString() +
                                        "/" +
                                        date.month.toString() +
                                        "/" +
                                        date.year.toString() +
                                        " " +
                                        date.hour.toString() +
                                        ":" +
                                        date.second.toString(),
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black54),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}

/*Card(
                      margin: EdgeInsets.all(10),
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FalCevap(
                                        gelenFalID: snapshot.data[index].fal_id,
                                      )));
                        },
                        contentPadding: EdgeInsets.all(15),
                        title: Text("Fal Numaranız: " +
                            snapshot.data[index].fal_id.substring(0, 8)),
                        subtitle: Text("Fal Gönderilme Tarihi: " +
                            date.day.toString() +
                            "/" +
                            date.month.toString() +
                            "/" +
                            date.year.toString() +
                            " " +
                            date.hour.toString() +
                            ":" +
                            date.second.toString()),
                        trailing: Image(
                          image: AssetImage("assets/drink.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );*/
