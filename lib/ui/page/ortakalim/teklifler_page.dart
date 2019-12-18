//import 'package:eczakazanc/ui/page/ortakalim/teklifdetay_page.dart';
import 'package:eczakazanc/ui/page/ortakalim/teklifdetay_page.dart';
import 'package:eczakazanc/ui/widgets/shadowShopCard.dart';
import 'package:eczakazanc/utils/cache_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_image/network.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:modal_progress_hud/modal_progress_hud.dart';

class TekliflerPage extends StatefulWidget {
  TekliflerPage({Key key}) : super(key: key);

  _TekliflerPageState createState() => _TekliflerPageState();
}

class _TekliflerPageState extends State<TekliflerPage> {
  String nextPage = "https://app.eczakazanc.com/api/tumTeklifler/";
  

  ScrollController _scrollController = new ScrollController();

  bool isLoading = false;

  int currentPage = 1;
  int endPage = 1;
  String currentList = "Tüm Teklifler";

 
  List names = new List();

  void _getMoreData(String newNextPage) async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
      
      Map<String, String> headers = {"Content-Type": "application/json", "Accept": "application/json"};
      

      await getCache('jwt-token').then((result) {
          headers['Authorization'] = 'Bearer ' + result;
      });
      
      if(newNextPage == "") {

      } else {
        nextPage = newNextPage;
      }
      final response = await http.get(nextPage, headers: headers);
      // Use the compute function to run parsePhotos in a separate isolate
      print("#######################################");
      print(response.body);
      final parsed = json.decode(response.body);
      
      List tempList = new List();
      
      nextPage = parsed['next_page_url'];
      endPage = parsed['last_page'];
      currentPage = parsed['current_page'];
      for (int i = 0; i < parsed['data'].length; i++) {
        tempList.add(parsed['data'][i]);
      }
 
      setState(() {
        isLoading = false;
        names.addAll(tempList);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    this._getMoreData("");
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
            if(endPage == currentPage) {
              setState(() {
                isLoading = false;
              });
            } else {
              _getMoreData("");
            }
      }
    });
  }
 
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Widget buildUi() =>  CustomScrollView(
      controller: _scrollController,
      slivers: <Widget>[
        SliverAppBar(
          elevation: 2.0,
          title: Text("Ortak Alım Teklifleri"),
          forceElevated: true,
          pinned: true,
          floating: true,
          bottom: bottomBar(),
        ),
        SliverPadding(
            padding: const EdgeInsets.all(3.0),
            sliver: new SliverGrid.count(
              crossAxisCount: 2,
              childAspectRatio: 0.75,
              mainAxisSpacing: 1.0,
              crossAxisSpacing: 1.0,
              children: createTeklifCardItem(),
            ),
        ),
      ],
    );
  
  Widget bottomBar() => PreferredSize(
      preferredSize: Size(double.infinity, 50.0),
      child: new GestureDetector(
          onTap: () {
            _settingModalBottomSheet(context);
          },
          child: Container(
              color: Colors.black,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 50.0,
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        currentList,
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w700),
                      ),
                      Icon(Icons.arrow_drop_down)
                    ],
                  ),
                ),
              ))));

  List<Widget> createTeklifCardItem() {
    // Children list for the list.
    List<Widget> listElementWidgetList = new List<Widget>();
    if (names != null) {
      var lengthOfList = names.length;
      for (int i = 0; i < lengthOfList; i++) {
        // Image URL
        var imageURL = "https://app.eczakazanc.com"+names[i]['urun']['resim'];
        // List item created with an image of the poster
        var listItem = new ShadowShopCard(
          onTap: (){
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TeklifDetayPage(teklifId: names[i]['id'].toString()),
              ),
            );
          },
          image: NetworkImageWithRetry(imageURL),
          height: 330.0,
          itemName: names[i]['urun']['ad'],
          prePrice: names[i]['depo_fiyati'].toString(),
          price: names[i]['net_fiyat'].toString(),
          hedef: names[i]['hedef_alim'],
          talep: names[i]['yuzde'],
          eczane: names[i]['eczane_ad'],
          badge: names[i]['mf'],
          badgeBgColor: Colors.red,   
          blurColor: Colors.black,          
        );
        listElementWidgetList.add(listItem);
      }
    }
    return listElementWidgetList;
  }

  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    leading: new Icon(Icons.view_list),
                    title: new Text('Tüm Teklifler'),
                    trailing: new Icon(Icons.arrow_right),
                    onTap: () {
                      setState(() {
                        currentList = "Tüm Teklifler";
                        names = [];
                        _getMoreData("https://app.eczakazanc.com/api/tumTeklifler/");
                      });
                      Navigator.pop(context);
                    }),
                new ListTile(
                    leading: new Icon(Icons.playlist_add),
                    title: new Text('Bitmek Üzere Olanlar'),
                    trailing: new Icon(Icons.arrow_right),
                    onTap: () {
                      setState(() {
                        currentList = "Bitmek Üzere Olanlar";
                        names = [];
                        _getMoreData("https://app.eczakazanc.com/api/yeniTeklifler/");
                      });
                      Navigator.pop(context);
                    }),
                new ListTile(
                    leading: new Icon(Icons.playlist_add_check),
                    title: new Text('Bana Özel'),
                    trailing: new Icon(Icons.arrow_right),
                    onTap: () {
                      setState(() {
                        currentList = "Bana Özel";
                        names = [];
                        _getMoreData("https://app.eczakazanc.com/api/banaOzelTeklifler/");
                      });
                      Navigator.pop(context);
                    }),
                     new ListTile(
                    leading: new Icon(Icons.verified_user),
                    title: new Text('Benim Oluşturduklarım'),
                    trailing: new Icon(Icons.arrow_right),
                    onTap: () {
                      setState(() {
                        currentList = "Benim Oluşturduklarım";
                        names = [];
                        _getMoreData("https://app.eczakazanc.com/api/benimTeklifler/");
                      });
                      Navigator.pop(context);
                    }),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ModalProgressHUD(child: buildUi(), inAsyncCall: isLoading, color: Colors.black),
      ),
      resizeToAvoidBottomPadding: false,
    );
  }
}
