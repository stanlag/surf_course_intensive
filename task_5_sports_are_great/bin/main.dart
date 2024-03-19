class Person {
  final String name;

  Person({required this.name});

  void displayInfo() {
    print('Имя: $name');
  }
}

class Gamer extends Person {
  Team team;
  PlayerRole playerRole;
  int matchesPlayed;

  Gamer({required String name, required this.team, required this.playerRole, required this.matchesPlayed}) : super(name: name);

  @override
  void displayInfo() {
    print('Игрок: $name, команда: ${team.name}, роль в команде ${playerRole.name},сыгранных матчей: $matchesPlayed');
  }
}

class Coach extends Person {
  Team team;
  int trophiesWon;

  Coach({required String name, required this.team, required this.trophiesWon}) : super(name: name);

  @override
  void displayInfo() {
    print('Тренер: $name, Выигранных трофеев: $trophiesWon');
  }
}

class Team {
  final String name;
  Team({required this.name});
}


class PlayerRole {
  final String name;
  final String description;

  PlayerRole({required this.name, required this.description});
}

void main() {
  Team team = Team(name: 'Команда X');
  PlayerRole attack = PlayerRole(name: 'Снайпер', description: 'Атакующая роль');
  PlayerRole support = PlayerRole( name: 'Поддержка', description: 'Оборонительная роль');
  Gamer gamer1 = Gamer(name: 'Анатолий', team: team, matchesPlayed: 5, playerRole: attack);
  Gamer gamer2 = Gamer(name: 'Петр', team: team, matchesPlayed: 5, playerRole: support);
  Coach coach = Coach(name: 'Василь Петрович', team: team, trophiesWon: 30);

  gamer1.displayInfo();
  gamer2.displayInfo();
  coach.displayInfo();
}
