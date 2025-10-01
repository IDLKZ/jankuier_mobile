// Parameter для добавления товара в корзину
class AddToCartParameter {
  final int productId;
  final int qty;
  final int? variantId;

  const AddToCartParameter({
    required this.productId,
    this.qty = 1,
    this.variantId,
  });

  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'qty': qty,
      if (variantId != null) 'variant_id': variantId,
    };
  }

  AddToCartParameter copyWith({
    int? productId,
    int? qty,
    int? variantId,
  }) {
    return AddToCartParameter(
      productId: productId ?? this.productId,
      qty: qty ?? this.qty,
      variantId: variantId ?? this.variantId,
    );
  }
}
