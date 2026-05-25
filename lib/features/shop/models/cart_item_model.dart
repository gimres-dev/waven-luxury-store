class CartItemModel {
  String productId;
  String title;
  double price;
  String? image;
  String? brandName;
  String variationId;
  Map<String, String>? selectedVariation;
  int quantity;

  CartItemModel({
    required this.productId,
    required this.title,
    required this.price,
    this.image,
    this.brandName,
    this.variationId = '',
    this.selectedVariation,
    required this.quantity,
  });

  static CartItemModel empty() =>
      CartItemModel(productId: '', title: '', price: 0, quantity: 0);

  double get totalPrice => price * quantity;

  Map<String, dynamic> toJson() => {
        'ProductId': productId,
        'Title': title,
        'Price': price,
        'Image': image ?? '',
        'BrandName': brandName ?? '',
        'VariationId': variationId,
        'SelectedVariation': selectedVariation ?? {},
        'Quantity': quantity,
      };

  factory CartItemModel.fromMap(Map<String, dynamic> data) {
    return CartItemModel(
      productId: data['ProductId'] ?? '',
      title: data['Title'] ?? '',
      price: (data['Price'] ?? 0.0).toDouble(),
      image: data['Image'],
      brandName: data['BrandName'],
      variationId: data['VariationId'] ?? '',
      selectedVariation: data['SelectedVariation'] != null
          ? Map<String, String>.from(data['SelectedVariation'])
          : null,
      quantity: data['Quantity'] ?? 1,
    );
  }

  CartItemModel copyWith({int? quantity}) {
    return CartItemModel(
      productId: productId,
      title: title,
      price: price,
      image: image,
      brandName: brandName,
      variationId: variationId,
      selectedVariation: selectedVariation,
      quantity: quantity ?? this.quantity,
    );
  }
}
