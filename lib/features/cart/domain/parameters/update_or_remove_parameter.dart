// Parameter для обновления или удаления товара из корзины
class UpdateOrRemoveFromCartParameter {
  final int productId;
  final int? updatedQty;
  final int? variantId;
  final bool removeCompletely;

  const UpdateOrRemoveFromCartParameter({
    required this.productId,
    this.updatedQty,
    this.variantId,
    this.removeCompletely = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      if (updatedQty != null) 'updated_qty': updatedQty,
      if (variantId != null) 'variant_id': variantId,
      'remove_completely': removeCompletely,
    };
  }

  UpdateOrRemoveFromCartParameter copyWith({
    int? productId,
    int? updatedQty,
    int? variantId,
    bool? removeCompletely,
  }) {
    return UpdateOrRemoveFromCartParameter(
      productId: productId ?? this.productId,
      updatedQty: updatedQty ?? this.updatedQty,
      variantId: variantId ?? this.variantId,
      removeCompletely: removeCompletely ?? this.removeCompletely,
    );
  }
}
