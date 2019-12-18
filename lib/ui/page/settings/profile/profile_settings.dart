import 'package:eczakazanc/models/User.dart';
import 'package:eczakazanc/utils/network_utils.dart';
import 'package:eczakazanc/utils/uidata.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class ProfileSettingsPage extends StatefulWidget {
  ProfileSettingsPage({Key key}) : super(key: key);

  _ProfileSettingsPageState createState() => new _ProfileSettingsPageState();
}

class _ProfileSettingsPageState extends State<ProfileSettingsPage> {
  BuildContext _context;
  Future<dynamic> _futureData;
  bool _saving = false;
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  GlobalKey<FormState> _key = new GlobalKey();
  bool _validate = false;

  String _eczaneadError, _adError, _cepError, _adresError;

  TextEditingController eczaneglnController = TextEditingController();
  TextEditingController eczaneadController = TextEditingController();
  TextEditingController adsoyadController = TextEditingController();
  MaskedTextController telController = MaskedTextController(mask: "000 000 00 00");
  MaskedTextController cepController = MaskedTextController(mask: "000 000 00 00");
  TextEditingController adresController = TextEditingController();

  @override
	void initState() {
		super.initState();
    _futureData = getProfileDetails(_context);
	}

  static Future<User> getProfileDetails(BuildContext context) async {
    String url = '/api/me';
    var data = await NetworkUtils().get(context, url);

    return User.fromJson(data);
  }

   _sendToServer() async {
    FocusScope.of(context).requestFocus(new FocusNode());
    setState(() {
      _saving = true;
    });
    if (_key.currentState.validate()) {
      // No any error in validation
      _key.currentState.save();

      var responseJson = await NetworkUtils().post(context, '/api/profileSettings', body: {
        'musteri_eczanegln': eczaneglnController.text,
        'musteri_eczanead': eczaneadController.text,
        'musteri_adsoyad': adsoyadController.text,
        'musteri_tel': telController.text,
        'musteri_cep': cepController.text,
        'musteri_adres': adresController.text,
      });

			if(responseJson == null) {

				NetworkUtils.showSnackBar(_scaffoldKey, 'Bağlantı hatası!');

			} else if(responseJson == 'NetworkError') {

				NetworkUtils.showSnackBar(_scaffoldKey, null);

			} else if(responseJson['success'] == false) {

				NetworkUtils.showSnackBar(_scaffoldKey, 'Kayıt yapılamadı');

			} else {
        
        Navigator.of(_scaffoldKey.currentContext)
					.pushReplacementNamed(UIData.dashboardRoute);
			}
    } else {
      // validation error
      setState(() {
        _validate = true;
      });
    }
    setState(() {
      _saving = false;
    });
  }


