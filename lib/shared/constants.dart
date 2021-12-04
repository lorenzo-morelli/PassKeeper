import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Constants {
  static const double cornRad = 30;
  static Color? lightGrey = Colors.grey[100];
  static bool withGoogle = false;
  static bool loading = false;

  static InputDecoration textInputDecoration = InputDecoration(
    hintText: 'site',
    fillColor: Colors.white,
    filled: true,
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red, width: 2),
      borderRadius: BorderRadius.all(Radius.circular(Constants.cornRad)),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red, width: 2),
      borderRadius: BorderRadius.all(Radius.circular(Constants.cornRad)),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white, width: 2),
      borderRadius: BorderRadius.all(Radius.circular(Constants.cornRad)),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.black87, width: 2),
      borderRadius: BorderRadius.all(Radius.circular(Constants.cornRad)),
    ),
    contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 25),
    suffixIcon: null,
    );

  static List<Color> colors = [
    Color(0xffc0c0c0), // grey
    Color(0xffe52b50), // red
    Color(0xfff28500), // orange
    Color(0xffffd500), // yellow
    Color(0xff87cc87), // light green
    Color(0xff40826d), // green
    Color(0xff4a6e8c), // blue
    Color(0xff9370db), // purple
  ];

  static List<String> sites = [
    'facebook',
    'instagram',
    'tiktok',
    'youtube',
    'steam',
    'mail',
    'spotify'
    'paypal',
    'google',
    'telegram',
    'github',
    'whatsapp',
    'microsoft',
    'reddit',
    'pinterest',
    'amazon',
    'airbnb',
    'chrome',
    'ebay',
    'linkedin',
    'playstation',
    'skype',
    'snapchat',
    'soundcloud',
    'tumblr',
    'twitter',
  ];

  static List<FaIcon> icons = [
    FaIcon(FontAwesomeIcons.facebookF, color: Colors.white),
    FaIcon(FontAwesomeIcons.instagram, color: Colors.white),
    FaIcon(FontAwesomeIcons.tiktok, color: Colors.white),
    FaIcon(FontAwesomeIcons.youtube, color: Colors.white),
    FaIcon(FontAwesomeIcons.steamSymbol, color: Colors.white),
    FaIcon(FontAwesomeIcons.envelope, color: Colors.white),
    FaIcon(FontAwesomeIcons.spotify, color: Colors.white),
    FaIcon(FontAwesomeIcons.paypal, color: Colors.white),
    FaIcon(FontAwesomeIcons.google, color: Colors.white),
    FaIcon(FontAwesomeIcons.telegramPlane, color: Colors.white),
    FaIcon(FontAwesomeIcons.amazon, color: Colors.white),
    FaIcon(FontAwesomeIcons.github, color: Colors.white),
    FaIcon(FontAwesomeIcons.whatsapp, color: Colors.white),
    FaIcon(FontAwesomeIcons.microsoft, color: Colors.white),
    FaIcon(FontAwesomeIcons.reddit, color: Colors.white),
    FaIcon(FontAwesomeIcons.pinterestP, color: Colors.white),
    FaIcon(FontAwesomeIcons.amazon, color: Colors.white),
    FaIcon(FontAwesomeIcons.airbnb, color: Colors.white),
    FaIcon(FontAwesomeIcons.chrome, color: Colors.white),
    FaIcon(FontAwesomeIcons.ebay, color: Colors.white),
    FaIcon(FontAwesomeIcons.linkedinIn, color: Colors.white),
    FaIcon(FontAwesomeIcons.playstation, color: Colors.white),
    FaIcon(FontAwesomeIcons.skype, color: Colors.white),
    FaIcon(FontAwesomeIcons.snapchatGhost, color: Colors.white),
    FaIcon(FontAwesomeIcons.soundcloud, color: Colors.white),
    FaIcon(FontAwesomeIcons.tumblr, color: Colors.white),
    FaIcon(FontAwesomeIcons.twitter, color: Colors.white),
  ];

  static ThemeData theme = ThemeData(
    fontFamily: 'GentiumBook',
    highlightColor: Colors.white,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.black87,
    ),
  );

  //TODO: colori temi... rosino sul psd, bianchino..., usare solo costanti!
  static Color defaultColor = Colors.black26;

}
