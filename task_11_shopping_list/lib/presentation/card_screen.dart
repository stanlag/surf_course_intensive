import 'package:flutter/material.dart';
import 'package:task_11_shopping_list/presentation/product_card_screen.dart';
import 'package:task_11_shopping_list/utils/extension/amount_x.dart';
import 'package:task_11_shopping_list/domain/entity/product_entity.dart';

class CardScreen extends StatelessWidget {
  const CardScreen({
    required this.product,
    super.key,
  });

  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    return ProductCardScreen(
      imageURL: product.imageUrl,
      title: product.title,
      quantityText: product.amount.getQuantityText(),
      priceText: product.price / 100,
      sale: product.sale,
    );
  }
}
