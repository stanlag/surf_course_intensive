import 'package:task_13_photo_gallery/domain/entity/photo_entity.dart';

class PhotosStateEntity {
  final int indexUnitPhoto;
  final List<PhotoEntity> photos;

  PhotosStateEntity({
    required this.indexUnitPhoto,
    required this.photos,
  });
}
