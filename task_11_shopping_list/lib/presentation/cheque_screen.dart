import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_11_shopping_list/domain/entity/sorting_type.dart';
import 'package:task_11_shopping_list/presentation/sort_category_screen.dart';
import 'package:task_11_shopping_list/presentation/sort_without_category_screen.dart';
import 'package:task_11_shopping_list/utils/extension/data_time_x.dart';
import 'package:task_11_shopping_list/utils/extension/decimal_x.dart';
import 'package:task_11_shopping_list/assets/colors/app_colors.dart';
import 'package:task_11_shopping_list/assets/res/app_strings.dart';
import 'package:task_11_shopping_list/domain/entity/cheque_entity.dart';
import 'package:task_11_shopping_list/domain/entity/product_entity.dart';
import 'package:task_11_shopping_list/domain/entity/sorted_products.dart';
import 'package:task_11_shopping_list/main.dart';
import 'filter_screen.dart';

class ChequeScreen extends StatelessWidget {
  const ChequeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final data = shoppingListRepository.getCheque(56);
    return FutureBuilder(
        future: data,
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return const _ErrorWidget();
            } else if (snapshot.hasData) {
              final data = snapshot.data as ChequeEntity;
              return _ContentWidget(
                data: data,
              );
            }
          }
          return const _LoadingWidget();
        });
  }
}

class _ContentWidget extends StatefulWidget {
  final ChequeEntity data;
  const _ContentWidget({required this.data});

  @override
  State<_ContentWidget> createState() => _ContentWidgetState();
}

class _ContentWidgetState extends State<_ContentWidget> {
  SortingType _currentFilter = SortingType.none;
  SortedProducts products = ProductsWithoutCategory(data: []);

  @override
  void initState() {
    products = ProductsWithoutCategory(data: List.from(widget.data.products));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('${AppStrings.cheque} ${widget.data.id}',
                style: Theme.of(context).textTheme.titleLarge),
            Text(widget.data.date.toStringDateAndTime(),
                style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 8, bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppStrings.listName,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.lightGrey,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: IconButton(
                    onPressed: () {
                      _onPressFilter(context);
                    },
                    icon: const Icon(
                      Icons.sort,
                      size: 24,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          children: [
            switch (products) {
              ProductsWithoutCategory(data: final data) =>
                SortWithoutCategoryScreen(products: data),
              ProductsWithCategory(productsByCategoryMap: final data) =>
                SortCategoryScreen(products: data),
            },
            const Divider(thickness: 0.5),
            const SizedBox(
              height: 5,
            ),
            _FinancialWidget(products: widget.data.products),
          ],
        ),
      ),
    );
  }

  Future<void> _onPressFilter(BuildContext context) async {
    final SortingType? filter = await showFlexibleBottomSheet(
      initHeight: 0.8,
      maxHeight: 0.8,
      bottomSheetColor: AppColors.white,
      context: context,
      builder: (
        _,
        __,
        ___,
      ) =>
          FilterScreen(filter: _currentFilter),
      isExpand: false,
      bottomSheetBorderRadius: const BorderRadius.only(
        topLeft: Radius.circular(40),
        topRight: Radius.circular(40),
      ),
    );

    if (filter == null) return;
    if (filter != _currentFilter) {
      setState(() {
        _currentFilter = filter;
        _sortProduct();
      });
    }
  }

