import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:jankuier_mobile/core/constants/api_constants.dart';
import 'package:jankuier_mobile/core/constants/app_colors.dart';
import 'package:jankuier_mobile/core/constants/app_route_constants.dart';
import 'package:jankuier_mobile/core/di/injection.dart';
import 'package:jankuier_mobile/core/utils/hive_utils.dart';
import 'package:jankuier_mobile/core/utils/localization_helper.dart';
import 'package:jankuier_mobile/features/cart/domain/parameters/add_to_cart_parameter.dart';
import 'package:jankuier_mobile/features/cart/presentation/bloc/add_to_cart/add_to_cart_bloc.dart';
import 'package:jankuier_mobile/features/cart/presentation/bloc/add_to_cart/add_to_cart_event.dart';
import 'package:jankuier_mobile/features/cart/presentation/bloc/add_to_cart/add_to_cart_state.dart';
import 'package:jankuier_mobile/features/services/data/entities/product/full_product_entity.dart';
import 'package:jankuier_mobile/features/services/data/entities/product/modification_type_entity.dart';
import 'package:jankuier_mobile/features/services/data/entities/product/modification_value_entity.dart';
import 'package:jankuier_mobile/features/services/data/entities/product/product_variant_entity.dart';
import 'package:jankuier_mobile/features/services/presentation/bloc/full_product_detail/full_product_bloc.dart';
import 'package:jankuier_mobile/features/services/presentation/bloc/full_product_detail/full_product_detail_state.dart';
import 'package:jankuier_mobile/shared/widgets/input_qty.dart';
import 'package:jankuier_mobile/shared/widgets/main_title_widget.dart';
import '../../../../l10n/app_localizations.dart';

/// Экран детальной информации о продукте/услуге
///
/// Отображает:
/// - Галерею изображений с навигацией
/// - Детальную информацию о продукте
/// - Варианты модификаций и их цены
/// - Функциональность добавления в избранное и корзину
class ServiceProductPage extends StatefulWidget {
  /// Идентификатор продукта для загрузки
  final int productId;

  const ServiceProductPage({super.key, required this.productId});

  @override
  State<ServiceProductPage> createState() => _ServiceProductPageState();
}

class _ServiceProductPageState extends State<ServiceProductPage> {
  /// Состояние избранного товара
  bool _isFavorite = false;

  /// Состояние добавления в корзину (заменяет избранное после добавления)
  bool _isAddedToCart = false;

  /// Текущий индекс изображения в галерее
  int _currentImageIndex = 0;

