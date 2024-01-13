// ignore_for_file: file_names

import 'dart:convert';
import 'package:catalog_clone/core/store.dart';
import 'package:catalog_clone/screen/carts.dart';
import 'package:catalog_clone/screen/catallogs.dart';
import 'package:catalog_clone/screen/catalogDetail.dart';
import 'package:catalog_clone/screen/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// ignore: unnecessary_import
import 'package:flutter/services.dart';
import 'package:velocity_x/velocity_x.dart'; // velocity_x UI
// ignore: unused_import
import 'package:http/http.dart' as http; // for http to API

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key});

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  static Color darkBluish = const Color(0xff403b58);

  final url = "https://api.jsonbin.io/b/604dbddb683e7e079c4eefd3";

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    // for local data

    // await Future.delayed(Duration(seconds: 1));
    final catalogjson =
        await rootBundle.loadString("assests/myData/catalog.json");

    // for online data

    // final response = await http.get(Uri.parse(url));
    // final catalogjson = response.body;

    // print(catalogjson); // check the .json file

    final decodeData = jsonDecode(catalogjson);
    var productData = decodeData["products"];

    // print(productData);

    // get info of fromMap constructor in MyItem class
    Catallogs.items = List.from(productData)
        .map<MyItem>((item) => MyItem.fromMap(item))
        .toList();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final cart = (VxState.store as MyStore).cart;
    return Scaffold(
      backgroundColor: context.canvasColor, //canvascolor taken from main.dart
      floatingActionButton: VxBuilder(
        mutations: const {AddMutation, RemoveMutation},
        builder: (context, _, child) => FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, MyRoutes.cartRoute);
          },
          child: const Icon(CupertinoIcons.cart), // for cart purpose
        ).badge(
            color: context.theme.canvasColor,
            size: 20,
            textStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: context.theme.hintColor,
            ),
            count: cart.items.length),
      ),
      body: SafeArea(
        child: Container(
          padding: Vx.m32,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppHeader(),
              if (Catallogs.items.isNotEmpty)
                const CatalogList().py16().expand()
              else
                CircularProgressIndicator(
                  color: darkBluish,
                ).centered().expand(),
            ],
          ),
        ),
      ),
    );
  }
}

// create a class for header

class AppHeader extends StatelessWidget {
  static Color creamColor = const Color(0xfff5f5f5);
  static Color darkBluish = const Color(0xff403b58);

  const AppHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        "Catalog App"
            .text
            .xl5
            .bold
            .color(context.theme.hintColor) // hintColor form main.dart
            .make(), // velocity_x
        "Treding Products".text.xl2.color(context.theme.hintColor).make(),
      ],
    );
  }
}

class CatalogList extends StatelessWidget {
  const CatalogList({super.key});

  @override
  Widget build(BuildContext context) {
    // for web

    return !context.isMobile
        ? GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            shrinkWrap: true,
            itemCount: Catallogs.items.length,
            itemBuilder: (context, index) {
              final catalog = Catallogs.items[index];

              return InkWell(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CatalogDetail(catalog: catalog),
                  ),
                ),
                child: CatalogItem(
                  catalog: catalog,
                ),
              );
            },
          )
        // for mobile

        : ListView.builder(
            shrinkWrap: true,
            itemCount: Catallogs.items.length,
            itemBuilder: (context, index) {
              final catalog = Catallogs.items[index];

              return InkWell(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CatalogDetail(catalog: catalog),
                  ),
                ),
                child: CatalogItem(
                  catalog: catalog,
                ),
              );
            },
          );
  }
}

class CatalogItem extends StatelessWidget {
  static Color creamColor = const Color(0xfff5f5f5);
  static Color darkBluish = const Color(0xff403b58);

  final MyItem catalog;

  const CatalogItem({super.key, required this.catalog});

  @override
  Widget build(BuildContext context) {
    // extract with local variable

    var children2 = [
      // image part

      Hero(
        tag: Key(catalog.id.toString()),
        child: Image.network(catalog.image)
            .box
            .rounded
            .p8
            .color(context.theme.canvasColor)
            .make()
            .p16()
            .wPCT(context: context, widthPCT: context.isMobile ? 40 : 20),
      ),
      // text part

      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            catalog.name.text.bold.xl.color(context.theme.hintColor).make(),
            catalog.desc.text
                .textStyle(context.captionStyle)
                .semiBold
                .color(context.theme.hintColor)
                .make(),

            10.heightBox,

            // button part

            ButtonBar(
              alignment: MainAxisAlignment.spaceBetween,
              buttonPadding: EdgeInsets.zero,
              children: [
                "\$${catalog.price}"
                    .text
                    .color(context.theme.hintColor)
                    .semiBold
                    .make(),

                // extract widget

                AddToCart(catalog: catalog)
              ],
            ).pOnly(right: 8),
          ],
        ).p(context.isMobile ? 0 : 16),
      ),
    ];
    return VxBox(
      child: context.isMobile
          ? Row(
              children: children2,
            )
          : Column(children: children2),
    )
        .color(context.cardColor)
        .rounded
        .square(140)
        .make()
        .py16(); // py16 for padding Vx box
  }
}

class AddToCart extends StatelessWidget {
  final MyItem catalog;

  const AddToCart({
    super.key,
    required this.catalog,
  });

  @override
  Widget build(BuildContext context) {
    VxState.watch(context, on: [AddMutation, RemoveMutation]);

    // ignore: no_leading_underscores_for_local_identifiers
    final MyCart _cart = (VxState.store as MyStore).cart;

    bool isAdded = _cart.items.contains(catalog) ?? false;

    return ElevatedButton(
      onPressed: () {
        // if (!isAdded) {
        //   AddMutation(catalog);
        // }
        AddMutation(catalog);
      },
      // ignore: sort_child_properties_last
      child: isAdded ? const Icon(Icons.done) : "Add to cart".text.make(),

      // style of buy button

      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          const StadiumBorder(),
        ),
        backgroundColor: MaterialStateProperty.all(Colors.blue),
      ),
    );
  }
}
