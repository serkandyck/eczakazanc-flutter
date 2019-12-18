import 'package:eczakazanc/utils/cache_utils.dart';
import 'package:eczakazanc/utils/uidata.dart';
import 'package:flutter/material.dart';
import 'package:auro_avatar/auro_avatar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CommonDrawer extends StatelessWidget {
  String adSoyad;
  String emailAddr;

  CommonDrawer(this.adSoyad, this.emailAddr);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(
              adSoyad,
              style: TextStyle(color: Colors.white),
            ),
            accountEmail: Text(
              emailAddr,
              style: TextStyle(color: Colors.white),
            ),
            currentAccountPicture: new InitialNameAvatar(
                adSoyad,
                circleAvatar: true,
                borderColor: Colors.white,
                borderSize: 2.0,
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                padding: 10.0,
                textSize: 30.0,
            ),
          ),
          new ListTile(
            onTap: () { Navigator.of(context).pushReplacementNamed(UIData.dashboardRoute); },
            title: Text(
              "Gösterge Paneli",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16.0),
            ),
            leading: Icon(
              Icons.dashboard,
              color: Colors.red,
            ),
          ),
          new ListTile(
            onTap: () { Navigator.popAndPushNamed(context, UIData.productsRoute); },
            title: Text(
              "Ortak Alımlar",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16.0),
            ),
            leading: Icon(
              FontAwesomeIcons.bullhorn,
              color: Colors.blue,
            ),
          ),
          new ExpansionTile(
            children: <Widget>[
              ListTile(
                title: Text(
                  "Teklif Oluştur",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16.0),
                ),
                leading: Icon(
                  FontAwesomeIcons.userFriends,
                  color: Colors.orange,
                ),
              ),
              ListTile(
                title: Text(
                  "Tekliflerim",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16.0),
                ),
                leading: Icon(
                  FontAwesomeIcons.userFriends,
                  color: Colors.orange,
                ),
              ),
            ], 
            title: Text(
              "Teklif İşlemleri",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16.0),
            ),
            leading: Icon(
              FontAwesomeIcons.userFriends,
              color: Colors.orange,
            ),
          ),
           new ListTile(
            onTap: () { Navigator.of(context).pushReplacementNamed(UIData.dashboardRoute); },
            title: Text(
              "Alım Yapılan",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16.0),
            ),
            leading: Icon(
              FontAwesomeIcons.archive,
              color: Colors.purple,
            ),
          ),
          new ExpansionTile(
            children: <Widget>[
              ListTile(
                leading: Icon(
                  FontAwesomeIcons.shareSquare,
                  color: Colors.indigo,
                  size: 18.0,
                ),
                title: Text(
                  "Gönderimlerim(Ürün)",
                  textAlign: TextAlign.left,
                ),
              ),
              ListTile(
                leading: Icon(
                  FontAwesomeIcons.shareSquare,
                  color: Colors.indigo,
                  size: 18.0,
                ),
                title: Text(
                  "Gönderimlerim(Eczane)",
                  textAlign: TextAlign.left,
                ),
              ),
            ], 
            title: Text(
              "Gönderim İşlemleri",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16.0),
            ),
            leading: Icon(
              FontAwesomeIcons.shareSquare,
              color: Colors.indigo,
              size: 18.0,
            ),
          ),
          new ListTile(
            title: Text(
              "Kazanç Özeti",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16.0),
            ),
            leading: Icon(
              FontAwesomeIcons.chartLine,
              color: Colors.red,
            ),
          ),
          new ListTile(
            title: Text(
              "Grup Bakiyeleri",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16.0),
            ),
            leading: Icon(
              FontAwesomeIcons.chartPie,
              color: Colors.teal,
              size: 18.0,
            ),
          ),
          new ExpansionTile(
            children: <Widget>[
              ListTile(
                leading: Icon(
                  FontAwesomeIcons.exchangeAlt,
                  color: Colors.cyan,
                  size: 18.0,),
                title: Text(
                  "Sevkiyat Ekle",
                  textAlign: TextAlign.left,
                ),
              ),
              ListTile(
                leading: Icon(
                  FontAwesomeIcons.exchangeAlt,
                  color: Colors.cyan,
                  size: 18.0,),
                title: Text(
                  "Sevkiyat Teslim Al",
                  textAlign: TextAlign.left,
                ),
              ),
              ListTile(
                leading: Icon(
                  FontAwesomeIcons.exchangeAlt,
                  color: Colors.cyan,
                  size: 18.0,),
                title: Text(
                  "Sevkiyat Listem",
                  textAlign: TextAlign.left,
                ),
              ),
              ListTile(
                leading: Icon(
                  FontAwesomeIcons.exchangeAlt,
                  color: Colors.cyan,
                  size: 18.0,),
                title: Text(
                  "Bana Gelecekler",
                  textAlign: TextAlign.left,
                ),
              ),
            ], 
            title: Text(
              "Sevkiyat İşlemleri",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16.0),
            ),
            leading: Icon(
              FontAwesomeIcons.exchangeAlt,
              color: Colors.cyan,
              size: 20.0,
            ),
          ),
          Divider(),
          new ListTile(
            onTap: () { Navigator.popAndPushNamed(context, UIData.settingsRoute); },
            title: Text(
              "Uygulama Ayarları",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16.0),
            ),
            leading: Icon(
              FontAwesomeIcons.cogs,
              color: Colors.indigo,
              size: 20.0,
            ),
          ),
          Divider(),
          new ListTile(
            onTap: () {
              clearCache('jwt-token');
              Navigator.of(context).pushReplacementNamed(UIData.loginRoute); 
            },
            title: Text(
              "Çıkış Yap",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16.0),
            ),
            leading: Icon(
              FontAwesomeIcons.signOutAlt,
              color: Colors.red,
              size: 20.0,
            ),
          ),
          Divider(),
          new ListTile(
            onTap: () { Navigator.popAndPushNamed(context, UIData.aboutRoute); },
            title: Text(
              "EczaKazanç Hakkında",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16.0),
            ),
            leading: Icon(
              FontAwesomeIcons.question,
              color: Colors.blueGrey,
              size: 20.0,
            ),
          ),
        ],
      ),
    );
  }
}
