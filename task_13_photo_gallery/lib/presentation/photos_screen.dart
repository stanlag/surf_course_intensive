import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:task_13_photo_gallery/assets/app_images.dart';
import 'package:task_13_photo_gallery/assets/colors/color_palette.dart';
import 'package:task_13_photo_gallery/domain/entity/photos_state_entity.dart';
import 'package:union_state/union_state.dart';
import 'package:task_13_photo_gallery/assets/app_strings.dart';
import 'package:task_13_photo_gallery/domain/entity/photo_entity.dart';
import 'package:task_13_photo_gallery/main.dart';
import 'detailed_screen.dart';

/// Главная страница приложения
class PhotosScreen extends StatefulWidget {
  const PhotosScreen({super.key});

  @override
  State<PhotosScreen> createState() => _PhotosScreenState();
}

class _PhotosScreenState extends State<PhotosScreen> {
  final screenState = UnionStateNotifier<List<PhotoEntity>>.loading();

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      final data = await photoRepository.getPhotos();
      screenState.content(data);
    } on Exception catch (e) {
      screenState.failure(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Image.asset(AppImages.logo),
          centerTitle: true,
          surfaceTintColor: Colors.transparent,
        ),
        body: UnionStateListenableBuilder<List<PhotoEntity>>(
          unionStateListenable: screenState,
          loadingBuilder: (_, __) => const _EventWidget(
              eventWidget: CircularProgressIndicator(
            color: AppColor.black,
          )),
          builder: (_, listPhoto) => listPhoto.isNotEmpty
              ? _ContentWidget(
                  data: listPhoto,
                )
              : const _EventWidget(
                  eventWidget: Text(AppStrings.empty),
                ),
          failureBuilder: (_, __, ___) => const _EventWidget(
            eventWidget: Text(AppStrings.error),
          ),
        ));
  }
}

class _ContentWidget extends StatelessWidget {
  final List<PhotoEntity> data;
  const _ContentWidget({required this.data});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 1,
        crossAxisCount: 3,
        mainAxisSpacing: 5,
        crossAxisSpacing: 3,
      ),
      itemCount: data.length,
      itemBuilder: (_, index) => _PhotoWidget(
        indexSelectPhoto: index,
        photoList: data,
      ),
    );
  }
}

class _PhotoWidget extends StatelessWidget {
  final int indexSelectPhoto;
  final List<PhotoEntity> photoList;
  const _PhotoWidget({required this.indexSelectPhoto, required this.photoList});

  @override
  Widget build(BuildContext context) {
    final imageUrl = photoList[indexSelectPhoto].imageUrl;

    void _onTap(BuildContext context, int indexInitPhoto) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => DetailedScreen(
            initState: PhotosStateEntity(
              indexUnitPhoto: indexInitPhoto,
              photos: photoList,
            ),
          ),
        ),
      );
    }

    return Center(
      child: GestureDetector(
        onTap: () => _onTap(context, indexSelectPhoto),
        child: AspectRatio(
          aspectRatio: 1,
          child: Hero(
            tag: imageUrl,
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl: imageUrl,
              placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(
                color: AppColor.black,
              )),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
        ),
      ),
    );
  }
}

/// Виджет для разных событий (пустой,загрузка, ошибка)
class _EventWidget extends StatelessWidget {
  final Widget eventWidget;
  const _EventWidget({required this.eventWidget});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: eventWidget,
    );
  }
}
