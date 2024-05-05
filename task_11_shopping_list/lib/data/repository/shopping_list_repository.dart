import 'package:task_11_shopping_list/domain/entity/cheque_entity.dart';
import 'package:task_11_shopping_list/data/mock_data.dart';

/// Репозиторий для получения данных
class ShoppingListRepository {
  /// Получение данных о продуктах
  Future<ChequeEntity> getCheque(int id) async {
    return Future.value(ChequeEntity(
      id: id,
      date: DateTime.now(),
      products: dataForStudents,
    ));
  }
}
