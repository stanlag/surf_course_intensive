enum Countries { brazil, russia, turkish, spain, japan }

class Territory {
  final int areaInHectare;
  final List<String> crops;
  final List<AgriculturalMachinery> machineries;

  Territory(
    this.areaInHectare,
    this.crops,
    this.machineries,
  );
}

class AgriculturalMachinery {
  final String id;
  final DateTime releaseDate;

  AgriculturalMachinery(
    this.id,
    this.releaseDate,
  );

  /// Переопределяем оператор "==", чтобы сравнивать объекты по значению.
  @override
  bool operator ==(Object? other) {
    if (other is! AgriculturalMachinery) return false;
    if (other.id == id && other.releaseDate == releaseDate) return true;

    return false;
  }

  @override
  int get hashCode => id.hashCode ^ releaseDate.hashCode;

  @override
  String toString() => '${this.id} ${this.releaseDate}';
}

final mapBefore2010 = <Countries, List<Territory>>{
  Countries.brazil: [
    Territory(
      34,
      ['Кукуруза'],
      [
        AgriculturalMachinery(
          'Трактор Степан',
          DateTime(2001),
        ),
        AgriculturalMachinery(
          'Культиватор Сережа',
          DateTime(2007),
        ),
      ],
    ),
  ],
  Countries.russia: [
    Territory(
      14,
      ['Картофель'],
      [
        AgriculturalMachinery(
          'Трактор Гена',
          DateTime(1993),
        ),
        AgriculturalMachinery(
          'Гранулятор Антон',
          DateTime(2009),
        ),
      ],
    ),
    Territory(
      19,
      ['Лук'],
      [
        AgriculturalMachinery(
          'Трактор Гена',
          DateTime(1993),
        ),
        AgriculturalMachinery(
          'Дробилка Маша',
          DateTime(1990),
        ),
      ],
    ),
  ],
  Countries.turkish: [
    Territory(
      43,
      ['Хмель'],
      [
        AgriculturalMachinery(
          'Комбаин Василий',
          DateTime(1998),
        ),
        AgriculturalMachinery(
          'Сепаратор Марк',
          DateTime(2005),
        ),
      ],
    ),
  ],
};

final mapAfter2010 = {
  Countries.turkish: [
    Territory(
      22,
      ['Чай'],
      [
        AgriculturalMachinery(
          'Каток Кирилл',
          DateTime(2018),
        ),
        AgriculturalMachinery(
          'Комбаин Василий',
          DateTime(1998),
        ),
      ],
    ),
  ],
  Countries.japan: [
    Territory(
      3,
      ['Рис'],
      [
        AgriculturalMachinery(
          'Гидравлический молот Лена',
          DateTime(2014),
        ),
      ],
    ),
  ],
  Countries.spain: [
    Territory(
      29,
      ['Арбузы'],
      [
        AgriculturalMachinery(
          'Мини-погрузчик Максим',
          DateTime(2011),
        ),
      ],
    ),
    Territory(
      11,
      ['Табак'],
      [
        AgriculturalMachinery(
          'Окучник Саша',
          DateTime(2010),
        ),
      ],
    ),
  ],
};

void main() {
  // Получение списка AgriculturalMachinery из mapBefore2010
  List<AgriculturalMachinery> machineryListBefore2010 = mapBefore2010.values
      .expand((territories) =>
          territories.expand((territory) => territory.machineries))
      .toList();

  // Получение списка AgriculturalMachinery из mapAfter2010
  List<AgriculturalMachinery> machineryListAfter2010 = mapAfter2010.values
      .expand((territories) =>
          territories.expand((territory) => territory.machineries))
      .toList();

// Объединение списки убираем дубли
  List<AgriculturalMachinery> machineryList =
      (machineryListBefore2010 + machineryListAfter2010).toSet().toList();

  print('Всего техники: ${machineryList.length} машин');

  // Расчет среднего возраста всей техники
  final averageAge = (machineryList
          .map((machinery) => DateTime.now().year - machinery.releaseDate.year)
          .reduce((sum, age) => sum + age)) /
      machineryList.length;

  // Вывод результатов по среднему возрасту техники
  print('Средний возраст всей техники: ${averageAge.toStringAsFixed(1)} лет');

  // Сортировка по дате
  machineryList.sort((a, b) => a.releaseDate.compareTo(b.releaseDate));

  // Выбираем половину самых старых машин
  final oldestMachinery =
      machineryList.sublist(0, (machineryList.length * 0.5).ceil());

  // Вывод результатов по среднему возрасту самой старой техники
  final oldestMachineryAverageAge = (oldestMachinery
          .map((machinery) => DateTime.now().year - machinery.releaseDate.year)
          .reduce((sum, age) => sum + age)) /
      oldestMachinery.length;

  // Вывод результатов по среднему возрасту техники самой старой техники
  print(
      'Средний возраст половины самой старой техники: ${oldestMachineryAverageAge.toStringAsFixed(1)} лет');
}
// Всего техники: 11 машин
// Средний возраст всей техники: 17.9 лет
// Средний возраст половины самой старой техники: 24.0 лет