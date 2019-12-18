import 'dart:async';
import 'package:eczakazanc/ui/page/onboard/pages/page1.dart';
import 'package:eczakazanc/ui/page/onboard/pages/page2.dart';
import 'package:eczakazanc/ui/page/onboard/pages/page3.dart';
import 'package:eczakazanc/ui/widgets/dots_indicator.dart';
import 'package:eczakazanc/utils/uidata.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class _OnboardingMainPageState extends State<OnboardingMainPage> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  SharedPreferences _sharedPreferences;
  bool isSeen = true;
  final _controller = new PageController();
  final List<Widget> _pages = [
    Page1(),
    Page2(),
    Page3(),
  ];
  int page = 0;

  @override
  void initState() {
    super.initState();

    new Future<String>.delayed(new Duration(milliseconds: 200), () => '["123", "456", "789"]').then((String value) async {
      _sharedPreferences = await _prefs;
      bool _seen = (_sharedPreferences.getBool('seen') ?? false);
      if(_seen) {
        Navigator.of(context)
            .pushReplacementNamed(UIData.loginRoute);
      } else {
        _sharedPreferences.setBool('seen', true);
        setState(() {
          isSeen = false; 
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if(isSeen) {
      return new Scaffold(
        backgroundColor: Colors.blue[900],
        body: new Stack(
          children: <Widget>[
            new Container(
              margin: const EdgeInsets.only(top: 100.0),
              child: new Center(
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    new CircularProgressIndicator(
                      strokeWidth: 4.0
                    ),
                    new Container(
                      padding: const EdgeInsets.all(8.0),
                      child: new Text(
                        'Uygulama başlatılıyor',
                        style: new TextStyle(
                          color: Colors.white,
                          fontSize: 16.0
                        ),
                      ),
                    )
                  ],
                )
              )
            ),
          ]
        )
      );
    } else {
      bool isDone = page == _pages.length - 1;
      return new Scaffold(
        backgroundColor: Colors.transparent,
        body: new Stack(
          children: <Widget>[
            new Positioned.fill(
              child: new PageView.builder(
                physics: new AlwaysScrollableScrollPhysics(),
                controller: _controller,
                itemCount: _pages.length,
                itemBuilder: (BuildContext context, int index) {
                  return _pages[index % _pages.length];
                },
                onPageChanged: (int p){
                  setState(() {
                    page = p;
                  });
                },
              ),
            ),
            new Positioned(
              top: 0.0,
              left: 0.0,
              right: 0.0,
              child: new SafeArea(
                child: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0.0,
                  primary: false,
                ),
              ),
            ),
            new Positioned(
              bottom: 10.0,
              left: 0.0,
              right: 0.0,
              child: new SafeArea(
                child: new Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        new Container(
                          margin: const EdgeInsets.all(5.0),
                          child: FlatButton(
                            color: Colors.black.withOpacity(0.2),
                            child: Text('ATLA', style: TextStyle(color: Colors.white),),
                            onPressed:  (){
                              Navigator.of(context).pushReplacementNamed(UIData.loginRoute);
                            }
                          ),
                        ),
                        new Container(
                          margin: const EdgeInsets.all(5.0),
                          child: DotsIndicator(
                            controller: _controller,
                            itemCount: _pages.length,
                            onPageSelected: (int page) {
                              _controller.animateToPage(
                                page,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.ease,
                              );
                            },
                          ),
                        ),
                        new Container(
                          margin: const EdgeInsets.all(5.0),
                          child: FlatButton(
                            color: Colors.black.withOpacity(0.2),
                            child: Text(isDone ? 'SON' : 'İLERİ', style: TextStyle(color: Colors.white),),
                            onPressed: isDone ? (){
                              Navigator.of(context).pushReplacementNamed(UIData.loginRoute);
                            } : (){
                              _controller.animateToPage(page + 1, duration: Duration(milliseconds: 300), curve: Curves.easeIn);
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        )
      );
    }
  }
}

class OnboardingMainPage extends StatefulWidget {
  static final String routeName = 'onboard';
  OnboardingMainPage({Key key}) : super(key: key);

  @override
  _OnboardingMainPageState createState() => new _OnboardingMainPageState();
}
