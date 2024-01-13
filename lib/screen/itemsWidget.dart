// ignore_for_file: file_names

import 'package:catalog_clone/screen/catallogs.dart';
import 'package:flutter/material.dart';

class ItemsWidget extends StatelessWidget {
  final MyItem item; //catallogs.dart

  const ItemsWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      // shape: const StadiumBorder(),
      // elevation: 0.0, // shape the card
      child: ListTile(
        onTap: () {
          // print("${item.name} pressed");
        },
        leading: Image.network(item.image),
        title: Text(item.name),
        subtitle: Text(item.desc),
        trailing: Text(
          "\$${item.price}",
          textScaleFactor: 1.5,
          style:
              TextStyle(color: Colors.blue[400], fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