  /// Контроллер для управления каруселью изображений
  final CarouselSliderController _carouselController =
      CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: BlocBuilder<FullProductBloc, GetFullProductState>(
        buildWhen: (previous, current) {
          // Оптимизация: перестраиваем только при изменении данных
          if (previous is GetFullProductLoadedState &&
              current is GetFullProductLoadedState) {
            return previous.result != current.result;
          }
          return true;
        },
        builder: (context, state) => _buildBody(state),
      ),
    );
  }

  /// Строит основное содержимое экрана в зависимости от состояния
  Widget _buildBody(GetFullProductState state) {
    if (state is GetFullProductLoadingState) {
      return const Center(
        child: CircularProgressIndicator(color: AppColors.primary),
      );
    }

    if (state is GetFullProductFailedState) {
      return _buildErrorState(
          state.failure.message ?? AppLocalizations.of(context)!.errorOccurred);
    }

    if (state is GetFullProductLoadedState) {
      return _buildLoadedState(state.result);
    }

    return const SizedBox.shrink();
  }

  /// Строит состояние ошибки
  Widget _buildErrorState(String message) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline_rounded,
              size: 72.sp,
              color: AppColors.error,
            ),
            SizedBox(height: 20.h),
            Text(
              AppLocalizations.of(context)!.loadingError,
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.sp,
                color: AppColors.textSecondary,
                height: 1.4,
              ),
            ),
            SizedBox(height: 32.h),
            ElevatedButton.icon(
              onPressed: () => context.pop(),
              icon: const Icon(Icons.arrow_back),
              label: Text(AppLocalizations.of(context)!.goBack),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.white,
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Строит успешно загруженное состояние
  Widget _buildLoadedState(FullProductEntity product) {
    final imageUrls = product.galleries
        .where((gallery) => gallery.file != null)
        .map((gallery) => gallery.file!.filePath)
        .where((url) => url.isNotEmpty)
        .toList();

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          // Галерея изображений
          _buildImageGallery(imageUrls),

          // Карточка с деталями продукта
          _ProductDetailCard(
            fullProductEntity: product,
            onAddToCart: _handleAddToCart,
            onCartAdded: () {
              setState(() {
                _isAddedToCart = true;
              });
            },
          ),
        ],
      ),
    );
  }

  /// Строит галерею изображений
  Widget _buildImageGallery(List<String> imageUrls) {
    if (imageUrls.isEmpty) {
      return _buildPlaceholderImage();
    }

    return Column(
      children: [
        // Основная карусель
        Stack(
          children: [
            CarouselSlider.builder(
              carouselController: _carouselController,
              itemCount: imageUrls.length,
              itemBuilder: (context, index, _) =>
                  _buildCarouselItem(imageUrls[index]),
              options: CarouselOptions(
                height: 420.h,
                viewportFraction: 1.0,
                enableInfiniteScroll: imageUrls.length > 1,
                autoPlay: imageUrls.length > 1,
                autoPlayInterval: const Duration(seconds: 5),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                onPageChanged: (index, reason) {
                  if (mounted) {
                    setState(() {
                      _currentImageIndex = index;
                    });
                  }
                },
              ),
            ),
            // Заголовочная панель с кнопками
            _buildHeaderOverlay(),
            // Индикатор страниц
            if (imageUrls.length > 1) _buildPageIndicator(imageUrls.length),
          ],
        ),

        // Превью миниатюр
        if (imageUrls.length > 1) ...[
          SizedBox(height: 20.h),
          _buildThumbnails(imageUrls),
        ],
      ],
    );
  }

  /// Строит элемент карусели
  Widget _buildCarouselItem(String imageUrl) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.grey100,
      ),
      child: Image.network(
        ApiConstant.GetImageUrl(imageUrl),
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes!
                  : null,
              color: AppColors.primary,
              strokeWidth: 3,
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) => _buildImageError(),
      ),
    );
  }

  /// Строит заглушку для отсутствующего изображения
  Widget _buildPlaceholderImage() {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 420.h,
          color: AppColors.grey200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.image_outlined,
                size: 80.sp,
                color: AppColors.grey500,
              ),
              SizedBox(height: 16.h),
              Text(
                AppLocalizations.of(context)!.imageNotAvailable,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: AppColors.grey600,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        _buildHeaderOverlay(),
      ],
    );
  }

  /// Строит ошибку загрузки изображения
  Widget _buildImageError() {
    return Container(
      width: double.infinity,
      height: 420.h,
      color: AppColors.grey100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.broken_image_outlined,
            size: 64.sp,
            color: AppColors.grey400,
          ),
          SizedBox(height: 12.h),
          Text(
            AppLocalizations.of(context)!.imageLoadingError,
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColors.grey500,
            ),
          ),
        ],
      ),
    );
  }

  /// Строит верхнюю панель с кнопками
  Widget _buildHeaderOverlay() {
    return Positioned(
      top: MediaQuery.of(context).padding.top + 12.h,
      left: 20.w,
      right: 20.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildCircularButton(
            icon: Icons.arrow_back_ios_new,
            onTap: () => context.pop(),
          ),
          _buildCircularButton(
              icon: Icons.shopping_cart,
              color: AppColors.primary,
              onTap: () {
                context.push(AppRouteConstants.MyCartPagePath);
              }),
        ],
      ),
    );
  }

  /// Строит круглую кнопку с тенью
  Widget _buildCircularButton({
    required IconData icon,
    required VoidCallback onTap,
    Color? color,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(25.r),
        child: Container(
          width: 50.w,
          height: 50.w,
          decoration: BoxDecoration(
            color: AppColors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppColors.shadow,
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Icon(
            icon,
            color: color ?? AppColors.primary,
            size: 22.sp,
          ),
        ),
      ),
    );
  }

  /// Строит индикатор текущей страницы
  Widget _buildPageIndicator(int itemCount) {
    return Positioned(
      bottom: 20.h,
      left: 0,
      right: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          itemCount,
          (index) => AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: EdgeInsets.symmetric(horizontal: 4.w),
            width: _currentImageIndex == index ? 28.w : 8.w,
            height: 8.h,
            decoration: BoxDecoration(
              color: _currentImageIndex == index
                  ? AppColors.white
                  : AppColors.white.withOpacity(0.5),
              borderRadius: BorderRadius.circular(4.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Строит список миниатюр
  Widget _buildThumbnails(List<String> imageUrls) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: SizedBox(
        height: 80.h,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: imageUrls.length,
          itemBuilder: (context, index) {
            final isSelected = _currentImageIndex == index;
            return GestureDetector(
              onTap: () => _carouselController.animateToPage(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 80.w,
                height: 80.h,
                margin: EdgeInsets.only(right: 12.w),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: isSelected ? AppColors.primary : Colors.transparent,
                    width: 2.5,
                  ),
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: AppColors.primary.withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : null,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14.r),
                  child: Image.network(
                    ApiConstant.GetImageUrl(imageUrls[index]),
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: AppColors.grey200,
                      child: Icon(
                        Icons.broken_image,
                        color: AppColors.grey400,
                        size: 32.sp,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  /// Переключает состояние избранного
  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
    });

    // Показываем снэкбар с обратной связью
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: AppLocalizations.of(context)!.success,
          message: _isFavorite
              ? AppLocalizations.of(context)!.addedToFavorites
              : AppLocalizations.of(context)!.removedFromFavorites,
          contentType: ContentType.success,
        ),
        duration: const Duration(milliseconds: 1500),
      ),
    );

    // TODO: Добавить логику сохранения в избранное через BLoC
  }

  /// Обрабатывает добавление в корзину
  void _handleAddToCart() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: AppLocalizations.of(context)!.success,
          message: AppLocalizations.of(context)!.productAddedToCart,
          contentType: ContentType.success,
        ),
        action: SnackBarAction(
          label: AppLocalizations.of(context)!.toCart,
          textColor: AppColors.white,
          onPressed: () {
            context.push(AppRouteConstants.MyCartPagePath);
          },
        ),
      ),
    );

    // TODO: Реализовать добавление в корзину через BLoC
  }
}

