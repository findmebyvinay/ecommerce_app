class CartItemModel {
  final String id;
  final String title;
  final String thumbnail;
  final double price;
  final String? category;
  final int quantity;
  final int? stock;

  CartItemModel({
    required this.id,
    required this.title ,
    required this.thumbnail,
    required this.price,
    this.category,
    required this.quantity,
    this.stock
  });

    CartItemModel copyWith({
    String? id,
    String? title,
    String? thumbnail,
    double? price,
    String? category,
    int? quantity,
    int? stock
  }) {
    return CartItemModel(
      id: id ?? this.id,
      title: title ?? this.title,
      thumbnail: thumbnail ?? this.thumbnail,
      price: price ?? this.price,
      category: category ?? this.category,
      quantity: quantity ?? this.quantity,
      stock:  stock ?? this.stock,
    );
  }
   factory CartItemModel.fromJson(Map<String,dynamic> json){
      return CartItemModel(
        id: json['id'] as String,
        title: json['title'] as String,
        thumbnail: json['thumbnail'] as String,
        price: json['price']as  double,
        quantity: json['quantity'] as int,
        stock:  json['stock'] as int
        );
  }

  Map<String,dynamic> toJson(){
    return {
      'id':id,
      'title':title,
      'thumbnail': thumbnail,
      'price':price,
      'quantity':quantity,
      'stock':stock,
    };
  }
  double get totalPrice=> price* quantity;




}