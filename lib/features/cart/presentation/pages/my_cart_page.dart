import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:jankuier_mobile/core/constants/api_constants.dart';
import 'package:jankuier_mobile/core/constants/app_colors.dart';
import 'package:jankuier_mobile/core/constants/app_route_constants.dart';
import 'package:jankuier_mobile/core/di/injection.dart';
import 'package:jankuier_mobile/core/utils/price_formatter.dart';
import 'package:jankuier_mobile/features/cart/data/entities/cart_item_entity.dart';
import 'package:jankuier_mobile/features/cart/domain/parameters/update_or_remove_parameter.dart';
import 'package:jankuier_mobile/features/cart/presentation/bloc/clear_cart/clear_cart_bloc.dart';
import 'package:jankuier_mobile/features/cart/presentation/bloc/clear_cart/clear_cart_event.dart';
import 'package:jankuier_mobile/features/cart/presentation/bloc/clear_cart/clear_cart_state.dart';
import 'package:jankuier_mobile/features/cart/presentation/bloc/my_cart/my_cart_bloc.dart';
import 'package:jankuier_mobile/features/cart/presentation/bloc/my_cart/my_cart_event.dart';
import 'package:jankuier_mobile/features/cart/presentation/bloc/my_cart/my_cart_state.dart';
import 'package:jankuier_mobile/features/cart/presentation/bloc/update_cart_item/update_cart_item_bloc.dart';
import 'package:jankuier_mobile/features/cart/presentation/bloc/update_cart_item/update_cart_item_event.dart';
import 'package:jankuier_mobile/features/cart/presentation/bloc/update_cart_item/update_cart_item_state.dart';
import 'package:jankuier_mobile/features/product_order/presentation/bloc/create_product_order_from_cart/create_product_order_from_cart_bloc.dart';
import 'package:jankuier_mobile/features/product_order/presentation/bloc/create_product_order_from_cart/create_product_order_from_cart_event.dart';
import 'package:jankuier_mobile/features/product_order/presentation/bloc/create_product_order_from_cart/create_product_order_from_cart_state.dart';
import 'package:jankuier_mobile/shared/widgets/common_app_bars/pages_common_app_bar.dart';
import '../../../../l10n/app_localizations.dart';

class MyCartPage extends StatelessWidget {
  const MyCartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              getIt<MyCartBloc>()..add(const LoadMyCart(checkCartItems: true)),
        ),
        BlocProvider(create: (context) => getIt<UpdateCartItemBloc>()),
        BlocProvider(create: (context) => getIt<ClearCartBloc>()),
        BlocProvider(
            create: (context) => getIt<CreateProductOrderFromCartBloc>()),
      ],
      child: const _MyCartPageContent(),
    );
  }
}

class _MyCartPageContent extends StatefulWidget {
  const _MyCartPageContent();

  @override
  State<_MyCartPageContent> createState() => _MyCartPageContentState();
}

