import 'package:eczakazanc/models/Teklif.dart';
import 'package:eczakazanc/ui/page/dashboard_page.dart';
import 'package:eczakazanc/utils/uidata.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter_image/network.dart';
import 'package:eczakazanc/utils/network_utils.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class TeklifDetayPage extends StatefulWidget {
  final String teklifId;

  TeklifDetayPage({Key key, @required this.teklifId}) : super(key: key);

  _TeklifDetayPageState createState() => _TeklifDetayPageState(teklifId);
}

class _TeklifDetayPageState extends State<TeklifDetayPage> {
  String teklifId;
  bool _validate = false;
  bool _saving = false;
  bool alimVarmi = false;
  Future<dynamic> _futureData;
  final _scaffoldState = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> _key = new GlobalKey();
  TextEditingController alimAdetController = TextEditingController();

  _TeklifDetayPageState(this.teklifId);

  static Future<Teklif> getTeklifDetay(BuildContext context, teklifId) async {
    String url = '/api/alimDetay/' + teklifId;
    var data = await NetworkUtils().get(context, url);
    return Teklif.fromJson(data);
  }

  @override
  void initState() {
    super.initState();
    _futureData = getTeklifDetay(context, teklifId);
  }

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
            title: new Text("Alım İsteği"),
            content: new Text("Bu alımı yapmak istediğinizden eminmisiniz"),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new FlatButton(
                child: new Text("İptal"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              new FlatButton(
                child: new Text("Alımı yap"),
                onPressed: () {
                  setState(() {
                    _saving = true;
                  });

                  alimYap();

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

  void alimYap() async {
    var responseJson = await NetworkUtils().post(context, '/api/alimYap',
        body: {'alim_adet': alimAdetController.text, 'teklif_id': teklifId});

    if (responseJson == null) {
      Flushbar(
        title:  "Hata",
        message:  "Bir sunucu hatası ile karşılaşıldı",
        icon: new Icon(Icons.error_outline, color: Colors.red),
        duration:  Duration(seconds: 3),              
      )..show(context);
    } else if (responseJson == 'NetworkError') {
      Flushbar(
        title:  "Hata",
        message:  "Bir bağlantı hatası ile karşılaşıldı",
        icon: new Icon(Icons.error_outline, color: Colors.red),
        duration:  Duration(seconds: 3),              
      )..show(context);
    } else if (!responseJson['success']) {
      Navigator.of(context, rootNavigator: true).pop('dialog');
      Flushbar(
        title:  "Hata",
        message:  responseJson['message'],
        icon: new Icon(Icons.error_outline, color: Colors.red),
        duration:  Duration(seconds: 3),              
      )..show(context);
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DashboardPage(alimBasarili: true),
        ),
      );
    }
  }

  String validateAlimAdet(String value) {
    if (value.length == 0) {
      return "Alım adedi boş olamaz";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldState,
        body: ModalProgressHUD(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
              },
              child: FutureBuilder<Teklif>(
                  future: _futureData,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {

                      List<Alimlar> alimlar = snapshot.data.alimlar;
                      return DefaultTabController(
                        length: 2,
                        child: NestedScrollView(
                            headerSliverBuilder: (BuildContext context,
                                bool innerBoxIsScrolled) {
                              return <Widget>[
                                SliverAppBar(
                                  expandedHeight: 200.0,
                                  floating: false,
                                  pinned: true,
                                  flexibleSpace: Container(
                                    child: Stack(
                                      children: <Widget>[
                                        Container(
                                          height: 320,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Image(
                                            image: NetworkImageWithRetry(
                                              "https://app.eczakazanc.com" +
                                                  snapshot
                                                      .data.urun.resim,
                                            ),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        Container(
                                          decoration: new BoxDecoration(
                                            gradient: new LinearGradient(
                                              colors: [
                                                Colors.black,
                                                Colors.transparent
                                                    .withOpacity(0.0)
                                              ],
                                              begin: new FractionalOffset(
                                                  0.8, 1.0),
                                              end: new FractionalOffset(
                                                  0.8, 0.0),
                                              stops: [0.0, 1.0],
                                              tileMode: TileMode.clamp,
                                            ),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Expanded(
                                                flex: 1,
                                                child: Container(),
                                              ),
                                              Container(
                                                child: Text(
                                                  snapshot.data.urun.ad,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12.0,
                                                  ),
                                                ),
                                              ),
                                              (snapshot.data
                                                          .eczaneAd !=
                                                      null)
                                                  ? Container(
                                                      child: Text(
                                                        snapshot.data
                                                            .eczaneAd,
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          color: Colors.orange,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 10.0,
                                                        ),
                                                      ),
                                                    )
                                                  : Container(),
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    bottom: 1.0),
                                                child: RichText(
                                                  text: TextSpan(
                                                    children: <TextSpan>[
                                                      (snapshot.data
                                                                  .depoFiyati !=
                                                              null)
                                                          ? TextSpan(
                                                              text: snapshot
                                                                      .data
                                                                      .depoFiyati
                                                                      .toString() +
                                                                  "TL",
                                                              style: TextStyle(
                                                                color:
                                                                    Colors.grey,
                                                                decoration:
                                                                    TextDecoration
                                                                        .lineThrough,
                                                              ),
                                                            )
                                                          : TextSpan(),
                                                      TextSpan(
                                                        text: " " +
                                                            snapshot.data
                                                                .netFiyat
                                                                .toString() +
                                                            "TL",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Container(),
                                            ],
                                          ),
                                        ),
                                        Container(),
                                      ],
                                    ),
                                  ),
                                ),
                              ];
                            },
                            body: ListView(
                              padding: const EdgeInsets.all(5.0),
                              children: <Widget>[
                                Center(
                                    child: Text(snapshot
                                        .data.aciklama)),
                                (snapshot.data.sktarihi != '') ? ListTile(
                                  title: Text("Miad"),
                                  trailing: Chip(
                                    backgroundColor: Colors.teal,
                                    label: Text(snapshot.data
                                        .sktarihi),
                                  ),
                                  dense: true,
                                ) : ListTile(
                                  title: Text("Miad"),
                                  trailing: Chip(
                                    backgroundColor: Colors.teal,
                                    label: Text('Bilgi Yok'),
                                  ),
                                  dense: true,
                                ),
                                
                                ListTile(
                                  title: Text("Min Alım"),
                                  trailing: Chip(
                                    backgroundColor: Colors.green,
                                    label: Text(snapshot
                                        .data.minAlim
                                        .toString()),
                                  ),
                                  dense: true,
                                ),
                                ListTile(
                                  title: Text("Max Alım"),
                                  trailing: Chip(
                                    backgroundColor: Colors.cyan,
                                    label: Text(snapshot
                                        .data.maxAlim
                                        .toString()),
                                  ),
                                  dense: true,
                                ),
                                ListTile(
                                  title: Text("Hedeflenen"),
                                  trailing: Chip(
                                    backgroundColor: Colors.amber,
                                    label: Text(snapshot
                                        .data.hedefAlim
                                        .toString()),
                                  ),
                                  dense: true,
                                ),
                                ListTile(
                                  title: Text("Kalan"),
                                  trailing: Chip(
                                    backgroundColor: Colors.blue,
                                    label: Text((snapshot.data
                                                .kalan)
                                        .toString()),
                                  ),
                                  dense: true,
                                ),
                                ListTile(
                                  title: Text("Teklif Şartı"),
                                  trailing: Chip(
                                    backgroundColor: Colors.blue,
                                    label: Text((snapshot.data
                                                .mf)
                                        .toString()),
                                  ),
                                  dense: true,
                                ),
                                Padding(
                                  padding: EdgeInsets.all(5.0),
                                  child: Form(
                                    key: _key,
                                    autovalidate: _validate,
                                    child: TextFormField(
                                      controller: alimAdetController,
                                      validator: validateAlimAdet,
                                      keyboardType: TextInputType.number,
                                      style: TextStyle(
                                          fontFamily: UIData.ralewayFont,
                                          color: Colors.black),
                                      decoration: InputDecoration(
                                          labelText: "Alım Adedi Giriniz",
                                          labelStyle: TextStyle(
                                              fontWeight: FontWeight.bold),
                                          border: OutlineInputBorder()),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(5.0),
                                  child: RaisedButton(
                                    onPressed: _sendToServer,
                                    textColor: Colors.white,
                                    color: Colors.red,
                                    child: const Text('Alım yap',
                                        style: TextStyle(fontSize: 14)),
                                  ),
                                ),
                                Center(
                                    child: Text("ALIMLAR",
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold))),
                                Card(
                                  clipBehavior: Clip.antiAlias,
                                  elevation: 0.0,
                                  color: Colors.grey.shade300,
                                  child: Table(
                                      border: TableBorder.all(
                                          width: 1.0, color: Colors.black),
                                      children: createTeklifAlimlarItem(
                                          context, alimlar)),
                                )
                              ],
                            )),
                      );
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  }),
            ),
            inAsyncCall: _saving,
            color: Colors.black));
  }
}


List<TableRow> createTeklifAlimlarItem(
    BuildContext context, List<Alimlar> alimlar) {
  List<TableRow> listElementWidgetList = new List<TableRow>();
  if (alimlar != null) {
    var headingRow = TableRow(children: [
      TableCell(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            new Center(child: Text("Eczane")),
            new Center(child: Text("Alım Adet")),
          ],
        ),
      )
    ]);
    listElementWidgetList.add(headingRow);
    var lengthOfList = alimlar.length;
    for (int i = 0; i < lengthOfList; i++) {
      var listItem = TableRow(children: [
          TableCell(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                new Center(child: Text(alimlar[i].eczaneAd)),
                new Center(child: Text(alimlar[i].adet.toString()))
              ],
            ),
          )
        ]);
        listElementWidgetList.add(listItem);
    }
  }
  return listElementWidgetList;
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}