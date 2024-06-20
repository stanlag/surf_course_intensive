import 'package:task_13_photo_gallery/domain/entity/photo_entity.dart';
import 'package:task_13_photo_gallery/data/mock_data.dart';
/// репозиторий для получения данных
class  PhotosRepository {
/// получить список фотографий
  Future <List<PhotoEntity>> getPhotos() {
    return Future.value(mockData);
  }
}