import 'package:collection/collection.dart';
import 'package:task_11_shopping_list/domain/entity/product_entity.dart';

import 'category_type.dart';

sealed class SortedProducts {
  List<ProductEntity> get data;
}

class ProductsWithoutCategory implements SortedProducts {
  final List<ProductEntity> _data;

  ProductsWithoutCategory({required List<ProductEntity> data}) : _data = data;

  @override
  List<ProductEntity> get data => _data;
}

class ProductsWithCategory implements SortedProducts {
  final List<ProductEntity> _data;

  ProductsWithCategory({required List<ProductEntity> data}) : _data = data;

  Map<Category, List<ProductEntity>> get productsByCategoryMap {
    return groupBy(_data, (product) => product.category);
  }

  @override
  List<ProductEntity> get data => _data;
}
