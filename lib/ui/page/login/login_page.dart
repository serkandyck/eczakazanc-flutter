import 'package:eczakazanc/ui/widgets/email_field.dart';
import 'package:eczakazanc/ui/widgets/password_field.dart';
import 'package:eczakazanc/ui/widgets/text_button.dart';
import 'package:eczakazanc/utils/cache_utils.dart';
import 'package:eczakazanc/utils/email_validator.dart';
import 'package:eczakazanc/utils/network_utils.dart';
import 'package:flutter/material.dart';
import 'package:eczakazanc/utils/uidata.dart';

class LoginPage extends StatefulWidget  {
  @override
	LoginPageState createState() => new LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
	bool _obscureText = true;
	bool _isLoading = false;
	TextEditingController _emailController, _passwordController;
	String _emailError, _passwordError;

  @override
	void initState() {
		super.initState();
		_fetchSessionAndNavigate();
		_emailController = new TextEditingController();
		_passwordController = new TextEditingController();
	}

  _fetchSessionAndNavigate() async {
    String authToken;
    // kullanıcı daha önce giriş yapmışmı
		await getCache('jwt-token').then((result) {
      authToken = result;
    });
		if(authToken != null) {
			Navigator.of(_scaffoldKey.currentContext)
					.pushReplacementNamed(UIData.dashboardRoute);
		}
	}

  _showLoading() {
		setState(() {
		  _isLoading = true;
		});
	}

	_hideLoading() {
		setState(() {
		  _isLoading = false;
		});
	}

  _authenticateUser() async {
		_showLoading();
		if(_valid()) {
			var responseJson = await NetworkUtils.authenticateUser(
				_emailController.text, _passwordController.text
			);

      print(responseJson);

			if(responseJson == null) {

				NetworkUtils.showSnackBar(_scaffoldKey, 'Sunucu Bağlantı hatası!');

			} else if(responseJson == 'NetworkError') {

				NetworkUtils.showSnackBar(_scaffoldKey, null);

			} else if(responseJson['errors'] != null) {

				NetworkUtils.showSnackBar(_scaffoldKey, responseJson['errors']['email'][0]);

			} else {
        var now = new DateTime.now();
        var exp = now.add(new Duration(minutes: 120)).millisecondsSinceEpoch;
        
        await setDuration('token-duration', exp);
        
        await setCache('jwt-token', responseJson['token']).then((result) {
          Navigator.of(_scaffoldKey.currentContext)
            .pushReplacementNamed(UIData.dashboardRoute);
        });
			}
			_hideLoading();
		} else {
			setState(() {
				_isLoading = false;
				_emailError;
				_passwordError;
			});
		}
	}

  _valid() {
		bool valid = true;

		if(_emailController.text.isEmpty) {
			valid = false;
			_emailError = "E-posta adresi boş olamaz!";
		} else if(!_emailController.text.contains(EmailValidator.regex)) {
			valid = false;
			_emailError = "Lütfen geçerli bir e-posta adresi giriniz!";
		}

		if(_passwordController.text.isEmpty) {
			valid = false;
			_passwordError = "Şifre alanı boş olamaz!";
		} else if(_passwordController.text.length < 6) {
			valid = false;
			_passwordError = "Şifreniz 6 haneden kısa olamaz!";
		}

		return valid;
	}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color.fromRGBO(11, 65, 130, 1.0),
      body: _isLoading ? _loadingScreen() : Center(
        child: loginBody(),
      ),
    );
  }

  void _yeniUye() {
    print("test");
  }
  

  loginBody() => GestureDetector(
    behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
    child : SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[loginHeader(), loginFields()],
        ),
      )
  );

  loginHeader() => Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Image(image: AssetImage(UIData.eczakazancLogo), width: 220.0)
        ],
      );

  loginFields() => Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new EmailField(
              emailController: _emailController,
              emailError: _emailError
            ),
            new PasswordField(
              passwordController: _passwordController,
              obscureText: _obscureText,
              passwordError: _passwordError,
              togglePassword: _togglePassword,
            ),
            SizedBox(
              height: 30.0,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0),
              width: double.infinity,
              child: RaisedButton(
                padding: EdgeInsets.all(12.0),
                shape: StadiumBorder(),
                child: Text(
                  "GİRİŞ",
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.blue,
                onPressed: _authenticateUser,
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            new TextButton(
              buttonName: "Henüz üye değilmisiniz?",
              onPressed: _yeniUye,
              buttonTextStyle: TextStyle(color: Colors.white)
            )
          ],
        ),
      );

      _togglePassword() {
        setState(() {
          _obscureText = !_obscureText;
        });
      }

      Widget _loadingScreen() {
      return new Container(
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
                  'Sisteme giriş yapılıyor',
                  style: new TextStyle(
                    color: Colors.white,
                    fontSize: 16.0
                  ),
                ),
              )
            ],
          )
        )
      );
    }
}
