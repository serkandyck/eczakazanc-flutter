import 'package:eczakazanc/utils/network_utils.dart';
import 'package:eczakazanc/utils/uidata.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class ChangePasswordPage extends StatefulWidget {
  ChangePasswordPage({Key key}) : super(key: key);

  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {

  bool _saving = false;
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  GlobalKey<FormState> _key = new GlobalKey();
  bool _validate = false;
  bool newPasswordVisible;
  bool newPasswordConfirmationVisible;

  TextEditingController newPasswordController = TextEditingController();
  TextEditingController newPasswordConfirmationController = TextEditingController();

  @override
	void initState() {
		super.initState();
    newPasswordVisible = true;
    newPasswordConfirmationVisible = true;
	}
  

  Widget bodyData() => SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[fillEntries()],
        ),
      );

  Widget fillEntries() {
    return Form(
          key: _key,
          autovalidate: _validate,
          child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new SizedBox(
                height: 20.0,
              ),
              TextFormField(
                controller: newPasswordController,
                obscureText: newPasswordVisible,
                validator: validateNewPassword,
                keyboardType: TextInputType.text,
                style: TextStyle(
                    fontFamily: UIData.ralewayFont, color: Colors.black),
                decoration: InputDecoration(
                    labelText: "Yeni Şifre",
                    suffixIcon: IconButton(
                      icon: Icon(
                        newPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        setState(() {
                          newPasswordVisible = !newPasswordVisible; 
                        });
                      },
                    ),
                    icon: Icon(Icons.store),
                    labelStyle: TextStyle(fontWeight: FontWeight.bold),
                    border: OutlineInputBorder()),
              ),
              new SizedBox(
                height: 20.0,
              ),
              TextFormField(
                controller: newPasswordConfirmationController,
                obscureText: newPasswordConfirmationVisible,
                validator: validateConfirmationPassword,
                keyboardType: TextInputType.text,
                style: TextStyle(
                    fontFamily: UIData.ralewayFont, color: Colors.black),
                decoration: InputDecoration(
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    labelText: "Yeni şifre(tekrar)",
                    suffixIcon: IconButton(
                      icon: Icon(
                        newPasswordConfirmationVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        setState(() {
                          newPasswordConfirmationVisible = !newPasswordConfirmationVisible; 
                        });
                      },
                    ),
                    icon: Icon(Icons.perm_identity),
                    border: OutlineInputBorder()),
              ),
            ],
          ),
        ),
    );
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
            "Şifre Değiştir",
            style: TextStyle(color: Colors.white),
          ),
        ),
      );

  _sendToServer() async {
    FocusScope.of(context).requestFocus(new FocusNode());
    if (_key.currentState.validate()) {
      // No any error in validation
      _key.currentState.save();

      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: new Text("Şifre değiştirme isteği"),
            content: new Text("Şifrenizi değiştirdiğiniz takdirde, tüm platformlardaki şifreleriniz güncellenecek ve artık yeni belirlediğiniz şifre ile güncellenecektir"),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new FlatButton(
                child: new Text("İptal"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              new FlatButton(
                child: new Text("Şifreyi değiştir"),
                onPressed: () {
                  setState(() {
                    _saving = true;
                  });

                  changePassword();

                  setState(() {
                    _saving = false;
                  });
                },
              ),
            ],
          );
        },
      );
    } else {
      // validation error
      setState(() {
        _validate = true;
      });
    }
  }

  void changePassword() async {
     var responseJson = await NetworkUtils().post(context, '/api/updatePassword', body: {
        'new_password': newPasswordController.text
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
  }

  String validateNewPassword(String value) {
    if (value.length == 0) {
      return "Yeni şifre boş olamaz";
    } else if (value.length < 6) {
      return "Yeni şifre 6 haneden kısa olamaz";
    }
    return null;
  }

  String validateConfirmationPassword(String value) {
    var newPassword = newPasswordController.text;
    if (value.length == 0) {
      return "Yeni şifre tekrarı boş olamaz";
    } else if (value.length < 6) {
      return "Yeni şifre tekrarı 6 haneden kısa olamaz";
    } else if (value != newPassword) {
      return "Şifreler eşleşmiyor";
    }
    return null;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
          key: _scaffoldKey,
          resizeToAvoidBottomPadding: true,
          appBar: AppBar(
            centerTitle: false,
            title: Text("Şifre Değiştir"),
          ),
          body: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: ModalProgressHUD(child: bodyData(), inAsyncCall: _saving, color: Colors.black),
          ),
          floatingActionButton: floatingBar(),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
