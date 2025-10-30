import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:intl/intl.dart';
import 'package:jankuier_mobile/core/constants/api_constants.dart';
import 'package:jankuier_mobile/core/constants/app_route_constants.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/utils/file_utils.dart';
import '../../../../core/utils/hive_utils.dart';
import '../../data/entities/yandex_afisha_ticket/yandex_afisha_ticket_entity.dart';
import '../pages/ticket_webview_page.dart';

class YandexAfishaTicketCard extends StatelessWidget {
  final YandexAfishaWidgetTicketEntity ticket;

  const YandexAfishaTicketCard({
    super.key,
    required this.ticket,
  });

  @override
  Widget build(BuildContext context) {
    final dateFormatter = DateFormat('d MMMM yyyy, HH:mm', 'ru');

    Future<String?> _getAccessToken() async {
      final hiveUtils = getIt<HiveUtils>();
      final accessToken = await hiveUtils.getAccessToken();
      return accessToken;
    }

    return GestureDetector(
      onTap: () => _showDetailsBottomSheet(context, _getAccessToken),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Левая часть - изображение
            SizedBox(
              width: 100.w,
              height: 120.h,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8.r),
                      bottomLeft: Radius.circular(8.r),
                    ),
                    child: ticket.image?.filePath != null
                        ? Image.network(
                            ApiConstant.GetImageUrl(ticket.image!.filePath),
                            width: 120.w,
                            height: 140.h,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                FileUtils.LocalProductImage,
                                width: 120.w,
                                height: 140.h,
                                fit: BoxFit.cover,
                              );
                            },
                          )
                        : Image.asset(
                            FileUtils.LocalProductImage,
                            width: 120.w,
                            height: 140.h,
                            fit: BoxFit.cover,
                          ),
                  ),

                  // Градиент оверлей для лучшей читаемости текста
                  Container(
                    width: 120.w,
                    height: 140.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.r),
                        bottomLeft: Radius.circular(20.r),
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withValues(alpha: 0.3),
                        ],
                      ),
                    ),
                  ),

                  // Статус активности
                  if (ticket.isActive)
                    Positioned(
                      bottom: 12.h,
                      left: 8.w,
                      right: 8.w,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: AppColors.success.withValues(alpha: 0.9),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Text(
                          AppLocalizations.of(context)!.active,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                ],
              ),
            ),

            // Правая часть - содержимое
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(8.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Название события
                    Text(
                      ticket.localizedTitle(context),
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                        height: 1.2,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    SizedBox(height: 8.h),

                    // Описание
                    if (ticket.localizedDescription(context) != "-") ...[
                      Text(
                        ticket.localizedDescription(context),
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textSecondary,
                          height: 1.4,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 12.h),
                    ],

                    // Информация о месте и времени
                    Row(
                      children: [
                        // Иконка места
                        Container(
                          padding: EdgeInsets.all(6.w),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Icon(
                            Iconsax.location_copy,
                            size: 12.sp,
                            color: AppColors.primary,
                          ),
                        ),
                        SizedBox(width: 8.w),

                        // Место
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                ticket.localizedStadium(context),
                                style: TextStyle(
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textPrimary,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 2.h),
                              if (ticket.startAt != null)
                                Text(
                                  dateFormatter
                                      .format(ticket.startAt!.toLocal()),
                                  style: TextStyle(
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.textSecondary,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showBottomUrl(BuildContext context, String url) {
    showModalBottomSheet<void>(
      useRootNavigator: true,
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      isDismissible: false, // Запрещаем закрытие свайпом вниз
      enableDrag: false, // Запрещаем перетаскивание
      builder: (BuildContext context) {
        return SafeArea(
          child: Container(
            height:
                MediaQuery.of(context).size.height * 0.85, // 85% высоты экрана
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
            ),
            child: Column(
              children: [
                // Header with close button
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20.r)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        offset: const Offset(0, 2),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(width: 40.w), // Balance
                      Text(
                        AppLocalizations.of(context)!.buyTickets,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      // Close button
                      IconButton(
                        icon: Icon(Icons.close,
                            size: 24.sp, color: AppColors.textPrimary),
                        onPressed: () => Navigator.of(context).pop(),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                ),
                // WebView with scroll
                Expanded(
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.75,
                      child: InAppWebView(
                        initialUrlRequest: URLRequest(url: WebUri(url)),
                        initialSettings: InAppWebViewSettings(
                          // КРИТИЧНЫЕ настройки для редиректов
                          useShouldOverrideUrlLoading: true,
                          javaScriptEnabled: true,
                          domStorageEnabled: true,
                          thirdPartyCookiesEnabled: true,
                          sharedCookiesEnabled: true,

                          // Настройки User Agent для совместимости
                          userAgent:
                              "Mozilla/5.0 (Linux; Android 10; Mobile) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.120 Mobile Safari/537.36",

                          // Настройки безопасности для редиректов
                          allowsInlineMediaPlayback: true,
                          mediaPlaybackRequiresUserGesture: false,
                          mixedContentMode:
                              MixedContentMode.MIXED_CONTENT_ALWAYS_ALLOW,

                          // Настройки навигации
                          allowsBackForwardNavigationGestures: true,
                          clearCache: false,
                          cacheEnabled: true,

                          // Настройки для внешних ссылок
                          allowFileAccessFromFileURLs: true,
                          allowUniversalAccessFromFileURLs: true,

                          // КРИТИЧНЫЕ настройки зума для эмулятора Android
                          supportZoom: true,
                          builtInZoomControls: true,
                          displayZoomControls: false,
                          useWideViewPort: true,
                          loadWithOverviewMode: true,

                          // Настройки zoom scale для правильной работы pinch-to-zoom
                          minimumZoomScale: 0.1,
                          maximumZoomScale: 10.0,
                          pageZoom: 1.0,

                          // Включить горизонтальную прокрутку
                          horizontalScrollBarEnabled: true,
                          verticalScrollBarEnabled: true,

                          // Улучшить отзывчивость касаний
                          disableHorizontalScroll: false,
                          disableVerticalScroll: false,

                          // Android-специфичные настройки для зума и панорамирования
                          minimumLogicalFontSize: 8,
                          initialScale: 100,
                          textZoom: 100,

                          // Важные настройки для сенсорного управления
                          useOnDownloadStart: false,
                          useOnLoadResource: false,

                          // Дополнительная настройка viewport
                          layoutAlgorithm: LayoutAlgorithm.NORMAL,

                          // Улучшенные настройки для touch управления
                          allowsLinkPreview: false,
                          allowsPictureInPictureMediaPlayback: true,
                          automaticallyAdjustsScrollIndicatorInsets: false,

                          // Настройки для лучшего zoom handling
                          forceDark: ForceDark.OFF,
                          hardwareAcceleration: true,

                          // Дополнительные Android-специфичные настройки для эмулятора
                          scrollsToTop: false,

                          // Настройки iframe для платежных систем
                          iframeAllow:
                              "camera; microphone; payment; geolocation",
                          iframeAllowFullscreen: true,
                        ),
                        shouldOverrideUrlLoading:
                            (controller, navigationAction) async {
                          final uri = navigationAction.request.url;

                          if (uri != null) {
                            print('🔄 Navigation request: ${uri.toString()}');
                            print(
                                '📋 Navigation type: ${navigationAction.navigationType}');
                            print(
                                '🎯 Is main frame: ${navigationAction.isForMainFrame}');

                            // Разрешаем все навигации для правильной работы редиректов
                            // Особенно важно для платежных систем
                            return NavigationActionPolicy.ALLOW;
                          }

                          return NavigationActionPolicy.ALLOW;
                        },
                        onLoadStart: (controller, url) {
                          print('🚀 Loading started: ${url?.toString()}');
                        },
                        onUpdateVisitedHistory:
                            (controller, url, androidIsReload) {
                          print(
                              '📍 Visited: ${url?.toString()} (reload: $androidIsReload)');
                        },
                        onLoadStop: (controller, url) async {
                          print('✅ Loading finished: ${url?.toString()}');

                          // Настройка для поддержки редиректов и touch событий
                          await controller.evaluateJavascript(source: """
                        // Принудительно настраиваем viewport для максимальной поддержки зума
                        var metaTag = document.querySelector('meta[name="viewport"]');
                        if (metaTag) {
                          metaTag.setAttribute('content', 'width=device-width, initial-scale=1.0, maximum-scale=10.0, minimum-scale=0.1, user-scalable=yes, shrink-to-fit=no, viewport-fit=cover');
                        } else {
                          var meta = document.createElement('meta');
                          meta.name = 'viewport';
                          meta.content = 'width=device-width, initial-scale=1.0, maximum-scale=10.0, minimum-scale=0.1, user-scalable=yes, shrink-to-fit=no, viewport-fit=cover';
                          document.getElementsByTagName('head')[0].appendChild(meta);
                        }

                        // Обеспечиваем правильную работу форм и ссылок для редиректов
                        document.addEventListener('click', function(e) {
                          var target = e.target;

                          // Разрешаем клики по ссылкам и кнопкам
                          if (target.tagName === 'A' || target.tagName === 'BUTTON' || target.type === 'submit') {
                            // Не блокируем навигацию
                            return true;
                          }
                        }, false);

                        // Разрешаем отправку форм
                        document.addEventListener('submit', function(e) {
                          // Не блокируем отправку форм
                          return true;
                        }, false);

                        // Агрессивная настройка CSS для touch событий
                        var style = document.createElement('style');
                        style.innerHTML = \`
                          html, body {
                            touch-action: pan-x pan-y pinch-zoom !important;
                            -webkit-user-select: none !important;
                            -webkit-touch-callout: none !important;
                            overflow: auto !important;
                          }
                          * {
                            touch-action: pan-x pan-y pinch-zoom !important;
                            -webkit-user-select: none !important;
                            -webkit-touch-callout: none !important;
                          }
                          img, canvas, svg, .map-container {
                            touch-action: pan-x pan-y pinch-zoom !important;
                            user-select: none !important;
                            -webkit-user-drag: none !important;
                            pointer-events: auto !important;
                          }
                          button, a, input[type="submit"], input[type="button"] {
                            touch-action: manipulation !important;
                            pointer-events: auto !important;
                            cursor: pointer !important;
                          }
                          form {
                            pointer-events: auto !important;
                          }
                        \`;
                        document.head.appendChild(style);

                        // Принудительно включаем все touch события
                        var touchEvents = ['touchstart', 'touchmove', 'touchend', 'touchcancel'];
                        touchEvents.forEach(function(eventType) {
                          document.addEventListener(eventType, function(e) {
                            // Не блокируем события, позволяем браузеру обрабатывать их нативно
                          }, {
                            passive: true,
                            capture: false
                          });
                        });

                        // Дополнительная настройка для Android эмулятора
                        if (navigator.userAgent.includes('Android')) {
                          // Принудительно включаем все pointer events
                          var pointerEvents = ['pointerdown', 'pointermove', 'pointerup', 'pointercancel'];
                          pointerEvents.forEach(function(eventType) {
                            document.addEventListener(eventType, function(e) {
                              // Позволяем нативную обработку
                            }, { passive: true });
                          });

                          // Включаем wheel события для zoom через scroll
                          document.addEventListener('wheel', function(e) {
                            if (e.ctrlKey) {
                              // Позволяем zoom через Ctrl+wheel
                            }
                          }, { passive: true });
                        }

                        // Принудительно включаем zoom для всех элементов
                        document.documentElement.style.zoom = 'normal';
                        document.body.style.zoom = 'normal';

                        console.log('Enhanced WebView support initialized for redirects and touch');
                        console.log('User agent:', navigator.userAgent);
                        console.log('Touch support:', 'ontouchstart' in window);
                        console.log('Pointer support:', 'onpointerdown' in window);
                        console.log('Current URL:', window.location.href);
                      """);
                        },
                        onReceivedError: (controller, request, error) {
                          print('❌ Error: ${error.description}');
                        },
                        onReceivedHttpError:
                            (controller, request, errorResponse) {
                          print(
                              'HTTP Error: ${errorResponse.statusCode} - ${errorResponse.reasonPhrase}');
                          print('Failed URL: ${request.url}');
                        },
                        onConsoleMessage: (controller, consoleMessage) {
                          print(
                              'Console ${consoleMessage.messageLevel}: ${consoleMessage.message}');
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showDetailsBottomSheet(
      BuildContext context, Future<String?> Function() getAccessToken) {
    final dateFormatter = DateFormat('d MMMM yyyy, HH:mm', 'ru');

    showModalBottomSheet<void>(
      useRootNavigator: true,
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.8,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
          ),
          child: Column(
            children: [
              // Хэндл
              Container(
                width: 40.w,
                height: 4.h,
                margin: EdgeInsets.only(top: 12.h),
                decoration: BoxDecoration(
                  color: AppColors.textSecondary.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),

              // Содержимое
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Изображение
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16.r),
                        child: ticket.image?.filePath != null
                            ? Image.network(
                                ApiConstant.GetImageUrl(ticket.image!.filePath),
                                width: double.infinity,
                                height: 200.h,
                                fit: BoxFit.fitHeight,
                              )
                            : Image.asset(
                                FileUtils.LocalProductImage,
                                width: double.infinity,
                                height: 200.h,
                                fit: BoxFit.cover,
                              ),
                      ),
                      SizedBox(height: 20.h),

                      // Статус активности
                      if (ticket.isActive)
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 12.w, vertical: 6.h),
                          decoration: BoxDecoration(
                            color: AppColors.success.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          child: Text(
                            AppLocalizations.of(context)!.active,
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.success,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      SizedBox(height: 16.h),

                      // Название
                      Text(
                        ticket.localizedTitle(context),
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.black,
                          height: 1.3,
                        ),
                      ),
                      SizedBox(height: 8.h),

                      // Описание
                      if (ticket.localizedDescription(context) != "-") ...[
                        Text(
                          ticket.localizedDescription(context),
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.textSecondary,
                            height: 1.5,
                          ),
                        ),
                        SizedBox(height: 20.h),
                      ],

                      // Информация о месте и времени
                      Container(
                        padding: EdgeInsets.all(16.w),
                        decoration: BoxDecoration(
                          color: AppColors.background,
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                            color: AppColors.primary.withValues(alpha: 0.1),
                            width: 1,
                          ),
                        ),
                        child: Column(
                          children: [
                            // Место
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(8.w),
                                  decoration: BoxDecoration(
                                    color: AppColors.primary
                                        .withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  child: Icon(
                                    Iconsax.location_copy,
                                    size: 20.sp,
                                    color: AppColors.primary,
                                  ),
                                ),
                                SizedBox(width: 12.w),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!.venue,
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.textSecondary,
                                        ),
                                      ),
                                      SizedBox(height: 2.h),
                                      Text(
                                        ticket.localizedStadium(context),
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.black,
                                        ),
                                      ),
                                      if (ticket.localizedAddress(context) !=
                                          "-")
                                        Text(
                                          ticket.localizedAddress(context),
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.textSecondary,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 16.h),

                            // Время
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(8.w),
                                  decoration: BoxDecoration(
                                    color: AppColors.primary
                                        .withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  child: Icon(
                                    Iconsax.clock_copy,
                                    size: 20.sp,
                                    color: AppColors.primary,
                                  ),
                                ),
                                SizedBox(width: 12.w),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!
                                            .dateAndTime,
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.textSecondary,
                                        ),
                                      ),
                                      SizedBox(height: 2.h),
                                      Text(
                                        ticket.startAt != null
                                            ? dateFormatter.format(
                                                ticket.startAt!.toLocal())
                                            : AppLocalizations.of(context)!
                                                .timeNotSpecified,
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.textPrimary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20.h),

                      // Кнопка покупки (если есть URL виджета Яндекс.Афиша)
                      if (ticket.yandexWidgetUrl != null &&
                          ticket.yandexWidgetUrl!.isNotEmpty)
                        SizedBox(
                          width: double.infinity,
                          child: GestureDetector(
                            onTap: () async {
                              // Проверка авторизации
                              final token = await getAccessToken();
                              if (token == null || token.isEmpty) {
                                // Закрываем текущий bottom sheet
                                Navigator.of(context).pop();
                                // Переходим на страницу входа
                                context.go(AppRouteConstants.SignInPagePath);
                              } else {
                                // Открываем WebView с виджетом Яндекс.Афиша
                                Navigator.of(context).pop();
                                _showBottomUrl(
                                    context, ticket.yandexWidgetUrl!);
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 20.h),
                              decoration: BoxDecoration(
                                gradient: AppColors.primaryGradient,
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Iconsax.ticket_discount_copy,
                                    size: 18.sp,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 8.w),
                                  Text(
                                    AppLocalizations.of(context)!.buyTickets,
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      SizedBox(
                        height: 20.h,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
