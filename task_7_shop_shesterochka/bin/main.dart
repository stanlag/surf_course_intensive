import 'package:task_6_shop_shesterochka/entity.dart';
import 'package:task_6_shop_shesterochka/list.dart';

void main() {
  // Фильтрация товаров, исключение просроченных и отсутствующих в наличии
  List<RawProductItem> listCatalogWithQtyAndData = listCatalog
      .where((product) =>
  product.qty > 0 &&
      product.expirationDate.isAfter(DateTime.now()))
      .toList();

  // Группировка товаров по категориям и подкатегориям
  Map<String, Map<String, List<String>>> result = {};

  for (var product in listCatalogWithQtyAndData) {
    result.putIfAbsent(product.categoryName, () => {});
    result[product.categoryName]!.putIfAbsent(product.subcategoryName, () => []);

    result[product.categoryName]![product.subcategoryName]!.add(product.name);
  }

  // Вывод результата, если он не пуст

    print(result);


}
