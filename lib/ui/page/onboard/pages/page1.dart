import 'package:eczakazanc/utils/uidata.dart';
import 'package:flutter/material.dart';

class Page1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      height: double.infinity,
      width: double.infinity,
      decoration: new BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.blue[900],
            Colors.blue[900],
            Colors.blue[900],
          ],
          begin: Alignment(0.5, -1.0),
          end: Alignment(0.5, 1.0)
        )
      ),
      child: Stack(
        children: <Widget>[
          new Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  child: Image(
                    image: AssetImage(UIData.pose1),
                    fit: BoxFit.fitHeight,
                  ),
                  height: 170,
                  width: 300,
                ),
                new Padding(
                  padding: const EdgeInsets.only(top: 25.0, bottom: 5.0),
                  child: Text('ORTAK ALIMLAR',
                    style: Theme.of(context).textTheme.display1.copyWith(color: Colors.white, fontSize: 22.0),
                    textAlign: TextAlign.center,
                  ),
                ),
                new Container(
                  margin: const EdgeInsets.all(15.0),
                  child:  Text('Üyeler Ortak Alımlar sayesinde bareme takılmadan en yüksek MF’den ürün alır.\nBireysel alımlarda MF’yi kaçırmamak için yapılan fazla alımlar ortadan kalkar. En yüksek MF’nin birim fiyatından alım yapılarak en düşük, net fiyattan alım sağlanır bu sayede %30’a varan karlılık oranlarına erişilir.',
                    style: Theme.of(context).textTheme.body1.copyWith(color: Colors.white),
                    textAlign: TextAlign.center,
                  )
                ),
               
              ],
            ),
          )
        ],
        alignment: FractionalOffset.center,
      ),
    );
  }
}
