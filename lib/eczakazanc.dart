import 'package:eczakazanc/ui/page/about/about_page.dart';
import 'package:eczakazanc/ui/page/dashboard_page.dart';
import 'package:eczakazanc/ui/page/login/login_page.dart';
import 'package:eczakazanc/ui/page/notfound/notfound_page.dart';
import 'package:eczakazanc/ui/page/onboard/onboard_page.dart';
import 'package:eczakazanc/ui/page/ortakalim/teklifler_page.dart';
import 'package:eczakazanc/ui/page/settings/settings_page.dart';
import 'package:eczakazanc/utils/auth_utils.dart';
import 'package:eczakazanc/utils/network_utils.dart';
import 'package:eczakazanc/utils/uidata.dart';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EczaKazanc extends StatefulWidget {
  @override
  EczaKazancState createState() => new EczaKazancState();
}

class EczaKazancState extends State<EczaKazanc> {
  static GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  void setDevice() async {
    var status = await OneSignal.shared.getPermissionSubscriptionState();
    var playerId = "";
    if (status.subscriptionStatus.subscribed) {
      playerId = status.subscriptionStatus.userId;
    }
    await NetworkUtils().post(context, "/api/registerUserDevice", body:{
      "player_id": playerId
    });

    print("############################## registerUserDevice");
  }

  Future<void> initPlatformState() async {
    if (!mounted) return;

    OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.warn);

    OneSignal.shared.setRequiresUserPrivacyConsent(false);

    var settings = {
      OSiOSSettings.autoPrompt: false,
      OSiOSSettings.promptBeforeOpeningPushUrl: true
    };

    OneSignal.shared
        .setSubscriptionObserver((OSSubscriptionStateChanges changes) {
      print("SUBSCRIPTION STATE CHANGED: ${changes.jsonRepresentation()}");
      if (changes.to.subscribed) {
        isLoggedIn().then((success) {
          if (success) {
            setDevice();
          }
        });
      }
    });

    OneSignal.shared.setPermissionObserver((OSPermissionStateChanges changes) {
      print("PERMISSION STATE CHANGED: ${changes.jsonRepresentation()}");
    });

    await OneSignal.shared
        .init("1d7e8254-33f5-4e5f-935c-2b60d2c9fe0c", iOSSettings: settings);

    OneSignal.shared
        .setInFocusDisplayType(OSNotificationDisplayType.notification);
  }



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EczaKazanç',
      navigatorKey: navigatorKey,
      theme:
          ThemeData(
            primaryColor: Colors.blue[600], 
            primarySwatch: Colors.blue,
            textTheme: Theme.of(context).textTheme.apply(
              fontFamily: 'Open Sans'
            )
          ),
      debugShowCheckedModeBanner: false,
      showPerformanceOverlay: false,
      home: OnboardingMainPage(),

      routes: <String, WidgetBuilder>{
        UIData.onboardRoute: (BuildContext context) => OnboardingMainPage(),
        UIData.loginRoute: (BuildContext context) => LoginPage(),
        UIData.dashboardRoute: (BuildContext context) => DashboardPage(),
        UIData.settingsRoute: (BuildContext context) => SettingsPage(),
        UIData.productsRoute: (BuildContext context) => TekliflerPage(),
        UIData.aboutRoute: (BuildContext context) => AboutPage(),
      },
      onUnknownRoute: (RouteSettings rs) => new MaterialPageRoute(
          builder: (context) => new NotFoundPage(
                appTitle: 'Çok Yakında',
                icon: FontAwesomeIcons.solidSmile,
                title: 'Geliştirme aşamasında',
                message: "Çok Yakında Hizmetinizde",
                iconColor: Colors.blue,
              )));
  }
}
