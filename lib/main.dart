import 'package:catalog_clone/core/store.dart';
import 'package:catalog_clone/screen/cartScreen.dart';
// ignore: unused_import
import 'package:catalog_clone/screen/catallogs.dart';
// ignore: unused_import
import 'package:catalog_clone/screen/catalogDetail.dart';
import 'package:catalog_clone/screen/catalogScreen.dart';
import 'package:catalog_clone/screen/routes.dart';
import 'package:catalog_clone/screen/sign_in.dart';
import 'package:catalog_clone/screen/splash.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart'; // for velocity_x UI
import 'package:url_strategy/url_strategy.dart';

void main() {
  setPathUrlStrategy(); // to remove # from url
  runApp(VxState(store: MyStore(), child: const CatalogClone()));
}

class CatalogClone extends StatelessWidget {
  static Color darkCreamColor = Vx.gray800;
  static Color creamColor = const Color(0xfff5f5f5);
  static Color darkBluish = const Color(0xff403b58);

  const CatalogClone({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Catalog_Clone",
      debugShowCheckedModeBanner: false,
      home: const MySplash(),
      themeMode: ThemeMode.system,
      darkTheme: ThemeData(
        // for dark theme

        brightness: Brightness.dark,
        cardColor: Colors.black45,
        canvasColor: darkCreamColor,
        hintColor: Colors.white54,
        appBarTheme: const AppBarTheme(
          elevation: 0.0,
          iconTheme: IconThemeData(color: Colors.black),
          titleTextStyle: TextStyle(color: Colors.black),
          centerTitle: true,
        ),
      ),
      theme: ThemeData(
        // for light theme

        cardColor: Colors.white,
        canvasColor: creamColor,
        hintColor: darkBluish,
        appBarTheme: const AppBarTheme(
          color: Colors.white,
          elevation: 0.0,
          iconTheme: IconThemeData(color: Colors.black),
          titleTextStyle: TextStyle(color: Colors.black),
          centerTitle: true,
        ),
      ),
      initialRoute: MyRoutes.splashRoute,
      routes: {
        MyRoutes.loginRoute: (context) => const SignIn(),
        MyRoutes.catalogRoute: (context) => const CatalogScreen(),
        // MyRoutes.catalogDetailRoute: (context) =>
        //     CatalogDetail(catalog: ),
        MyRoutes.cartRoute: (context) => const CartScreen(),
      },
    );
  }
}
