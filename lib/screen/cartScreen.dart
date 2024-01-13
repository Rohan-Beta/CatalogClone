// ignore_for_file: file_names

import 'package:catalog_clone/core/store.dart';
import 'package:catalog_clone/screen/carts.dart';
// ignore: unused_import
import 'package:catalog_clone/screen/catallogs.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class CartScreen extends StatelessWidget {
  static Color creamColor = const Color(0xfff5f5f5);
  static Color darkBluish = const Color(0xff403b58);

  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.canvasColor,
      appBar: AppBar(
        title: Text(
          "Cart",
          style: TextStyle(color: context.theme.hintColor, fontSize: 20),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Column(children: [
        CartListState().p32().expand(),
        // const Divider(),
        cartTotal(),
      ]),
    );
  }
}

// ignore: camel_case_types
class cartTotal extends StatelessWidget {
  cartTotal({super.key});

  final MyCart cart = (VxState.store as MyStore).cart;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          VxConsumer(
            notifications: const {},
            mutations: const {RemoveMutation},
            builder: (context, _, child) {
              return "\$${cart.totalPrice}"
                  .text
                  .xl3
                  .color(context.theme.hintColor)
                  .make();
            },
          ),
          30.widthBox,
          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Buying not supported yet"),
                ),
              );
            },
            // ignore: sort_child_properties_last
            child: "Buy".text.xl.make(),
            style: ButtonStyle(
              shape: MaterialStateProperty.all(
                const StadiumBorder(),
              ),
              backgroundColor: MaterialStateProperty.all(Colors.blue),
            ),
          ).wh(100, 50),
        ],
      ),
    );
  }
}

class CartListState extends StatelessWidget {
  CartListState({super.key});

  final MyCart cart = (VxState.store as MyStore).cart;

  @override
  Widget build(BuildContext context) {
    VxState.watch(context, on: [RemoveMutation]);
    return cart.items.isEmpty
        ? "Nothing is in the cart"
            .text
            .color(context.theme.hintColor)
            .xl3
            .make()
            .centered()
        : ListView.builder(
            itemCount: cart.items.length,
            itemBuilder: (context, index) => ListTile(
              leading: const Icon(Icons.done),
              trailing: IconButton(
                icon: const Icon(Icons.remove_circle_outline),
                onPressed: () {
                  RemoveMutation(cart.items[index]);
                },
              ),
              title: cart.items[index].name.text.make(),
            ),
          );
  }
}
