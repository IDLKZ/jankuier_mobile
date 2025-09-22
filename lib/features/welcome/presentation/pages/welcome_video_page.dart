import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:video_player/video_player.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_route_constants.dart';

class WelcomeVideoPage extends StatefulWidget {
  const WelcomeVideoPage({super.key});

  @override
  State<WelcomeVideoPage> createState() => _WelcomeVideoPageState();
}

class _WelcomeVideoPageState extends State<WelcomeVideoPage> {
  late VideoPlayerController _controller;
  bool _isPlaying = false;
  bool _isVideoEnded = false;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    try {
      _controller = VideoPlayerController.asset('assets/animations/welcome_kff.mp4');
      await _controller.initialize();

      // Добавляем слушатель для отслеживания окончания видео
      _controller.addListener(() {
        if (_controller.value.position >= _controller.value.duration) {
          if (!_isVideoEnded) {
            setState(() {
              _isVideoEnded = true;
            });
            // Автоматически переходим на главную страницу через 1 секунду после окончания видео
            Future.delayed(const Duration(seconds: 1), () {
              if (mounted) {
                _navigateToHome();
              }
            });
          }
        }
      });

      setState(() {
        _isPlaying = true;
      });

      // Автоматически запускаем видео
      _controller.play();
    } catch (e) {
      // Если видео не удалось загрузить, сразу переходим на главную страницу
      _navigateToHome();
    }
  }

  void _navigateToHome() {
    context.go(AppRouteConstants.HomePagePath);
  }

  void _skipVideo() {
    _controller.pause();
    _navigateToHome();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: () {
          // Touch skip - нажатие на экран пропускает видео
          if (_isPlaying && !_isVideoEnded) {
            _skipVideo();
          }
        },
        child: Stack(
          children: [
            // Видео плеер
            if (_controller.value.isInitialized)
              Center(
                child: AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                ),
              )
            else
              // Загрузка или ошибка - показываем лого
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Можно добавить логотип приложения
                    Icon(
                      Icons.sports_soccer,
                      size: 80.sp,
                      color: Colors.white,
                    ),
                    SizedBox(height: 20.h),
                    CircularProgressIndicator(
                      color: AppColors.primary,
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      'Jankuier',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ],
                ),
              ),

            // Текстовая подсказка внизу экрана
            if (_isPlaying && !_isVideoEnded)
              Positioned(
                bottom: 40.h,
                left: 20.w,
                right: 20.w,
                child: SafeArea(
                  child: Text(
                    'Коснитесь экрана, чтобы пропустить',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.4),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w300,
                      fontFamily: 'Inter',
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),

          ],
        ),
      ),
    );
  }
}