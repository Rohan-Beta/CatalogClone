// ignore_for_file: file_names

import 'package:catalog_clone/screen/catallogs.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class CatalogDetail extends StatelessWidget {
  final MyItem catalog;
  static Color creamColor = const Color(0xfff5f5f5);

  // ignore: prefer_const_constructors_in_immutables
  CatalogDetail({super.key, required this.catalog});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          catalog.name,
          style: TextStyle(
              fontStyle: FontStyle.italic,
              fontSize: 20,
              color: context.theme.hintColor),
        ),
      ),
      body: SafeArea(
        // bottom: false,
        child: Column(
          children: [
            const HeightBox(20),
            Hero(
              tag: Key(catalog.id.toString()),
              child: Image.network(catalog.image).centered(),
            ).h32(context),
            Expanded(
              child: VxArc(
                height: 30.0,
                arcType: VxArcType.convey,
                child: VxArc(
                  height: 30.0,
                  arcType: VxArcType.convey,
                  edge: VxEdge.top,
                  child: Container(
                    color: Colors.black,
                    width: context.screenWidth,
                    child: Column(
                      children: [
                        catalog.name.text.color(creamColor).xl4.bold.make(),
                        10.heightBox,
                        catalog.desc.text
                            .color(Colors.white54)
                            .textStyle(context.captionStyle)
                            .xl
                            .make(),
                        10.heightBox,

                        // bottom
                        const HeightBox(50),

                        ButtonBar(
                          alignment: MainAxisAlignment.spaceBetween,
                          buttonPadding: EdgeInsets.zero,
                          children: [
                            "\$${catalog.price}"
                                .text
                                .color(creamColor)
                                .semiBold
                                .xl2
                                .make(),
                            ElevatedButton(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Buying is not supported"),
                                  ),
                                );
                              },
                              // ignore: sort_child_properties_last
                              child: "Buy".text.xl.make(),

                              // style of buy button

                              style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                  const StadiumBorder(),
                                ),
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.blue[400]),
                              ),
                            ).wh(100, 50)
                          ],
                        ).p32(),
                      ],
                    ).py64(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
