import 'package:eczakazanc/models/User.dart';
//import 'package:eczakazanc/ui/page/ilac/ilac_page.dart';
import 'package:eczakazanc/utils/cache_utils.dart';
import 'package:eczakazanc/utils/network_utils.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:eczakazanc/ui/page/dashboard/dashboard_menu_row.dart';
import 'package:eczakazanc/ui/widgets/login_background.dart';
import 'package:eczakazanc/ui/widgets/profile_tile.dart';
import 'package:eczakazanc/utils/uidata.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:eczakazanc/ui/widgets/common_drawer.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'dart:async';
//import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';
//import 'package:audioplayers/audio_cache.dart';

class DashboardPage extends StatefulWidget {
  bool alimBasarili = false;

  DashboardPage({Key key, this.alimBasarili}) : super(key: key);

  @override
	DashboardPageState createState() => new DashboardPageState(this.alimBasarili);
}

class DashboardPageState extends State<DashboardPage> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  final GlobalKey _menuKey = new GlobalKey();
  Size deviceSize;
  Future<dynamic> _futureData;
  //AudioCache audioCache = new AudioCache();

  bool alimBasarili;
  DashboardPageState(this.alimBasarili);



  Future<User> getUserDetail(BuildContext context) async {
    String url = '/api/me';
    var data = await NetworkUtils().get(context, url);
    if(data != null) {
      return User.fromJson(data);
    }
    clearCache('jwt-token');
    Navigator.of(context).pushReplacementNamed(UIData.loginRoute);
  }


  PopupMenuButton _normalDown() => PopupMenuButton<String>(
    key: _menuKey,
    padding: EdgeInsets.zero,
    elevation: 3.2,
    icon: new Icon(Icons.more_vert,color: Colors.white,),
    itemBuilder: (context) => [
              new PopupMenuItem(
                  value: "settings",
                  child: ListTile(
                      leading: Icon(Icons.settings),
                      title: Text('Ayarlar'))),
              
              new PopupMenuItem(
                  value: "about",
                  child: ListTile(
                      leading: Icon(Icons.question_answer),
                      title: Text('Hakkında'))),

              new PopupMenuItem(
                  value: "exit",
                  child: ListTile(
                      leading: Icon(Icons.exit_to_app),
                      title: Text('Çıkış'))),
            ],
            
        onSelected: (_) {
          switch (_) {
            case 'settings':
              return _showSettingsPage();
            case 'about':
              return _showAboutPage();
            case 'exit':
              return _logout();
            default:
              return print("nothing");
          }
        }
  );

  void _showAboutPage() {
    Navigator.pushNamed(context, UIData.aboutRoute);
  }

  void _sendDeviceId() async {

    var status = await OneSignal.shared.getPermissionSubscriptionState();
    var playerId = "";
    if (status.subscriptionStatus.subscribed) {
      playerId = status.subscriptionStatus.userId;
    }
    await NetworkUtils().post(context, "/api/registerUserDevice", body:{
      "player_id": playerId
    });
  }

  /*Future _scanQR() async {
    try {
      String qrResult = await BarcodeScanner.scan();
      print(qrResult);
      audioCache.play('beep.mp3');
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => IlacPage(ilacId: qrResult),
          ),
        );
      print(qrResult);
    } on PlatformException catch (ex) {
      if (ex.code == BarcodeScanner.CameraAccessDenied) {
        print("Camera permission was denied");
      } else {
        print("Unknown Error $ex");
      }
    } on FormatException {
      print("You pressed the back button before scanning anything");
    } catch (ex) {
      print("Unknown Error $ex");
    }
  }*/

  void _logout() {
    clearCache('jwt-token');
    Navigator.of(context).pushReplacementNamed(UIData.loginRoute);
  }

  void _showSettingsPage() {
    Navigator.pushNamed(context, UIData.settingsRoute);
  }

  @override
	void initState() {
		super.initState();
    _futureData = getUserDetail(context);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if(this.alimBasarili) {
        Flushbar(
          title:  "Başarılı",
          message:  "Alım işleminiz başarı ile gerçekleştirilmiştir",
          backgroundGradient: LinearGradient(colors: [Colors.green, Colors.greenAccent]),
          icon: new Icon(Icons.check_circle_outline, color: Colors.white),
          duration:  Duration(seconds: 10),              
        )..show(context);
      }
    });
    _sendDeviceId();
	}

  Widget appBarColumn(BuildContext context, data) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 18.0),
          child: new Column(
            children: <Widget>[
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new IconButton(
                    icon: new Icon(
                      defaultTargetPlatform == TargetPlatform.android
                          ? Icons.menu
                          : Icons.menu,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      _scaffoldKey.currentState.openDrawer();
                    },
                  ),
                  new ProfileTile(
                    title: data.userde.eczane.ad,
                    subtitle: "Bakiyeniz : " + data.userde.bakiye,
                    textColor: Colors.white,
                  ),
                  _normalDown()
                ],
              ),
            ],
          ),
        ),
      );

  Widget searchCard() => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 2.0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: Icon(FontAwesomeIcons.search, size: 16,),
                  onPressed: () { print("search"); },
                ),
                Expanded(
                  child: TextField(
                    textInputAction: TextInputAction.search,
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: "Ürün veya barkod ara"),
                  ),
                ),
                IconButton(
                  icon: Icon(FontAwesomeIcons.barcode),
                  //onPressed: ()/*_scanQR,*/
                ),
                
              ],
            ),
          ),
        ),
      );

  Widget actionMenuCard() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Card(
          elevation: 2.0,
          child: Padding(
            padding: const EdgeInsets.all(1.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  DashboardMenuRow(
                    firstIcon: FontAwesomeIcons.bullhorn,
                    firstLabel: "Ortak\nAlımlar",
                    firstIconCircleColor: Colors.blue,
                    firstOnPressed: UIData.productsRoute,
                    secondIcon: FontAwesomeIcons.userFriends,
                    secondLabel: "Teklif\nİşlemleri",
                    secondIconCircleColor: Colors.orange,
                    secondOnPressed: UIData.teklifOlustur,
                    thirdIcon: FontAwesomeIcons.archive,
                    thirdLabel: "Alım\nYapılan",
                    thirdIconCircleColor: Colors.purple,
                    thirdOnPressed: UIData.teklifOlustur,
                    fourthIcon: FontAwesomeIcons.shareSquare,
                    fourthLabel: "Gönderim\nİşlemleri",
                    fourthIconCircleColor: Colors.indigo,
                    fourthOnPressed: UIData.teklifOlustur,
                  ),
                  DashboardMenuRow(
                    firstIcon: FontAwesomeIcons.chartLine,
                    firstLabel: "Kazanç\nÖzeti",
                    firstIconCircleColor: Colors.red,
                    firstOnPressed: UIData.kazancOzeti,
                    secondIcon: FontAwesomeIcons.chartPie,
                    secondLabel: "Grup\nBakiyeleri",
                    secondIconCircleColor: Colors.teal,
                    thirdIcon: FontAwesomeIcons.exchangeAlt,
                    thirdLabel: "Sevkiyat\nİşlemleri",
                    thirdIconCircleColor: Colors.cyan,
                    thirdOnPressed: UIData.teklifOlustur,
                    fourthIcon: FontAwesomeIcons.cogs,
                    fourthLabel: "Uygulama\nAyarları",
                    fourthOnPressed: UIData.settingsRoute,
                    fourthIconCircleColor: Colors.pink,
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  Widget balanceCard(BuildContext context, data) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 2.0,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Bakiye",
                      style: TextStyle(fontFamily: UIData.ralewayFont),
                    ),
                    Material(
                      color: Colors.black,
                      shape: StadiumBorder(),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "EczaKazanç Oranı :" + data.oran + "%",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: UIData.ralewayFont),
                        ),
                      ),
                    )
                  ],
                ),
                Text(
                  data.userde.bakiye,
                  style: TextStyle(
                      fontFamily: UIData.ralewayFont,
                      fontWeight: FontWeight.w700,
                      color: Colors.green,
                      fontSize: 25.0),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "EczaKazanç Kazancı",
                      style: TextStyle(fontFamily: UIData.ralewayFont),
                    ),
                  ],
                ),
                Text(
                  data.kazanc  + " TL",
                  style: TextStyle(
                      fontFamily: UIData.ralewayFont,
                      fontWeight: FontWeight.w700,
                      color: Colors.green,
                      fontSize: 25.0),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Toplam Kazançlı Alım",
                      style: TextStyle(fontFamily: UIData.ralewayFont),
                    ),
                  ],
                ),
                Text(
                  data.kazancliAlim  + " TL",
                  style: TextStyle(
                      fontFamily: UIData.ralewayFont,
                      fontWeight: FontWeight.w700,
                      color: Colors.green,
                      fontSize: 25.0),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Toplam Alım",
                      style: TextStyle(fontFamily: UIData.ralewayFont),
                    ),
                  ],
                ),
                Text(
                  data.toplamAlim  + " TL",
                  style: TextStyle(
                      fontFamily: UIData.ralewayFont,
                      fontWeight: FontWeight.w700,
                      color: Colors.green,
                      fontSize: 25.0),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Toplam Dağıtılan",
                      style: TextStyle(fontFamily: UIData.ralewayFont),
                    ),
                  ],
                ),
                Text(
                  data.toplamDagitim + " TL",
                  style: TextStyle(
                      fontFamily: UIData.ralewayFont,
                      fontWeight: FontWeight.w700,
                      color: Colors.green,
                      fontSize: 25.0),
                ),
              ],
            ),
          ),
        ),
      );

  Widget allCards(BuildContext context, data) => SingleChildScrollView(
        child: Column(
          children: <Widget>[
            appBarColumn(context, data),
            SizedBox(
              height: deviceSize.height * 0.01,
            ),
            searchCard(),
            SizedBox(
              height: deviceSize.height * 0.01,
            ),
            actionMenuCard(),
            SizedBox(
              height: deviceSize.height * 0.01,
            ),
            balanceCard(context, data),
          ],
        ),
      );

  Widget _loadingScreen() {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color.fromRGBO(11, 65, 130, 1.0),
      body: Container(
        margin: const EdgeInsets.only(top: 100.0),
        child: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new CircularProgressIndicator(
                strokeWidth: 4.0,
                valueColor: new AlwaysStoppedAnimation<Color>(Colors.amber),
              ),
              new Container(
                padding: const EdgeInsets.all(8.0),
                child: new Text(
                  'Veriler Alınıyor',
                  style: new TextStyle(
                    color: Colors.white,
                    fontSize: 16.0
                  ),
                ),
              )
            ],
          )
        )
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    deviceSize = MediaQuery.of(context).size;
    return new FutureBuilder<User>(
      future: _futureData,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return _loadingScreen();
          default:
            if (snapshot.hasError)
              return new Text('Error: ${snapshot.error}');
            else
              return Scaffold(
                key: _scaffoldKey,
                drawer: CommonDrawer(snapshot.data.userde.eczane.ad, snapshot.data.userde.email),
                body: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    LoginBackground(
                      showIcon: false,
                    ),
                    allCards(context, snapshot.data),
                  ],
                ),
              );
        }
    });
  }
}
