import 'package:flutter/material.dart';
import 'package:task_11_shopping_list/assets/res/app_assets.dart';
import 'package:task_11_shopping_list/assets/colors/app_colors.dart';
import 'package:task_11_shopping_list/utils/extension/doble_x.dart';

class ProductCardScreen extends StatelessWidget {
  const ProductCardScreen({
    super.key,
    required this.imageURL,
    required this.title,
    required this.quantityText,
    required this.priceText,
    required this.sale,
  });

  final String imageURL;
  final String title;
  final String quantityText;
  final double priceText;
  final double sale;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SizedBox(
        height: 60,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _ProductImage(imageURL: imageURL),
            const SizedBox(width: 20),
            Expanded(
                child: _ProductDetails(
                    title: title,
                    quantityText: quantityText,
                    priceText: priceText,
                    sale: sale)),
          ],
        ),
      ),
    );
  }
}

class _ProductImage extends StatelessWidget {
  const _ProductImage({required this.imageURL});
  final String imageURL;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageURL,
      width: 80,
      height: 80,
      fit: BoxFit.fitHeight,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
      errorBuilder: (c, o, s) {
        return Image.asset(AppAssets.emptyImage);
      },
    );
  }
}

class _ProductDetails extends StatelessWidget {
  const _ProductDetails(
      {required this.title,
      required this.quantityText,
      required this.priceText,
      required this.sale});
  final String title;
  final String quantityText;
  final double priceText;
  final double sale;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(title, style: Theme.of(context).textTheme.bodyMedium),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(quantityText, style: Theme.of(context).textTheme.bodyMedium),
            PriceText(priceText: priceText, sale: sale),
          ],
        ),
      ],
    );
  }
}

class PriceText extends StatelessWidget {
  const PriceText({super.key, required this.priceText, required this.sale});
  final double priceText;
  final double sale;

  @override
  Widget build(BuildContext context) {
    final discount = priceText - (priceText * sale / 100);
    if (sale == 0) {
      return Text(priceText.doubleToDecimalToFormattedCurrency(),
          style: Theme.of(context).textTheme.titleSmall);
    } else {
      final discountedPrice = discount.doubleToDecimalToFormattedCurrency();
      return Row(
        children: [
          Text(
            priceText.doubleToDecimalToFormattedCurrency(),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey,
                  decoration: TextDecoration.lineThrough,
                ),
          ),
          const SizedBox(width: 20),
          Text(
            discountedPrice,
            style: Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(color: AppColors.red),
          ),
        ],
      );
    }
  }
}