  Widget bodyData(BuildContext context, data) => SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[fillEntries(context, data)],
        ),
      );

  Widget fillEntries(BuildContext context, data) {
    eczaneglnController.text = data.musteriEczanegln;
    eczaneadController.text = data.musteriEczanead;
    adsoyadController.text = data.musteriAdsoyad;
    telController.text = data.musteriTel;
    cepController.text = data.musteriCep;
    adresController.text = data.musteriAdres;
    return Form(
          key: _key,
          autovalidate: _validate,
          child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextFormField(
                enabled: false,
                controller: eczaneglnController,
                keyboardType: TextInputType.number,
                style: TextStyle(
                    fontFamily: UIData.ralewayFont, color: Colors.black),
                //onChanged: (out) => cardBloc.ccInputSink.add(ccMask.text),
                decoration: InputDecoration(
                    labelText: "Eczane GLN Kodu",
                    icon: Icon(Icons.assignment_ind),
                    labelStyle: TextStyle(fontWeight: FontWeight.bold),
                    border: OutlineInputBorder()),
              ),
              new SizedBox(
                height: 20.0,
              ),
              TextFormField(
                controller: eczaneadController,
                validator: validateEczaneAd,
                keyboardType: TextInputType.text,
                style: TextStyle(
                    fontFamily: UIData.ralewayFont, color: Colors.black),
                //onChanged: (out) => cardBloc.ccInputSink.add(ccMask.text),
                decoration: InputDecoration(
                    labelText: "Eczane Adı",
                    icon: Icon(Icons.store),
                    labelStyle: TextStyle(fontWeight: FontWeight.bold),
                    border: OutlineInputBorder()),
              ),
              new SizedBox(
                height: 20.0,
              ),
              TextFormField(
                controller: adsoyadController,
                validator: validateAdSoyad,
                keyboardType: TextInputType.text,
                style: TextStyle(
                    fontFamily: UIData.ralewayFont, color: Colors.black),
                //onChanged: (out) => cardBloc.expInputSink.add(expMask.text),
                decoration: InputDecoration(
                    errorText: _adError,
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    labelText: "Ad Soyad",
                    icon: Icon(Icons.perm_identity),
                    border: OutlineInputBorder()),
              ),
              new SizedBox(
                height: 20.0,
              ),
              TextFormField(
                controller: telController,
                keyboardType: TextInputType.phone,
                style: TextStyle(
                    fontFamily: UIData.ralewayFont, color: Colors.black),
                //onChanged: (out) => cardBloc.cvvInputSink.add(out),
                decoration: InputDecoration(
                    labelStyle: TextStyle(fontWeight: FontWeight.bold),
                    icon: Icon(Icons.phone_in_talk),
                    labelText: "Telefon Numarası",
                    border: OutlineInputBorder()),
              ),
              new SizedBox(
                height: 20.0,
              ),
              TextFormField(
                controller: cepController,
                validator: validateCep,
                keyboardType: TextInputType.phone,
                style: TextStyle(
                    fontFamily: UIData.ralewayFont, color: Colors.black),
                //onChanged: (out) => cardBloc.nameInputSink.add(out),
                decoration: InputDecoration(
                    errorText: _cepError,
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    icon: Icon(Icons.phone_android),
                    labelText: "GSM Numarası",
                    border: OutlineInputBorder()),
              ),
              new SizedBox(
                height: 20.0,
              ),
              TextFormField(
                controller: adresController,
                validator: validateAdres,
                keyboardType: TextInputType.text,
                maxLines: 3,
                style: TextStyle(
                    fontFamily: UIData.ralewayFont, color: Colors.black),
                //onChanged: (out) => cardBloc.nameInputSink.add(out),
                decoration: InputDecoration(
                    errorText: _adresError,
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    icon: Icon(Icons.satellite),
                    labelText: "Adres",
                    border: OutlineInputBorder()),
              ),
            ],
          ),
        ),
    );
  }

  String validateEczaneAd(String value) {
    if (value.length == 0) {
      return "Eczane adı boş olamaz";
    } else if (value.length < 4) {
      return "Eczane adı 4 haneden kısa olamaz";
    }
    return null;
  }

  String validateAdSoyad(String value) {
    if (value.length == 0) {
      return "Ad soyad boş olamaz";
    } else if (value.length < 4) {
      return "Ad soyad 4 haneden kısa olamaz";
    }
    return null;
  }

  String validateCep(String value) {
    if (value.length == 0) {
      return "GSM numarası boş olamaz";
    } else if(value.length != 13){
      return "GSM numarası 10 haneden oluşur";
    }
    return null;
  }

  String validateAdres(String value) {
    if (value.length == 0) {
      return "Adres boş olamaz";
    } else if (value.length < 4) {
      return "Adres 4 haneden kısa olamaz";
    }
    return null;
  }

  Widget floatingBar() => Ink(
        decoration: ShapeDecoration(
            shape: StadiumBorder(),
            gradient: LinearGradient(colors: UIData.kitGradients)),
        child: FloatingActionButton.extended(
          onPressed: _sendToServer,
          backgroundColor: Colors.transparent,
          icon: Icon(
            FontAwesomeIcons.check,
            color: Colors.white,
          ),
          label: Text(
            "Profili Kaydet",
            style: TextStyle(color: Colors.white),
          ),
        ),
      );

  Widget _loadingScreen() => Scaffold(
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
  
  @override
  Widget build(BuildContext context) {
    _context = context;
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
                resizeToAvoidBottomPadding: true,
                appBar: AppBar(
                  centerTitle: false,
                  title: Text("Profil Ayarları"),
                ),
                body: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    FocusScope.of(context).requestFocus(new FocusNode());
                  },
                  child: ModalProgressHUD(child: bodyData(context, snapshot.data), inAsyncCall: _saving, color: Colors.black),
                ),
                floatingActionButton: floatingBar(),
                floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
              );
        }
    });
  }
}
