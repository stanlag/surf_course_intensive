enum Category {
  food('Продукты питания'),
  tech('Технологичные товары'),
  care('Уход'),
  drinks('Напитки'),
  drugs('Медикаменты'),
  noCategory('');

  final String name;

  const Category(this.name);
}
