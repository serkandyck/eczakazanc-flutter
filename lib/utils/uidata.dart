import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class UIData {
  //routes
  static const String dashboardRoute = "/dashboard";
  static const String loginRoute = "/login";
  static const String onboardRoute = "/onboard";
  static const String aboutRoute = "/about";
  static const String settingsRoute = "/settings";
  static const String profileSettingsRoute = "/profilesettings";
  static const String passwordSettingsRoute = "/passwordsettings";
  static const String ilacRoute = "/ilac";
  static const String productsRoute = "/products";
  static const String teklifOlustur = "/teklifolustur";
  static const String kazancOzeti = "/kazancozeti";

  static const String ortakAlimRoute = "/ortakalim";

  //strings
  static const String appName = "EczaKazanç";

  //fonts
  static const String quickFont = "Quicksand";
  static const String ralewayFont = "Raleway";
  static const String quickBoldFont = "Quicksand-Bold.ttf";
  static const String quickNormalFont = "Quicksand-Book.ttf";
  static const String quickLightFont = "Quicksand-Light.ttf";

  //images
  static const String imageDir = "assets/images";
  static const String pkImage = "$imageDir/pk.jpg";
  static const String profileImage = "$imageDir/profile.jpg";
  static const String blankImage = "$imageDir/blank.jpg";
  static const String dashboardImage = "$imageDir/dashboard.jpg";
  static const String loginImage = "$imageDir/login.jpg";
  static const String paymentImage = "$imageDir/payment.jpg";
  static const String settingsImage = "$imageDir/setting.jpeg";
  static const String shoppingImage = "$imageDir/shopping.jpeg";
  static const String timelineImage = "$imageDir/timeline.jpeg";
  static const String verifyImage = "$imageDir/verification.jpg";
  static const String eczakazancImage = "$imageDir/ic_launcher.png";
  static const String eczakazancLogo = "$imageDir/eczakazanc-logo.png";
  static const String orbikeyLogo = "$imageDir/orbikey.jpg";
  static const String pose1 = "$imageDir/pose1.png";
  static const String pose2 = "$imageDir/pose2.png";
  static const String pose3 = "$imageDir/pose3.png";
  static const String urunyok = "$imageDir/urun-yok.jpg";

  //login
  static const String enter_code_label = "Phone Number";
  static const String enter_code_hint = "10 Digit Phone Number";
  static const String enter_otp_label = "OTP";
  static const String enter_otp_hint = "4 Digit OTP";
  static const String get_otp = "Get OTP";
  static const String resend_otp = "Resend OTP";
  static const String login = "Login";
  static const String enter_valid_number = "Enter 10 digit phone number";
  static const String enter_valid_otp = "Enter 4 digit otp";

  //gneric
  static const String error = "Error";
  static const String success = "Success";
  static const String ok = "OK";
  static const String forgot_password = "Forgot Password?";
  static const String something_went_wrong = "Something went wrong";
  static const String coming_soon = "Geliştirme aşamasında";

  static const MaterialColor ui_kit_color = Colors.grey;

//colors
  static List<Color> kitGradients = [
    new Color.fromRGBO(11, 65, 130, 1.0),
    new Color.fromRGBO(30, 136, 229, 64),
    new Color.fromRGBO(64, 186, 245, 97),
    //Colors.blueGrey.shade800,
    //Colors.black87,
  ];
  static List<Color> kitGradients2 = [
    Colors.cyan.shade600,
    Colors.blue.shade900
  ];

  //randomcolor
  static final Random _random = new Random();

  /// Returns a random color.
  static Color next() {
    return new Color(0xFF000000 + _random.nextInt(0x00FFFFFF));
  }
}
