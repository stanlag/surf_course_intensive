import 'package:flutter/material.dart';
import 'package:task_11_shopping_list/presentation/card_screen.dart';
import 'package:task_11_shopping_list/domain/entity/product_entity.dart';

class SortWithoutCategoryScreen extends StatelessWidget {
  const SortWithoutCategoryScreen({required this.products, super.key});

  final List<ProductEntity> products;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) => CardScreen(product: products[index]),
      ),
    );
  }
}