  void _sortProduct() {
    switch (_currentFilter) {
      case SortingType.none:
        products = ProductsWithoutCategory(
          data: List.from(widget.data.products),
        );

      case SortingType.nameFromA:
        final data = List<ProductEntity>.from(widget.data.products);
        data.sort(
          (a, b) => a.title.compareTo(b.title),
        );
        products = ProductsWithoutCategory(data: data);

      case SortingType.nameFromZ:
        final data = List<ProductEntity>.from(widget.data.products);
        data.sort(
          (a, b) => b.title.compareTo(a.title),
        );
        products = ProductsWithoutCategory(data: data);

      case SortingType.ascendingOrder:
        final data = List<ProductEntity>.from(widget.data.products);
        data.sort(
          (a, b) => a.price.compareTo(b.price),
        );
        products = ProductsWithoutCategory(data: data);

      case SortingType.descendingOrder:
        final data = List<ProductEntity>.from(widget.data.products);
        data.sort(
          (a, b) => b.price.compareTo(a.price),
        );
        products = ProductsWithoutCategory(data: data);

      case SortingType.typeFromA:
        final data = List<ProductEntity>.from(widget.data.products);
        data.sort(
          (a, b) => a.category.name.compareTo(b.category.name),
        );
        products = ProductsWithCategory(data: data);
      case SortingType.typeFromZ:
        final data = List<ProductEntity>.from(widget.data.products);
        data.sort(
          (a, b) => b.category.name.compareTo(a.category.name),
        );
        products = ProductsWithCategory(data: data);
    }
  }
}

class _FinancialWidget extends StatelessWidget {
  final List<ProductEntity> products;
  const _FinancialWidget({
    required this.products,
  });
  @override
  Widget build(BuildContext context) {
    final fullTotal = _getFullTotal(products);
    final discount = _getDiscount(products);
    final total = fullTotal - discount;
    final discountPercentage =
        ((1 - (fullTotal.toDouble() / total.toDouble())) * 100).ceil();
    return Column(
      children: [
        const Divider(),
        Align(
          alignment: Alignment.topLeft,
          child: Text(AppStrings.yourShoppingListName,
              style: Theme.of(context).textTheme.titleLarge),
        ),
        _RowWidget(
          description: _plural(products.length),
          value: fullTotal.toFormattedCurrency(),
        ),
        _RowWidget(
          description: AppStrings.discountPercentage(discountPercentage),
          value: discount.toFormattedCurrency(),
        ),
        _RowWidget(
          description: AppStrings.total,
          value: total.toFormattedCurrency(),
        ),
      ],
    );
  }

  /// Склонение слова 'товар'
  String _plural(int count) {
    return Intl.plural(
      count,
      zero: AppStrings.noProducts,
      one: AppStrings.oneProduct(count),
      few: AppStrings.fewProducts(count),
      many: AppStrings.manyProducts(count),
      other: AppStrings.otherProducts(count),
      locale: 'ru',
    );
  }

  /// Стоимость товаров
  /// 'fold Сокращает коллекцию до одного значения путем итеративного объединения каждого
  /// элемента коллекции с существующим значением.
  /// Использует начальное значение в качестве
  /// начального значения, затем перебирает элементы и обновляет значение для каждого элемента
  /// с помощью функции объединения
  Decimal _getFullTotal(List<ProductEntity> products) {
    return products.fold<Decimal>(Decimal.zero,
        (previousValue, element) => previousValue + element.decimalPrice);
  }

  /// итог по скидкам
  Decimal _getDiscount(List<ProductEntity> product) {
    /// Получаем список товаров с дисконтом
    final discount = products.where((element) => element.sale > 0).toList();
    return discount.isEmpty
        ? Decimal.zero
        : discount.fold<Decimal>(
            Decimal.zero,
            (previousValue, element) =>
                previousValue +
                _calculateDiscountForProduct(
                  element.decimalPrice,
                  element.sale.toString(),
                ),
          );
  }

  /// расчет скидки для одного товара
  Decimal _calculateDiscountForProduct(Decimal price, String discountPercent) {
    final discountAmount =
        (price * Decimal.parse(discountPercent) / Decimal.fromInt(100))
            .toDecimal();
    return price - discountAmount;
  }
}

///Виджет для отображения данных в финансовом блоке
class _RowWidget extends StatelessWidget {
  final String description;
  final String value;

  const _RowWidget({required this.description, required this.value});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      children: [
        Expanded(
          child: Text(description, style: textTheme.bodyMedium),
        ),
        Text(value, style: Theme.of(context).textTheme.titleMedium),
      ],
    );
  }
}

/// Отображение загрузки
class _LoadingWidget extends StatelessWidget {
  const _LoadingWidget();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

/// Отображение ошибки
class _ErrorWidget extends StatelessWidget {
  const _ErrorWidget();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(AppStrings.error),
    );
  }
}
