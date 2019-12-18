import 'package:eczakazanc/ui/widgets/common_divider.dart';
import 'package:eczakazanc/ui/widgets/profile_tile.dart';
import 'package:eczakazanc/utils/uidata.dart';
import 'package:flutter/material.dart';
import 'package:eczakazanc/ui/widgets/common_scaffold.dart';

class AboutPage extends StatelessWidget {
  var deviceSize;

  //Column1
  Widget profileColumn() => Container(
        height: deviceSize.height * 0.30,
        child: FittedBox(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ProfileTile(
                  title: "EczaKazanç",
                  subtitle: "EczaKazanç bir Orbikey A.Ş iştirakidir.",
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                        ),
                        child: Image(image : AssetImage(UIData.eczakazancImage), width: 90.0),
                      ),
                    ],
                  ),
                ),
                Text("EczaKazanç © 2019 Tüm Hakları Saklıdır.",style: TextStyle(fontSize: 9.0)),
                Text("Geliştirici : Serkan Dayıcık",style: TextStyle(fontSize: 9.0)),
              ],
            ),
          ),
        ),
      );

  //column2
logoColumn() => Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Image(image: AssetImage(UIData.orbikeyLogo), width: 70.0)
        ],
      );
  //column3
  Widget descColumn() => Container(
        height: deviceSize.height * 0.08,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: 
              Text(
                "Orbikey A.Ş Olarak Sağlık teknolojileri ve medikal alanlarında gerçekleştirdiğimiz projeler ile sektörün sorunlarına çözüm üretmekteyiz.",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 10.0),
                textAlign: TextAlign.center,
                maxLines: 3,
                softWrap: true,
              ),
          ),
        ),
      );
  //column4
  Widget accountColumn() => FittedBox(
        fit: BoxFit.fill,
        child: Container(
          height: deviceSize.height * 0.3,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              FittedBox(
                child: Column(
                  children: <Widget>[
                    ProfileTile(
                      title: "Adres",
                      subtitle: "Üniversiteler Mahallesi 1596.Cadde\nHacettepe Teknokent 6c-10 Orbikey\nÇankaya/ANKARA",
                    ),
                    ProfileTile(
                      title: "Website",
                      subtitle: "eczakazanc.com",
                    ),
                    ProfileTile(
                      title: "Telefon",
                      subtitle: "+90 (530) 700 93 29",
                    ),
                    ProfileTile(
                      title: "E-posta",
                      subtitle: "info@eczakazanc.com",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  Widget bodyData() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          profileColumn(),
          CommonDivider(),
          logoColumn(),
          descColumn(),
          CommonDivider(),
          accountColumn()
        ],
      ),
    );
  }

  Widget _scaffold() => new CommonScaffold(
          appTitle: "EczaKazanç Hakkında",
          bodyData: bodyData(),
          showFAB: false,
          showDrawer: false,
          floatingIcon: Icons.person_add,
        );
  
    @override
    Widget build(BuildContext context) {
      deviceSize = MediaQuery.of(context).size;
      return _scaffold();
    }
  }
