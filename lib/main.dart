import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedule/db_rr/db_rr.dart';
import 'package:schedule/pages/add/add_binding.dart';
import 'package:schedule/pages/add/add_view.dart';
import 'package:schedule/pages/all/all_binding.dart';
import 'package:schedule/pages/all/all_view.dart';
import 'package:schedule/pages/other/other_binding.dart';
import 'package:schedule/pages/other/other_view.dart';
import 'package:schedule/pages/push/push_binding.dart';
import 'package:schedule/pages/push/push_view.dart';
import 'package:schedule/pages/schedule/schedule_binding.dart';
import 'package:schedule/pages/schedule/schedule_view.dart';
import 'package:schedule/pages/tab/tab_binding.dart';
import 'package:schedule/pages/tab/tab_view.dart';

import 'db_rr/res.dart';


Color primaryColor = const Color(0xff5266ff);
Color bgColor = const Color(0xfff5f7f8);


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Get.putAsync(() => DBRR().init());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: Pages,
      initialRoute: '/',
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: primaryColor,
        scaffoldBackgroundColor: bgColor,
        colorScheme: ColorScheme.light(
          primary: primaryColor,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: primaryColor,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        cardTheme: const CardTheme(
          color: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        dialogTheme: const DialogTheme(
          actionsPadding: EdgeInsets.only(right: 10, bottom: 5),
        ),
        dividerTheme: DividerThemeData(
          thickness: 1,
          color: Colors.grey[200],
        ),
      ),
    );
  }
}
List<GetPage<dynamic>> Pages = [
  GetPage(name: '/', page: () => const PushView(),binding: PushBinding()),
  GetPage(name: '/tab', page: () => TabPage(),binding: TabBinding()),
  GetPage(name: '/push', page: () => const Res()),
  GetPage(name: '/schedule', page: () => SchedulePage(),binding: ScheduleBinding()),
  GetPage(name: '/add', page: () => AddPage(),binding: AddBinding()),
  GetPage(name: '/all', page: () => AllPage(),binding: AllBinding()),
  GetPage(name: '/other', page: () => OtherPage(),binding: OtherBinding()),
];

