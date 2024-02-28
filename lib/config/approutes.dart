import 'package:vnitproject/pages/connecttodevice.dart';
import 'package:vnitproject/pages/generatereport.dart';
import 'package:vnitproject/pages/graphs.dart';
import 'package:vnitproject/pages/homepage.dart';
import 'package:vnitproject/pages/scan_screen.dart';
import 'package:vnitproject/pages/splashscreen.dart';

class AppRoutes {
  static final pages = {
    '/': (context) => splashscreenfinal(),
    '/connecttodevice': (context) => BluetoothScreen(),
    '/generatereport': (context) => Report(),
    '/graphs': (context) => ChartScreen(),
    'scanscreen': (context) => ScanScreen(),
  };
  //
  // static const login = '/';
  // static const home = '/home';
  // static const main = '/main';
  // static const editProfile = '/edit_profile';
  // static const nearby = '/nearby';
  // static const user = '/user';
}
