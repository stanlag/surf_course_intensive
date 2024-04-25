import '../../assets/res/app_strings.dart';

enum SortingType {
  none(type: FilterType.none, name: AppStrings.noneSorting),
  nameFromA(type: FilterType.byName, name: AppStrings.nameFromAToZ),
  nameFromZ(type: FilterType.byName, name: AppStrings.nameFromZToA),
  ascendingOrder(type: FilterType.byPrice, name: AppStrings.ascendingOrder),
  descendingOrder(type: FilterType.byPrice, name: AppStrings.descendingOrder),
  typeFromA(type: FilterType.byType, name: AppStrings.typeFromAToZ),
  typeFromZ(type: FilterType.byType, name: AppStrings.typeFromZToA);

  final FilterType type;
  final String name;
  const SortingType({required this.type, required this.name});
}

enum FilterType {
  none(AppStrings.noneSorting),
  byName(AppStrings.byName),
  byPrice(AppStrings.byPrice),
  byType(AppStrings.byType);

  final String name;
  const FilterType(this.name);
}
