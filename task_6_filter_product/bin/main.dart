
final articles = '''
1,хлеб,Бородинский,500,5
2,хлеб,Белый,200,15
3,молоко,Полосатый кот,50,53
4,молоко,Коровка,50,53
5,вода,Апельсин,25,100
6,вода,Бородинский,500,5
''';

class Product {
  int id;
  String category;
  String name;
  double price;
  int quantity;

  Product(this.id, this.category, this.name, this.price, this.quantity);
  @override
  String toString() => 'Номер: $id  категория:$category название:$name цена: $price количество: $quantity';
}

abstract class Filter<T> {
  bool apply(T item);
}

class CategoryFilter extends Filter<Product> {
  String categoryToFilter;

  CategoryFilter(this.categoryToFilter);

  @override
  bool apply(Product product) {
    return product.category == categoryToFilter;
  }
}

class PriceFilter extends Filter<Product> {
  int maxPrice;

  PriceFilter(this.maxPrice);

  @override
  bool apply(Product product) {
    return product.price <= maxPrice;
  }
}

class QuantityFilter extends Filter<Product> {
  int maxQuantity;

  QuantityFilter(this.maxQuantity);

  @override
  bool apply(Product product) {
    return product.quantity < maxQuantity;
  }
}

void applyFilter<T>(List<T> items, Filter<T> filter) {
  for (var item in items) {
    if (filter.apply(item)) {
      if (item is Product) {
        print(
            '${item.id}\t${item.category}\t${item.name}\t${item.price} рублей\t${item.quantity} шт');
      }
    }
  }
}


void main() {
  final List <String> productLines = articles.trim().split('\n'); // преобразуем строку в список и убираем лишние пробелы
  List<Product> products = [];

  for (var line in productLines) {
    var parts = line.split(',');
    if (parts.length == 5) {
      Product product = Product(
          int.parse(parts[0]), parts[1], parts[2], double.parse(parts[3]),
          int.parse(parts[4]));
      products.add(product);
    }
  }
  print('\nТовары в категории "молоко":');
  applyFilter(products, CategoryFilter('молоко'));

  print("\nТовары с ценой не больше 300 рублей:");
  applyFilter(products, PriceFilter(300));

  print("\nТовары с количеством остатков менее 10 штук:");
  applyFilter(products, QuantityFilter(10));

}
