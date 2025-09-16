import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class TicketWebViewPage extends StatefulWidget {
  final String showId;

  const TicketWebViewPage({
    super.key,
    required this.showId,
  });

  @override
  State<TicketWebViewPage> createState() => _TicketWebViewPageState();
}

class _TicketWebViewPageState extends State<TicketWebViewPage> {
  InAppWebViewController? webViewController;
  double progress = 0;
  bool isLoading = true;
  String? errorMessage;
  late String initialUrl;

  @override
  void initState() {
    super.initState();
    initialUrl = 'https://jankuier.kz/web-frame-ticket/get-show/${widget.showId}';
    _initializeWebView();
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
        title: const Text('Купить билеты'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              webViewController?.reload();
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          InAppWebView(
            initialUrlRequest: URLRequest(url: WebUri(initialUrl)),
            initialSettings: InAppWebViewSettings(
              useShouldOverrideUrlLoading: true,
              mediaPlaybackRequiresUserGesture: false,
              allowsInlineMediaPlayback: true,
              iframeAllow: "camera; microphone",
              iframeAllowFullscreen: true,
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
              // Дополнительные настройки для лучшего UX
              allowsBackForwardNavigationGestures: true,
              clearCache: false,
              javaScriptEnabled: true,
              domStorageEnabled: true,
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
              sharedCookiesEnabled: true,
              // Принудительно включить мультитач
              allowFileAccessFromFileURLs: false,
              allowUniversalAccessFromFileURLs: false,
              // Настройки для лучшего zoom handling
              forceDark: ForceDark.OFF,
              hardwareAcceleration: true,
              // Дополнительные Android-специфичные настройки для эмулятора
              scrollsToTop: false,
            ),
            onWebViewCreated: (controller) {
              webViewController = controller;
            },
            onLoadStart: (controller, url) {
              setState(() {
                isLoading = true;
                errorMessage = null;
              });
            },
            onLoadStop: (controller, url) async {
              setState(() {
                isLoading = false;
              });

              // Добавить JavaScript для агрессивной поддержки touch и zoom в эмуляторе
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
                  button {
                    touch-action: manipulation !important;
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

                // Добавляем обработчик для gesturestart/gesturechange (iOS/Android)
                if (typeof document.ontouchstart !== 'undefined') {
                  document.addEventListener('gesturestart', function(e) {
                    e.preventDefault();
                  });

                  document.addEventListener('gesturechange', function(e) {
                    e.preventDefault();
                  });

                  document.addEventListener('gestureend', function(e) {
                    e.preventDefault();
                  });
                }

                // Принудительно включаем zoom для всех элементов
                document.documentElement.style.zoom = 'normal';
                document.body.style.zoom = 'normal';

                console.log('Aggressive touch and zoom support for Android emulator initialized');
                console.log('User agent:', navigator.userAgent);
                console.log('Touch support:', 'ontouchstart' in window);
                console.log('Pointer support:', 'onpointerdown' in window);
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
                errorMessage = 'Ошибка загрузки: ${error.description}';
              });
            },
            onReceivedHttpError: (controller, request, errorResponse) {
              setState(() {
                isLoading = false;
                errorMessage = 'HTTP ошибка ${errorResponse.statusCode}: ${errorResponse.reasonPhrase}';
              });
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
                      'Загрузка...',
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
                      child: const Text('Попробовать снова'),
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