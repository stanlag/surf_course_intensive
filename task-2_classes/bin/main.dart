class Film {
  final String title; // Название фильма
  final String director; // Режиссер
  final int releaseYear; // Год выпуска
  final List<Actor> cast; // Актерский состав
  final Actor? star; // звездные актер
  // Конструктор
  const Film(
      {required this.title,
      required this.director,
      required this.releaseYear,
      required this.cast,
      required this.star});

// Конструктор с фабричным методом для создания фильма без актерского состава
  factory Film.withoutCast(String title, String director, int releaseYear) {
    return Film(
        title: title,
        director: director,
        releaseYear: releaseYear,
        cast: [],
        star: null);
  }

  // Метод для вывода информации о фильме
  void displayInfo() {
    print('Фильм: $title, режисер: $director, год выхода в прокат: $releaseYear.');
    print('Актеры:');
    for (var actor in cast) {
      actor.displayInfo();
    }
    print(star == null ? 'В кадре обычные люди, звезд нет.' : 'Звезда фильма: $star');
  }
}

class Actor {
  final String name; // Имя актера
  final String role; // Роль актера в фильме

  // Конструктор
  const Actor({required this.name, required this.role});

  // Метод для вывода информации об актере
  void displayInfo() {
    print('актер: $name, роль: $role');
  }
  // Переопределяем метод toString
  @override
  String toString() => '$name в роли $role';
}

void main() {
  // Создаем фильм с актерским составом
  const film1 = Film(
      title: 'Большой куш',
      director: 'Гай Ричи',
      releaseYear: 2000,
      cast: [
        Actor(name: 'Брэт Пит', role: 'Микки'),
        Actor(name: 'Джейсон Стейтем', role: 'Турецкий'),
        Actor(name: 'Винни Джонс', role: 'Тони пуля в зубах'),
      ],
      star: Actor(name: 'Брэт Пит', role: 'Микки'));

  // Создаем фильм без актерского состава, используя фабричный метод
  Film film2 =
      Film.withoutCast('Одиссея Жака Кусто', 'Жак-Ив Кусто', 1966);

  // Выводим информацию о фильмах
  film1.displayInfo();
  print('\n');
  film2.displayInfo();

}

// Фильм: Большой куш, режисер: Гай Ричи, год выхода в прокат: 2000.
// Актеры:
// актер: Брэт Пит, роль: Микки
// актер: Джейсон Стейтем, роль: Турецкий
// актер: Винни Джонс, роль: Тони пуля в зубах
// Звезда фильма: Брэт Пит в роли Микки
//
//
// Фильм: Одиссея Жака Кусто, режисер: Жак-Ив Кусто, год выхода в прокат: 1966.
// Актеры:
// В кадре обычные люди, звезд нет.
