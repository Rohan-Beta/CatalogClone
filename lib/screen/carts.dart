import 'package:catalog_clone/core/store.dart';
import 'package:catalog_clone/screen/catallogs.dart';
import 'package:velocity_x/velocity_x.dart';

class MyCart {
  late Catallogs _catallog;

  final List<int> _itemIds = [];

  // ignore: non_constant_identifier_names, unnecessary_getters_setters
  Catallogs get Catallog => _catallog;

  // ignore: non_constant_identifier_names
  set Catallog(Catallogs newCatalog) {
    _catallog = newCatalog;
  }

  List<MyItem> get items =>
      _itemIds.map((id) => _catallog.getByID(id)).toList();

  // get total cart item price

  num get totalPrice =>
      items.fold(0, (total, current) => total + current.price);
}

// add items
class AddMutation extends VxMutation {
  final MyItem item;

  AddMutation(this.item);

  @override
  perform() {
    (VxState.store as MyStore).cart._itemIds.add(item.id);
  }
}

// delete items
class RemoveMutation extends VxMutation {
  final MyItem item;

  RemoveMutation(this.item);

  @override
  perform() {
    (VxState.store as MyStore).cart._itemIds.remove(item.id);
  }
}
