abstract class AppStrings {
  static const catalog = 'Каталог';
  static const personal = 'Личное';
  static const search = 'Поиск';
  static const cart = 'Корзина';

  static const error = 'Произошла ошибка';
  static const cheque = 'Чек № ';

  static const noneSorting = 'Без сортировки';
  static const nameFromAToZ = 'По имени от А до Я';
  static const nameFromZToA = 'По имени от Я до А';
  static const ascendingOrder = 'По возрастанию';
  static const descendingOrder = 'По убыванию';
  static const typeFromAToZ = 'По типу от А до Я';
  static const typeFromZToA = 'По типу от Я до А';
  static const byName = 'По имени';
  static const byPrice = 'По цене';
  static const byType = 'По типу';

  static const listName = 'Список покупок';
  static const yourShoppingListName = 'B вашей покупке';
  static const sorting = 'Сортировка';
  static const ready = 'Готово';

  static String discountPercentage(int percentage) => 'Скидка $percentage %';

  static const total = 'Итого';
  static const noProducts = 'нет товаров';
  static String oneProduct(int count) => '$count товар';
  static String fewProducts(int count) => '$count товара';
  static String manyProducts(int count) => '$count товаров';
  static String otherProducts(int count) => '$count тoвapa';
}
