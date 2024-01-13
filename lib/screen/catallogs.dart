class Catallogs {
  static List<MyItem> items = [
    // MyItem(
    //   id: 1,
    //   name: "iphone 12 pro",
    //   desc: "iphone 12th version",
    //   price: 1000,
    //   color: "#33505a",
    //   image:
    //       "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT5dUM8vQroUs9EW5GcxGxPJfXLprHX-ryDY_eIcJTsMelfvMeRBN4dMra0ywEEUPnLmMk&usqp=CAU",
    // )
  ];

  // get item by id
  MyItem getByID(int id) =>
      // ignore: null_closures
      items.firstWhere((element) => element.id == id, orElse: null);

  // get item by position
  MyItem getByPosition(int pos) => items[pos];
}

class MyItem {
  final int id;
  final String name;
  final String desc;
  final num price;
  final String color;
  final String image;

// create constructor for final fields

  MyItem(
      {required this.id,
      required this.name,
      required this.desc,
      required this.price,
      required this.color,
      required this.image});

  factory MyItem.fromMap(Map<String, dynamic> map) {
    return MyItem(
      // get keys from .json file
      id: map["id"],
      name: map["name"],
      desc: map["desc"],
      price: map["price"],
      color: map["color"],
      image: map["image"],
    );
  }
  toMap() => {
        "id": id,
        "name": name,
        "desc": desc,
        "price": price,
        "color": color,
        "image": image,
      };
}
