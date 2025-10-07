import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../../../../core/constants/api_constants.dart';
import '../../../../l10n/app_localizations.dart';

class PrivacyWebViewPage extends StatefulWidget {
  final String type;

  const PrivacyWebViewPage({
    super.key,
    required this.type
  });

  @override
  State<PrivacyWebViewPage> createState() => _PrivacyWebViewPageState();
}

class _PrivacyWebViewPageState extends State<PrivacyWebViewPage> {
  InAppWebViewController? webViewController;
  double progress = 0;
  bool isLoading = true;
  String? errorMessage;
  late String initialUrl;
  late String title;

  @override
  void initState() {
    super.initState();
    if (widget.type == 'privacy') {
      initialUrl = ApiConstant.WebFrameGetPrivacyURL;
    } else if (widget.type == 'public') {
      initialUrl = ApiConstant.WebFrameGetPublicURL;
    } else {
      initialUrl = ApiConstant.WebFrameGetPublicMobileURL;
    }
    _initializeWebView();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.type == 'privacy') {
      title = AppLocalizations.of(context)!.privacyTitle;
    } else if (widget.type == 'public') {
      title = AppLocalizations.of(context)!.publicTitle;
    } else {
      title = AppLocalizations.of(context)!.publicMobileTitle;
    }
  }

  Future<void> _initializeWebView() async {
    if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
      await InAppWebViewController.setWebContentsDebuggingEnabled(kDebugMode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Stack(
        children: [
          InAppWebView(
            initialUrlRequest: URLRequest(url: WebUri(initialUrl)),
            onWebViewCreated: (controller) {
              webViewController = controller;
            },
            shouldOverrideUrlLoading: (controller, navigationAction) async {
              final uri = navigationAction.request.url;

              if (uri != null) {
                print('🔄 Navigation request: ${uri.toString()}');
                print('📋 Navigation type: ${navigationAction.navigationType}');
                print('🎯 Is main frame: ${navigationAction.isForMainFrame}');

                // Разрешаем все навигации для правильной работы редиректов
                // Особенно важно для платежных систем
                return NavigationActionPolicy.ALLOW;
              }

              return NavigationActionPolicy.ALLOW;
            },
            onLoadStart: (controller, url) {
              setState(() {
                isLoading = true;
                errorMessage = null;
              });
              print('🚀 Loading started: ${url?.toString()}');
            },
            onUpdateVisitedHistory: (controller, url, androidIsReload) {
              print('📍 Visited: ${url?.toString()} (reload: $androidIsReload)');
            },
            onLoadStop: (controller, url) async {
              print('✅ Loading finished: ${url?.toString()}');
              setState(() {
                isLoading = false;
              });

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
                style.innerHTML = `
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
`;
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
            onProgressChanged: (controller, progress) {
              setState(() {
                this.progress = progress / 100;
              });
            },
            onReceivedError: (controller, request, error) {
              setState(() {
                isLoading = false;
                errorMessage = '${AppLocalizations.of(context)!.loadingError}: ${error.description}';
              });
            },
            onReceivedHttpError: (controller, request, errorResponse) {
              print('HTTP Error: ${errorResponse.statusCode} - ${errorResponse.reasonPhrase}');
              print('Failed URL: ${request.url}');

              // Игнорируем 404 ошибки для ресурсов (CSS, JS, изображения)
              final url = request.url?.toString() ?? '';
              final isResource = url.contains('.css') ||
                  url.contains('.js') ||
                  url.contains('.svg') ||
                  url.contains('.png') ||
                  url.contains('.jpg') ||
                  url.contains('.ico');

              // Игнорируем 404 ошибки для ресурсов и 400 ошибки (пусть сайт сам обрабатывает)
              if ((isResource && errorResponse.statusCode == 404) ||
                  errorResponse.statusCode == 400) {
                return; // Не показываем ошибку
              }

              // Показываем ошибку только для критических случаев
              setState(() {
                isLoading = false;
                errorMessage = '${AppLocalizations.of(context)!.httpError} ${errorResponse.statusCode}: ${errorResponse.reasonPhrase}';
              });
            },
            onConsoleMessage: (controller, consoleMessage) {
              print('Console ${consoleMessage.messageLevel}: ${consoleMessage.message}');
            },
          ),
          if (isLoading)
            Container(
              color: Colors.white,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircularProgressIndicator(),
                    SizedBox(height: 16.h),
                    Text(
                      AppLocalizations.of(context)!.loading,
                      style: TextStyle(fontSize: 16.sp),
                    ),
                    if (progress > 0)
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 8.h),
                        child: LinearProgressIndicator(value: progress),
                      ),
                  ],
                ),
              ),
            ),
          if (!isLoading && errorMessage != null)
            Container(
              color: Colors.white,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 64.sp,
                      color: Colors.red,
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      errorMessage!,
                      style: TextStyle(fontSize: 16.sp),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16.h),
                    ElevatedButton(
                      onPressed: () {
                        webViewController?.reload();
                      },
                      child: Text(AppLocalizations.of(context)!.tryAgain),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}