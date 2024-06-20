import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:task_13_photo_gallery/domain/entity/photo_entity.dart';
import 'package:task_13_photo_gallery/domain/entity/photos_state_entity.dart';

class DetailedScreen extends StatefulWidget {
  final PhotosStateEntity initState;
  const DetailedScreen({super.key, required this.initState});

  @override
  State<DetailedScreen> createState() => _DetailedScreenState();
}

class _DetailedScreenState extends State<DetailedScreen> {
  late final PageController pageController;
  late double _currentPageValue;

  /// уменьшение размера изображений сбоку
  final double _scaleFactor = 0.8;

  void _listenPageController() {
    double page = pageController.page ?? 0;
    setState(() {
      _currentPageValue = page;
    });
  }

  @override
  void initState() {
    super.initState();
    pageController = PageController(
        initialPage: widget.initState.indexUnitPhoto, viewportFraction: 0.8)
      ..addListener((_listenPageController));
    _currentPageValue = widget.initState.indexUnitPhoto.toDouble();
  }

  @override
  void dispose() {
    super.dispose();
    pageController
      ..removeListener(_listenPageController)
      ..dispose();
  }

  @override
  Widget build(BuildContext context) {
    final photos = widget.initState.photos;
    const sumPadding = 40 + 72;
    final heightPageView =
        (MediaQuery.of(context).size.height - sumPadding) / 3;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(
            Icons.arrow_back,
            size: 24,
          ),
        ),
        actions: [
          _PhotosIndicator(
            numberCurrentPhoto: _currentPageValue.round() + 1,
            numberOfPhotos: photos.length,
          )
        ],
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
      ),
      body: Padding(
        padding: EdgeInsets.only(
          top: 40,
          bottom: 72,
        ),
        child: SizedBox(
          height: double.infinity,
          child: PageView.builder(
              controller: pageController,
              itemCount: widget.initState.photos.length,
              itemBuilder: (_, index) {
                final photo = photos[index];

                ///создает еденичную матрицу для анимации
                Matrix4 matrix = Matrix4.identity();

                /// устанавоиывем минимальное значение для страницы
                var scale = 0.8;

                /// Проверяем является ли текущее фото центральным следующим или предыдущем
                ///  по отношению к выбранной странице ивычисляет значение масштаба для виджета
                if (index == _currentPageValue.floor() ||
                    index == _currentPageValue.floor() + 1 ||
                    index == _currentPageValue.floor() - 1) {
                  scale = 1 -
                      (_currentPageValue - index).abs() * (1 - _scaleFactor);
                }

                /// устанавливаем значение масштаба для следующей страницы
                var transform = heightPageView * (1 - scale) / 2;

                /// устанавливаем значение диагонали матрицы которое определяет масштаб виджета
                matrix = Matrix4.diagonal3Values(1.0, scale, 1.0)

                  /// устанавливаем смещение виджета для выравнивания по центру и вертикали
                  ..setTranslationRaw(0, transform, 0);
                return Transform(
                  transform: matrix,
                  child: _PhotoFullScreenWidget(
                    photo: photo,
                    tag: index == _currentPageValue.floor()
                        ? photo.imageUrl
                        : null,
                  ),
                );
              }),
        ),
      ),
    );
  }
}

class _PhotoFullScreenWidget extends StatelessWidget {
  final PhotoEntity photo;

  /// Для Hero анимации, для правильной анимации центральной картинки
  final String? tag;
  const _PhotoFullScreenWidget({required this.photo, this.tag});

  @override
  Widget build(BuildContext context) {
    final imageWidget = CachedNetworkImage(
      fit: BoxFit.cover,
      imageUrl: photo.imageUrl,
      placeholder: (context, url) => const Center(
        child: CircularProgressIndicator(),
      ),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: AspectRatio(
        aspectRatio: 1 / 2,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: tag == null
              ? imageWidget
              : Hero(
                  tag: photo.imageUrl,
                  child: imageWidget,
                ),
        ),
      ),
    );
  }
}

class _PhotosIndicator extends StatelessWidget {
  /// номер текущего фото
  final int numberCurrentPhoto;

  /// общее количество фото
  final int numberOfPhotos;
  const _PhotosIndicator({
    required this.numberCurrentPhoto,
    required this.numberOfPhotos,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text.rich(TextSpan(
        text: '$numberCurrentPhoto',
        style: Theme.of(context).textTheme.titleLarge,
        children: [
          TextSpan(
            text: '/$numberOfPhotos',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ],
      )),
    );
  }
}
