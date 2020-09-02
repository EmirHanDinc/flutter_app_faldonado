import 'package:flutter/material.dart';
import 'package:flutterappfaldonado/firebase_islemleri.dart';
import 'package:provider/provider.dart';

class ProfilSayfasi extends StatefulWidget {
  @override
  _ProfilSayfasiState createState() => _ProfilSayfasiState();
}

class _ProfilSayfasiState extends State<ProfilSayfasi> {
  var _color = const Color(0xFF853FE1);

  @override
  Widget build(BuildContext context) {
    var userRepo = Provider.of<UserRepository>(context);
    return Container(
      color: _color,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
              child: CircleAvatar(
                backgroundColor: Colors.white,
                backgroundImage: NetworkImage(
                    "https://tmssl.akamaized.net/images/portrait/originals/58088-1572949088.jpg"),
              ),
              width: 150,
              height: 150),
          SizedBox(height: 10,),
          Text(
            userRepo.user.email
                .substring(
                  0,
                  userRepo.user.email.indexOf('@'),
                )
                .toUpperCase(),
            style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 50,
          ),
          Container(
            width: MediaQuery.of(context).size.width-50,
            color: _color,
            height: 40,
            child: Row(
              children: <Widget>[
                Icon(Icons.add_circle_outline, size: 22, color: Colors.black38,),
                SizedBox(width: 25,),
                Center(
                    child: Text(
                      "Kredi Yükle",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,),
                    )),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Divider(height: 5,color: Colors.black,),
          SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: (){
              userRepo.signOut();
            },
            child: Container(
              width: MediaQuery.of(context).size.width - 50,
              height: 40,
              child: Center(
                  child: Text(
                "Çıkış Yap",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.w500),
              )),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                  color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
