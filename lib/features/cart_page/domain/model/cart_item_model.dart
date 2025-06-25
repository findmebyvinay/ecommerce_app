class CartItemModel {
  final String id;
  final String title;
  final String thumbnail;
  final double price;
  final String? category;
  final int quantity;

  CartItemModel({
    required this.id,
    required this.title ,
    required this.thumbnail,
    required this.price,
    this.category,
    required this.quantity
  });

    CartItemModel copyWith({
    String? id,
    String? title,
    String? thumbnail,
    double? price,
    String? category,
    int? quantity,
  }) {
    return CartItemModel(
      id: id ?? this.id,
      title: title ?? this.title,
      thumbnail: thumbnail ?? this.thumbnail,
      price: price ?? this.price,
      category: category ?? this.category,
      quantity: quantity ?? this.quantity,
    );
  }
  double get totalPrice=> price* quantity;




}