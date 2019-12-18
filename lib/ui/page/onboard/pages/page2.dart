import 'package:eczakazanc/utils/uidata.dart';
import 'package:flutter/material.dart';

const double IMAGE_SIZE = 200.0;

class Page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      height: double.infinity,
      width: double.infinity,
      decoration: new BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.green[900],
            Colors.green[900],
            Colors.green[900],
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
                    image: AssetImage(UIData.pose2),
                    fit: BoxFit.fitHeight,
                  ),
                  height: 170,
                  width: 300,
                ),
                new Padding(
                  padding: const EdgeInsets.only(top: 25.0, bottom: 5.0),
                  child: Text('GÜNCEL ALIM TEKLİFLERİ',
                    style: Theme.of(context).textTheme.display1.copyWith(color: Colors.white, fontSize: 22.0),
                    textAlign: TextAlign.center,
                  ),
                ),
                new Container(
                  margin: const EdgeInsets.all(15.0),
                  child: Text('Güncel kampanyası devam eden ilaçlar için size en uygun teklifi seçebilir, bu teklifin ekstra avantajlarından yararlanabilirsiniz. Aynı zamanda ihtiyacınız olan tüm ürünler için ortak alım teklifleri oluşturabilir ve ortak alım platformuna ürün ekleyebilirsiniz.',
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
