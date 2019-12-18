import 'package:eczakazanc/ui/widgets/starRating.dart';
import 'package:flutter/material.dart';


class ShadowShopCard extends StatelessWidget {
  final Function onTap;
  final ImageProvider image;
  final String badge;
  final Alignment badgeAlignment;
  final String itemName;
  final String prePrice;
  final String price;
  final String eczane;
  final double height;
  final int hedef;
  final String talep;

  final Color badgeColor;
  final Color badgeBgColor;
  final Color itemNameColor;
  final Color prePriceColor;
  final Color priceColor;
  final Color blurColor;
  final Color ratingColor;

  ShadowShopCard({
    this.onTap,
    @required this.image,
    this.badge,
    this.badgeAlignment,
    this.badgeColor,
    this.itemName,
    this.prePrice,
    this.price,
    this.eczane,
    this.badgeBgColor,
    this.itemNameColor,
    this.prePriceColor,
    this.priceColor,
    this.blurColor,
    @required this.height,
    this.hedef,
    this.talep,
    this.ratingColor,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: this.onTap,
      child: Card(
        child: Container(
          child: Stack(
            children: <Widget>[
              Container(
                height: this.height,
                child: Image(
                  image: this.image,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                decoration: new BoxDecoration(
                  gradient: new LinearGradient(
                    colors: [
                      (this.blurColor != null) ? this.blurColor : Colors.black,
                      Colors.transparent.withOpacity(0.0)
                    ],
                    begin: new FractionalOffset(0.5, 1.0),
                    end: new FractionalOffset(0.5, 0.0),
                    stops: [0.0, 0.8],
                    tileMode: TileMode.clamp,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(),
                    ),
                    Container(
                      child: Text(
                        this.itemName,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                    (this.eczane != null)
                    ? Container(
                      child: Text(
                        this.eczane,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.orange,
                          fontWeight: FontWeight.bold,
                          fontSize: 10.0,
                        ),
                      ),
                    ) :
                    Container(),
                    Container(
                      margin: const EdgeInsets.only(bottom: 1.0),
                      child: RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            (this.prePrice != null)
                                ? TextSpan(
                                    text: this.prePrice + "TL",
                                    style: TextStyle(
                                      color: (this.prePriceColor != null)
                                          ? this.prePrice
                                          : Colors.grey,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  )
                                : TextSpan(),
                            TextSpan(
                              text: " " + this.price + "TL",
                              style: TextStyle(
                                  color: (this.priceColor != null)
                                      ? this.priceColor
                                      : Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                    (this.hedef != null)
                        ? Row(
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: Container(),
                              ),
                              Container(
                                margin: const EdgeInsets.only(bottom: 5.0),
                                alignment: Alignment.center,
                                child: StarRating(
                                  hedeflenen: this.hedef,
                                  talep: this.talep,
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(),
                              ),
                            ],
                          )
                        : Container(),
                  ],
                ),
              ),
              (this.badge != null)
                  ? Container(
                      alignment: (this.badgeAlignment != null)
                          ? this.badgeAlignment
                          : Alignment.topRight,
                      child: Container(
                        width: 50.0,
                        height: 20.0,
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: (this.badgeBgColor != null)
                                ? this.badgeBgColor
                                : Colors.blue),
                        alignment: Alignment.center,
                        child: Text(
                          this.badge,
                          style: TextStyle(
                              color: (this.badgeColor != null)
                                  ? this.badgeBgColor
                                  : Colors.white),
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
