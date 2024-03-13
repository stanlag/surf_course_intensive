class RawProductItem {
  final String name;
  final String categoryName;
  final String subcategoryName;
  final DateTime expirationDate;
  final int qty;

  RawProductItem({required this.name, required this.categoryName, required this.subcategoryName, required this.expirationDate, required this.qty});

  @override
  String toString() {
    return'$name, ${expirationDate.month} $qty';
    return super.toString();
  }
}