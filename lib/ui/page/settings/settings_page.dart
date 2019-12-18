import 'package:eczakazanc/models/User.dart';
import 'package:eczakazanc/ui/widgets/common_scaffold.dart';
import 'package:eczakazanc/utils/network_utils.dart';
import 'package:eczakazanc/utils/uidata.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'dart:io' show Platform;

class SettingsPage extends StatefulWidget {

  @override
	SettingsPageState createState() => new SettingsPageState();
  
}

class SettingsPageState extends State<SettingsPage> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  Future<dynamic> _futureData;
  bool _saving = false;
  bool _isAndroid  = Platform.isAndroid;

  @override
	void initState() {
		super.initState();
    _futureData = getNotificationDetail(context);
	}

  static Future<User> getNotificationDetail(BuildContext context) async {
    String url = '/api/me';
    var data = await NetworkUtils().get(context, url);

    return User.fromJson(data);
  }

  void _notificationSync() async {
    setState(() {
      _saving = true;
    });
    var status = await OneSignal.shared.getPermissionSubscriptionState();
    var playerId = "";
    if (status.subscriptionStatus.subscribed) {
      playerId = status.subscriptionStatus.userId;
    }
    await NetworkUtils().post(context, "/api/registerUserDevice", body:{
      "player_id": playerId
    });
    setState(() {
      _saving = false;
    });
  }

  void _turnNotification() async {
    setState(() {
      _saving = true;
    });
    await NetworkUtils().get(context, "/api/changeNotificationSettings");
    setState(() {
      _saving = false;
      _futureData = getNotificationDetail(context);
    });
  }

  void _turndoNotDisrupt() async {
    setState(() {
      _saving = true;
    });
    await NetworkUtils().get(context, "/api/doNotDistrup");
    setState(() {
      _saving = false;
      _futureData = getNotificationDetail(context);
    });
  }

  Widget bodyData(BuildContext context, data) {
    
    return SingleChildScrollView(
        child: Theme(
          data: ThemeData(fontFamily: UIData.ralewayFont),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              //1
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Bildirim Ayarları",
                  style: TextStyle(color: Colors.grey.shade700),
                ),
              ),
              Card(
                color: Colors.white,
                elevation: 2.0,
                child: Column(
                  children: <Widget>[
                    ListTile(
                      leading: Icon(
                        Icons.do_not_disturb_off,
                        color: Colors.orange,
                      ),
                      title: Text("Bildirimleri Kapat"),
                      trailing: _isAndroid
                      ? Switch(
                          value: data.userde.bildirim < 1 ? true : false,
                          onChanged: (val) {
                            _turnNotification();
                          },
                        )
                      : CupertinoSwitch(
                          value: data.userde.bildirim < 1 ? true : false,
                          onChanged: (val) {
                            _turnNotification();
                          },
                        ),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.schedule,
                        color: Colors.blue,
                      ),
                      title: Text("Gece Rahatsız Etme"),
                      trailing: _isAndroid
                      ? Switch(
                          value: data.userde.geceBildirim < 1 ? false : true,
                          onChanged: (val) {
                            _turndoNotDisrupt();
                          },
                        )
                      : CupertinoSwitch(
                          value: data.userde.geceBildirim < 1 ? false : true,
                          onChanged: (val) {
                            _turndoNotDisrupt();
                          },
                        ),
                    ),
                    ListTile(
                      onTap: _notificationSync,
                      leading: Icon(
                        Icons.sync,
                        color: Colors.teal,
                      ),
                      title: Text("Bildirim Ayarlarını Eşitle"),
                      trailing: Icon(Icons.arrow_right),
                    ),
                  ],
                ),
              ),

              //2
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Kullanıcı Bilgileri",
                  style: TextStyle(color: Colors.grey.shade700),
                ),
              ),
              Card(
                color: Colors.white,
                elevation: 2.0,
                child: Column(
                  children: <Widget>[
                    ListTile(
                      leading: Icon(
                        Icons.assignment_ind,
                        color: Colors.indigo,
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, UIData.profileSettingsRoute);
                      },
                      title: Text("Profil Bilgilerini Düzenle"),
                      trailing: Icon(Icons.arrow_right),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.edit_attributes,
                        color: Colors.purple,
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, UIData.passwordSettingsRoute);
                      },
                      title: Text("Şifre Değiştir"),
                      trailing: Icon(Icons.arrow_right),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
  }

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
                  'Veriler Yükleniyor',
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
              return CommonScaffold(
                appTitle: "Uygulama Ayarları",
                showDrawer: false,
                showFAB: false,
                backGroundColor: Colors.grey.shade300,
                bodyData: ModalProgressHUD(child: bodyData(context, snapshot.data), inAsyncCall: _saving, color: Colors.black),
              );
        }
    });
  }
}