/// Карточка с детальной информацией о продукте
class _ProductDetailCard extends StatefulWidget {
  /// Полная информация о продукте
  final FullProductEntity fullProductEntity;

  /// Callback для добавления в корзину
  final VoidCallback onAddToCart;

  /// Callback после успешного добавления в корзину
  final VoidCallback onCartAdded;

  const _ProductDetailCard({
    required this.fullProductEntity,
    required this.onAddToCart,
    required this.onCartAdded,
  });

  @override
  State<_ProductDetailCard> createState() => _ProductDetailCardState();
}

class _ProductDetailCardState extends State<_ProductDetailCard> {
  /// Карта выбранных модификаций: typeId -> valueId
  final Map<int, int> _selectedModifications = <int, int>{};

  /// Выбранный вариант продукта
  ProductVariantEntity? _selectedProductVariant;

  /// HiveUtils для проверки авторизации
  late final HiveUtils _hiveUtils;

  @override
  void initState() {
    super.initState();
    _hiveUtils = HiveUtils();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r),
          topRight: Radius.circular(24.r),
        ),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProductHeader(),
            SizedBox(height: 24.h),
            _buildProductMeta(),
            SizedBox(height: 20.h),
            _buildPriceSection(),
            SizedBox(height: 20.h),
            _buildProductCharacteristics(),
            SizedBox(height: 20.h),
            _buildStockStatus(),
            SizedBox(height: 24.h),
            _buildModificationOptions(),
            SizedBox(height: 32.h),
            _buildAddToCartSection(),
          ],
        ),
      ),
    );
  }

  /// Строит заголовок и описание продукта
  Widget _buildProductHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MainTitleWidget(
            title: context
                    .localizedDirectTitle(widget.fullProductEntity.product) ??
                AppLocalizations.of(context)!.untitled),
        SizedBox(height: 12.h),
        if (widget.fullProductEntity.product.localizedDescription(context) !=
            null)
          Text(
            context
                .localizedDirectDescription(widget.fullProductEntity.product),
            style: TextStyle(
              fontSize: 16.sp,
              color: AppColors.textSecondary,
              height: 1.5,
            ),
          ),
      ],
    );
  }

  /// Строит мета-информацию (категория, артикул)
  Widget _buildProductMeta() {
    return Wrap(
      spacing: 12.w,
      runSpacing: 8.h,
      children: [
        if (widget.fullProductEntity.product.category
                ?.localizedTitle(context)
                .isNotEmpty ==
            true)
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Text(
              context.localizedDirectTitle(
                  widget.fullProductEntity.product.category),
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: AppColors.grey100,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Text(
            '${AppLocalizations.of(context)!.article} ${widget.fullProductEntity.product.sku}',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  /// Строит секцию с ценой
  Widget _buildPriceSection() {
    return Row(
      children: _buildPriceTags(_selectedProductVariant),
    );
  }

  /// Строит характеристики продукта
  Widget _buildProductCharacteristics() {
    return Wrap(
      spacing: 20.w,
      runSpacing: 12.h,
      children: [
        _buildCharacteristicChip(
          icon: Icons.person_outline,
          label: _getGenderText(widget.fullProductEntity.product.gender),
        ),
        _buildCharacteristicChip(
          icon: Icons.child_care_outlined,
          label: widget.fullProductEntity.product.isForChildren
              ? AppLocalizations.of(context)!.forChildren
              : AppLocalizations.of(context)!.forAdults,
        ),
      ],
    );
  }

  /// Строит чип с характеристикой
  Widget _buildCharacteristicChip({
    required IconData icon,
    required String label,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 20.sp, color: AppColors.primary),
        SizedBox(width: 8.w),
        Text(
          label,
          style: TextStyle(
            fontSize: 14.sp,
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  /// Строит статус наличия товара
  Widget _buildStockStatus() {
    final stock = _selectedProductVariant?.stock ??
        widget.fullProductEntity.product.stock;
    final isInStock = stock > 0;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color:
            (isInStock ? AppColors.success : AppColors.error).withOpacity(0.1),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: (isInStock ? AppColors.success : AppColors.error)
              .withOpacity(0.3),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 12.w,
            height: 12.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isInStock ? AppColors.success : AppColors.error,
            ),
          ),
          SizedBox(width: 12.w),
          Text(
            isInStock
                ? '${AppLocalizations.of(context)!.inStock} ($stock шт.)'
                : AppLocalizations.of(context)!.outOfStock,
            style: TextStyle(
              color: isInStock ? AppColors.success : AppColors.error,
              fontSize: 15.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  /// Строит опции модификаций
  Widget _buildModificationOptions() {
    if (widget.fullProductEntity.modificationTypes.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.variants,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: 16.h),
        ...widget.fullProductEntity.modificationTypes.map(
          (type) => _buildModificationTypeSection(type),
        ),
      ],
    );
  }

  /// Строит секцию типа модификации
  Widget _buildModificationTypeSection(ModificationTypeEntity type) {
    // Получаем доступные значения модификаций с учетом уже выбранных
    final availableValues = _getAvailableModificationValues(type.id);

    if (availableValues.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.localizedDirectTitle(type),
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: 12.h),
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: availableValues
                .map((value) => _buildModificationChip(type.id, value))
                .toList(),
          ),
        ],
      ),
    );
  }

  /// Строит чип модификации
  Widget _buildModificationChip(int typeId, ModificationValueEntity value) {
    final isSelected = _selectedModifications[typeId] == value.id;

    return FilterChip(
      label: Text(context.localizedDirectTitle(value)),
      selected: isSelected,
      onSelected: (selected) =>
          _handleModificationSelection(typeId, value.id, selected),
      selectedColor: AppColors.primary,
      checkmarkColor: AppColors.white,
      backgroundColor: AppColors.white,
      side: BorderSide(
        color: isSelected ? AppColors.primary : AppColors.border,
        width: 1.5,
      ),
      labelStyle: TextStyle(
        fontSize: 14.sp,
        color: isSelected ? AppColors.white : AppColors.textPrimary,
        fontWeight: FontWeight.w500,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
      ),
      elevation: 0,
      pressElevation: 2,
    );
  }

  /// Строит секцию добавления в корзину
  Widget _buildAddToCartSection() {
    final currentPrice = _getCurrentPrice();
    final isAvailable = _isStockAvailable();

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.price,
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.textSecondary,
              ),
            ),
            Text(
              '${currentPrice.toStringAsFixed(0)} ₸',
              style: TextStyle(
                fontSize: 28.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.success,
              ),
            ),
          ],
        ),
        SizedBox(width: 20.w),
        Expanded(
          child: FutureBuilder(
            future: _hiveUtils.getCurrentUser(),
            builder: (context, snapshot) {
              final isUserLoggedIn = snapshot.data != null;

              return ElevatedButton(
                onPressed: isAvailable && isUserLoggedIn
                    ? () => _showQuantityBottomSheet()
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  disabledBackgroundColor: AppColors.grey300,
                  foregroundColor: AppColors.white,
                  disabledForegroundColor: AppColors.textDisabled,
                  padding: EdgeInsets.symmetric(vertical: 18.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  elevation: 0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      !isAvailable
                          ? Icons.block
                          : (isUserLoggedIn
                              ? Icons.shopping_cart_outlined
                              : Icons.login),
                      size: 20.sp,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      !isAvailable
                          ? AppLocalizations.of(context)!.outOfStock
                          : (isUserLoggedIn
                              ? AppLocalizations.of(context)!.add
                              : AppLocalizations.of(context)!.pleaseLogin),
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  /// Обработчик выбора модификации
  void _handleModificationSelection(int typeId, int valueId, bool selected) {
    setState(() {
      if (selected) {
        _selectedModifications[typeId] = valueId;
      } else {
        _selectedModifications.remove(typeId);
      }
      _updateSelectedVariant();
    });
  }

  /// Обновляет выбранный вариант продукта
  void _updateSelectedVariant() {
    if (_selectedModifications.isEmpty) {
      _selectedProductVariant = null;
      return;
    }

    // Ищем вариант, который соответствует выбранным модификациям
    for (final variant in widget.fullProductEntity.variants) {
      final variantModifications = widget
          .fullProductEntity.productVariantModifications
          .where((pvm) => pvm.variantId == variant.id)
          .map((pvm) => pvm.modificationValueId)
          .toSet();
      if (variantModifications.containsAll(_selectedModifications.values)) {
        _selectedProductVariant = variant;
        return;
      }
    }

    _selectedProductVariant = null;
  }

  /// Получает доступные значения модификаций для данного типа
  /// с учетом уже выбранных модификаций других типов
  List<ModificationValueEntity> _getAvailableModificationValues(int typeId) {
    // Все значения для данного типа модификации
    final allValuesForType = widget.fullProductEntity.modificationValues
        .where((value) => value.modificationTypeId == typeId)
        .toList();

    // Если ничего не выбрано, показываем все
    if (_selectedModifications.isEmpty) {
      return allValuesForType;
    }

    // Если выбран этот тип, показываем все (чтобы можно было сменить выбор)
    if (_selectedModifications.containsKey(typeId)) {
      return allValuesForType;
    }

    // Получаем выбранные значения других типов
    final selectedValues = _selectedModifications.values.toSet();

    // Фильтруем: оставляем только те значения, которые встречаются
    // в вариантах вместе с уже выбранными модификациями
    final availableValues = <ModificationValueEntity>[];

    for (final value in allValuesForType) {
      // Проверяем, существует ли вариант с этим значением и выбранными модификациями
      final hasCompatibleVariant =
          widget.fullProductEntity.variants.any((variant) {
        final variantModifications = widget
            .fullProductEntity.productVariantModifications
            .where((pvm) => pvm.variantId == variant.id)
            .map((pvm) => pvm.modificationValueId)
            .toSet();

        // Вариант должен содержать все выбранные значения И текущее проверяемое значение
        return variantModifications.containsAll(selectedValues) &&
            variantModifications.contains(value.id);
      });

      if (hasCompatibleVariant) {
        availableValues.add(value);
      }
    }

    return availableValues;
  }

  /// Получает текущую цену
  double _getCurrentPrice() {
    // Безопасное получение basePrice
    final basePriceValue = widget.fullProductEntity.product.basePrice;
    final basePrice = basePriceValue is double
        ? basePriceValue
        : double.tryParse(basePriceValue.toString()) ?? 0.0;

    // Безопасное получение priceDelta
    final priceDeltaValue = _selectedProductVariant?.priceDelta;
    final priceDelta = priceDeltaValue == null
        ? 0.0
        : (priceDeltaValue is double
            ? priceDeltaValue
            : double.tryParse(priceDeltaValue.toString()) ?? 0.0);

    return basePrice + priceDelta;
  }

  /// Проверяет наличие товара
  bool _isStockAvailable() {
    final stock = _selectedProductVariant?.stock ??
        widget.fullProductEntity.product.stock;
    return stock > 0;
  }

  /// Строит теги цен с учетом скидок
  List<Widget> _buildPriceTags(ProductVariantEntity? selectedProductVariant) {
    final double totalPrice = _getCurrentPrice();

    // Безопасное получение oldPrice
    final oldPriceValue = widget.fullProductEntity.product.oldPrice;
    final double? oldPrice = oldPriceValue == null
        ? null
        : (oldPriceValue is double
            ? oldPriceValue
            : double.tryParse(oldPriceValue.toString()));

    final bool hasOldPrice = oldPrice != null && oldPrice > totalPrice;

    double? discountPercent;
    if (hasOldPrice) {
      discountPercent = ((oldPrice! - totalPrice) / oldPrice * 100);
    }

    return [
      Text(
        '${totalPrice.toStringAsFixed(0)} ₸',
        style: TextStyle(
          color: AppColors.success,
          fontSize: 32.sp,
          fontWeight: FontWeight.w700,
        ),
      ),
      SizedBox(width: 16.w),
      if (hasOldPrice) ...[
        Text(
          '${oldPrice?.toStringAsFixed(0) ?? '0'} ₸',
          style: TextStyle(
            fontSize: 20.sp,
            color: AppColors.textSecondary,
            decoration: TextDecoration.lineThrough,
            decorationColor: AppColors.textSecondary,
          ),
        ),
        SizedBox(width: 12.w),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: AppColors.error.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Text(
            '-${discountPercent?.toStringAsFixed(0) ?? '0'}%',
            style: TextStyle(
              color: AppColors.error,
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    ];
  }

  /// Получает текст пола
  String _getGenderText(int gender) {
    switch (gender) {
      case 0:
        return AppLocalizations.of(context)!.unisex;
      case 1:
        return AppLocalizations.of(context)!.forMen;
      case 2:
        return AppLocalizations.of(context)!.forWomen;
      default:
        return AppLocalizations.of(context)!.unisex;
    }
  }

  /// Показывает bottom sheet с выбором количества
  void _showQuantityBottomSheet() {
    // Захватываем значения до открытия bottom sheet
    final stock = _selectedProductVariant?.stock ??
        widget.fullProductEntity.product.stock;
    final variantId = _selectedProductVariant?.id;
    final productId = widget.fullProductEntity.product.id;
    int selectedQuantity = 1;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext bottomSheetContext) {
        return BlocProvider(
          create: (context) => getIt<AddToCartBloc>(),
          child: BlocListener<AddToCartBloc, AddToCartState>(
            listener: (context, state) {
              if (state is AddToCartSuccess) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    elevation: 0,
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.transparent,
                    content: AwesomeSnackbarContent(
                      title: AppLocalizations.of(context)!.success,
                      message: AppLocalizations.of(context)!.addedToCart,
                      contentType: ContentType.success,
                    ),
                    duration: const Duration(milliseconds: 1500),
                  ),
                );
                widget.onCartAdded();
              } else if (state is AddToCartError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    elevation: 0,
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.transparent,
                    content: AwesomeSnackbarContent(
                      title: AppLocalizations.of(context)!.error,
                      message: state.message,
                      contentType: ContentType.failure,
                    ),
                  ),
                );
              }
            },
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24.r),
                  topRight: Radius.circular(24.r),
                ),
              ),
              padding: EdgeInsets.only(
                left: 24.w,
                right: 24.w,
                top: 24.h,
                bottom:
                    MediaQuery.of(bottomSheetContext).viewInsets.bottom + 24.h,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.selectQuantity,
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(bottomSheetContext),
                        icon: const Icon(Icons.close),
                        color: AppColors.textSecondary,
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),
                  Center(
                    child: InputQty(
                      maxVal: stock,
                      initVal: 1,
                      minVal: 1,
                      steps: 1,
                      onQtyChanged: (value) {
                        selectedQuantity = value;
                      },
                    ),
                  ),
                  SizedBox(height: 32.h),
                  BlocBuilder<AddToCartBloc, AddToCartState>(
                    builder: (context, state) {
                      final isLoading = state is AddToCartLoading;

                      return SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: isLoading
                              ? null
                              : () {
                                  final parameter = AddToCartParameter(
                                    productId: productId,
                                    qty: selectedQuantity,
                                    variantId: variantId,
                                  );
                                  context.read<AddToCartBloc>().add(
                                        AddToCartRequested(parameter),
                                      );
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: AppColors.white,
                            padding: EdgeInsets.symmetric(vertical: 16.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.r),
                            ),
                            elevation: 0,
                          ),
                          child: isLoading
                              ? SizedBox(
                                  height: 24.h,
                                  width: 24.w,
                                  child: const CircularProgressIndicator(
                                    color: AppColors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : Text(
                                  AppLocalizations.of(context)!.confirm,
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
