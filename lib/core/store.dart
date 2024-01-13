import 'package:catalog_clone/screen/carts.dart';
import 'package:catalog_clone/screen/catallogs.dart';
import 'package:velocity_x/velocity_x.dart';

class MyStore extends VxStore {
  late Catallogs catallog;
  late MyCart cart;

  MyStore() {
    catallog = Catallogs();
    cart = MyCart();
    cart.Catallog = catallog;
  }
}
