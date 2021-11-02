class Order {
  final int id;
  final int item;
  final double price;


  Order({
    required this.id,
    required this.item,
    required this.price,
  });
}

// Our demo Orders

List<Order> demoOrders = [

  Order(
    id: 2,
    price: 50.5,
    item: 3,

  ),
  Order(
    id: 3,
    price: 36.55,
    item: 4,

  ),

];