class _MyCartPageContentState extends State<_MyCartPageContent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: PagesCommonAppBar(
          title: "Корзина",
          actionIcon: Iconsax.bag,
          onActionTap: () {
            context.go(AppRouteConstants.MyProductOrdersPagePath);
          }),
      body: MultiBlocListener(
        listeners: [
          BlocListener<UpdateCartItemBloc, UpdateCartItemState>(
            listener: (context, state) {
              if (state is UpdateCartItemSuccess) {
                context
                    .read<MyCartBloc>()
                    .add(const LoadMyCart(checkCartItems: true));
              } else if (state is UpdateCartItemError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    elevation: 0,
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.transparent,
                    content: AwesomeSnackbarContent(
                      title: AppLocalizations.of(context)!.error,
                      message: state.message,
                      contentType: ContentType.warning,
                    ),
                  ),
                );
              }
            },
          ),
          BlocListener<ClearCartBloc, ClearCartState>(
            listener: (context, state) {
              if (state is ClearCartSuccess) {
                context
                    .read<MyCartBloc>()
                    .add(const LoadMyCart(checkCartItems: true));
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    elevation: 0,
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.transparent,
                    content: AwesomeSnackbarContent(
                      title: AppLocalizations.of(context)!.success,
                      message: AppLocalizations.of(context)!.cartCleared,
                      contentType: ContentType.success,
                    ),
                  ),
                );
              } else if (state is ClearCartError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    elevation: 0,
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.transparent,
                    content: AwesomeSnackbarContent(
                      title: AppLocalizations.of(context)!.error,
                      message: state.message,
                      contentType: ContentType.warning,
                    ),
                  ),
                );
              }
            },
          ),
          BlocListener<CreateProductOrderFromCartBloc,
              CreateProductOrderFromCartState>(
            listener: (context, state) {
              if (state is CreateProductOrderFromCartSuccess) {
                final productOrderId = state.response.productOrder?.id;
                if (productOrderId != null) {
                  context
                      .push(
                          '${AppRouteConstants.MySingleProductOrderPagePath}$productOrderId')
                      .then((_) {
                    // Reload cart when returning from order page
                    context
                        .read<MyCartBloc>()
                        .add(const LoadMyCart(checkCartItems: true));
                  });
                }
              } else if (state is CreateProductOrderFromCartError) {
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
          ),
        ],
        child: BlocBuilder<MyCartBloc, MyCartState>(
          builder: (context, state) {
            if (state is MyCartLoading) {
              return const Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              );
            }

            if (state is MyCartError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline,
                        size: 64.sp, color: AppColors.error),
                    SizedBox(height: 16.h),
                    Text(
                      state.message,
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: AppColors.textSecondary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 24.h),
                    ElevatedButton(
                      onPressed: () => context
                          .read<MyCartBloc>()
                          .add(const LoadMyCart(checkCartItems: true)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        padding: EdgeInsets.symmetric(
                            horizontal: 32.w, vertical: 12.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      child: Text(
                        AppLocalizations.of(context)!.repeat,
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }

            if (state is MyCartLoaded) {
              final cartItems = state.response.cartItems ?? [];

              if (cartItems.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.shopping_cart_outlined,
                          size: 80.sp, color: AppColors.grey400),
                      SizedBox(height: 24.h),
                      Text(
                        AppLocalizations.of(context)!.cartEmpty,
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        AppLocalizations.of(context)!.addItemsToCheckout,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.textSecondary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              }

              return Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      padding: EdgeInsets.all(16.w),
                      itemCount: cartItems.length,
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 12.h),
                      itemBuilder: (context, index) {
                        final item = cartItems[index];
                        return _CartItemCard(
                          item: item,
                          onUpdateQty: (qty) {
                            context.read<UpdateCartItemBloc>().add(
                                  UpdateCartItemRequested(
                                    UpdateOrRemoveFromCartParameter(
                                      productId: item.productId,
                                      variantId: item.variantId,
                                      updatedQty: qty,
                                      removeCompletely: false,
                                    ),
                                  ),
                                );
                          },
                          onRemove: () {
                            context.read<UpdateCartItemBloc>().add(
                                  UpdateCartItemRequested(
                                    UpdateOrRemoveFromCartParameter(
                                      productId: item.productId,
                                      variantId: item.variantId,
                                      removeCompletely: true,
                                    ),
                                  ),
                                );
                          },
                        );
                      },
                    ),
                  ),
                  _CartBottomBar(totalPrice: state.response.totalPrice),
                ],
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  void _showClearCartDialog(BuildContext context, MyCartLoaded state) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Text(
          AppLocalizations.of(context)!.clearCartQuestion,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Text(
          AppLocalizations.of(context)!.allItemsWillBeRemoved,
          style: TextStyle(
            fontSize: 14.sp,
            color: AppColors.textSecondary,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(
              AppLocalizations.of(context)!.cancel,
              style: TextStyle(
                fontSize: 16.sp,
                color: AppColors.textSecondary,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              final cartId = state.response.cart?.id;
              if (cartId != null) {
                context.read<ClearCartBloc>().add(ClearCartRequested(cartId));
              }
            },
            child: Text(
              AppLocalizations.of(context)!.clear,
              style: TextStyle(
                fontSize: 16.sp,
                color: AppColors.error,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CartItemCard extends StatelessWidget {
  final CartItemEntity item;
  final ValueChanged<int> onUpdateQty;
  final VoidCallback onRemove;

  const _CartItemCard({
    required this.item,
    required this.onUpdateQty,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final product = item.product;
    final variant = item.variant;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: 8,
            offset: Offset(0, 2.h),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Container(
                width: 80.w,
                height: 80.w,
                color: AppColors.grey100,
                child: product?.image != null
                    ? Image.network(
                        ApiConstant.GetImageUrl(product?.image!.filePath ?? ''),
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Icon(
                            Icons.image,
                            size: 32.sp,
                            color: AppColors.grey400),
                      )
                    : Icon(Icons.image, size: 32.sp, color: AppColors.grey400),
              ),
            ),
            SizedBox(width: 12.w),
            // Product Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          product?.localizedTitle(context) ??
                              AppLocalizations.of(context)!.product,
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      InkWell(
                        onTap: onRemove,
                        borderRadius: BorderRadius.circular(8.r),
                        child: Container(
                          padding: EdgeInsets.all(6.w),
                          child: Icon(
                            Icons.delete_outline,
                            size: 18.sp,
                            color: AppColors.error,
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (variant != null) ...[
                    SizedBox(height: 4.h),
                    Text(
                      variant.localizedTitle(context) ?? '',
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                  if (item.sku != null) ...[
                    SizedBox(height: 2.h),
                    Text(
                      'SKU: ${item.sku}',
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              PriceFormatter.formatWithCurrency(item.unitPrice, '₸'),
                              style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w700,
                                color: AppColors.primary,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              'Итого: ${PriceFormatter.format(item.totalPrice)} ₸',
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      _CompactInputQty(
                        maxVal: 99,
                        initVal: item.qty,
                        minVal: 1,
                        onQtyChanged: onUpdateQty,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CartBottomBar extends StatelessWidget {
  final double totalPrice;

  const _CartBottomBar({required this.totalPrice});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowDark,
            blurRadius: 16,
            offset: Offset(0, -4.h),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.totalToPay,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textSecondary,
                  ),
                ),
                Text(
                  PriceFormatter.formatWithCurrency(totalPrice, '₸'),
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            BlocBuilder<CreateProductOrderFromCartBloc,
                CreateProductOrderFromCartState>(
              builder: (context, state) {
                final isLoading = state is CreateProductOrderFromCartLoading;
                return SizedBox(
                  width: double.infinity,
                  height: 52.h,
                  child: ElevatedButton(
                    onPressed: isLoading
                        ? null
                        : () {
                            context
                                .read<CreateProductOrderFromCartBloc>()
                                .add(const CreateOrderFromCart());
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      disabledBackgroundColor: AppColors.grey300,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      elevation: 0,
                    ),
                    child: isLoading
                        ? SizedBox(
                            width: 24.w,
                            height: 24.w,
                            child: const CircularProgressIndicator(
                              color: AppColors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : Text(
                            AppLocalizations.of(context)!.proceedToPayment,
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.white,
                            ),
                          ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _CompactInputQty extends StatefulWidget {
  final int maxVal;
  final int initVal;
  final int minVal;
  final ValueChanged<int> onQtyChanged;

  const _CompactInputQty({
    required this.maxVal,
    required this.initVal,
    required this.minVal,
    required this.onQtyChanged,
  });

  @override
  State<_CompactInputQty> createState() => _CompactInputQtyState();
}

class _CompactInputQtyState extends State<_CompactInputQty> {
  late int _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.initVal.clamp(widget.minVal, widget.maxVal);
  }

  @override
  void didUpdateWidget(_CompactInputQty oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initVal != widget.initVal) {
      _currentValue = widget.initVal.clamp(widget.minVal, widget.maxVal);
    }
  }

  void _increment() {
    if (_currentValue + 1 <= widget.maxVal) {
      setState(() {
        _currentValue += 1;
      });
      widget.onQtyChanged(_currentValue);
    }
  }

  void _decrement() {
    if (_currentValue - 1 >= widget.minVal) {
      setState(() {
        _currentValue -= 1;
      });
      widget.onQtyChanged(_currentValue);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildButton(
            icon: Icons.remove,
            onPressed: _currentValue > widget.minVal ? _decrement : null,
          ),
          SizedBox(width: 8.w),
          Container(
            constraints: BoxConstraints(minWidth: 24.w),
            child: Text(
              _currentValue.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          SizedBox(width: 8.w),
          _buildButton(
            icon: Icons.add,
            onPressed: _currentValue < widget.maxVal ? _increment : null,
          ),
        ],
      ),
    );
  }

  Widget _buildButton({
    required IconData icon,
    required VoidCallback? onPressed,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(6.r),
        child: Container(
          width: 24.w,
          height: 24.w,
          decoration: BoxDecoration(
            color: onPressed != null
                ? AppColors.primary.withOpacity(0.1)
                : AppColors.grey200,
            borderRadius: BorderRadius.circular(6.r),
          ),
          child: Icon(
            icon,
            size: 16.sp,
            color: onPressed != null ? AppColors.primary : AppColors.grey400,
          ),
        ),
      ),
    );
  }
}
