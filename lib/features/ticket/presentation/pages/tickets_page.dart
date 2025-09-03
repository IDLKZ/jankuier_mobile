import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:intl/intl.dart';
import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../shared/widgets/common_app_bars/pages_common_app_bar.dart';
import '../../../../shared/widgets/main_title_widget.dart';
import '../../../matches/presentation/widgets/qr_display_dialog.dart';

class TicketsPage extends StatelessWidget {
  const TicketsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: PagesCommonAppBar(
        title: "Билеты",
        actionIcon: Iconsax.ticket_discount_copy,
        onActionTap: () {},
      ),
      body: FutureBuilder<List<Ticket>>(
        future: TicketRepository().getActiveTickets(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Ошибка: ${snapshot.error}'),
            );
          }

          final tickets = snapshot.data ?? [];

          if (tickets.isEmpty) {
            return const Center(
              child: Text('Активные билеты отсутствуют'),
            );
          }

          return SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 5.h,
                    horizontal: 15.w,
                  ),
                  child: MainTitleWidget(title: "Билеты на матчи"),
                ),
                Padding(
                  padding: EdgeInsets.all(16.w),
                  child: DynamicHeightGridView(
                      itemCount: tickets.length,
                      crossAxisCount: 2,
                      crossAxisSpacing: 12.w,
                      mainAxisSpacing: 16.h,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      builder: (ctx, index) {
                        final ticket = tickets[index];
                        return TicketCard(ticket: ticket);
                      }),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class TicketCard extends StatelessWidget {
  final Ticket ticket;

  const TicketCard({super.key, required this.ticket});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dateFormatter = DateFormat('d MMMM yyyy, HH:mm', 'ru');

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            offset: Offset(0, 2),
            blurRadius: 8,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
                child: Image.asset(
                  ticket.image,
                  width: double.infinity,
                  height: 160.h,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: double.infinity,
                      height: 120.h,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            AppColors.primary.withOpacity(0.1),
                            AppColors.primary.withOpacity(0.2),
                          ],
                        ),
                      ),
                      child: Icon(
                        Iconsax.ticket_discount_copy,
                        color: AppColors.primary.withOpacity(0.5),
                        size: 48.sp,
                      ),
                    );
                  },
                ),
              ),
              Positioned(
                top: 8.h,
                right: 8.w,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text(
                    ticket.genre.toUpperCase(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 8.h,
                left: 8.w,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: AppColors.success.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text(
                    ticket.status,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(12.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ticket.title,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                    height: 1.2,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 6.h),
                Text(
                  ticket.subtitle,
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textSecondary,
                    height: 1.3,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Icon(
                      Iconsax.location_copy,
                      size: 10.sp,
                      color: AppColors.textSecondary,
                    ),
                    SizedBox(width: 3.w),
                    Expanded(
                      child: Text(
                        ticket.place,
                        style: TextStyle(
                          fontSize: 9.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textSecondary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    Icon(
                      Iconsax.clock_copy,
                      size: 10.sp,
                      color: AppColors.primary,
                    ),
                    SizedBox(width: 3.w),
                    Flexible(
                      child: Text(
                        dateFormatter.format(ticket.datetime),
                        style: TextStyle(
                          fontSize: 9.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => _showQRCode(context, ticket),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 6.h),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColors.primary.withOpacity(0.3),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Iconsax.scan_barcode_copy,
                                size: 14.sp,
                                color: AppColors.primary,
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                'QR',
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => _showDetails(context, ticket),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 6.h),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Iconsax.eye_copy,
                                size: 14.sp,
                                color: Colors.white,
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                'Детали',
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showQRCode(BuildContext context, Ticket ticket) {
    showModalBottomSheet<void>(
      useRootNavigator: true,
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 400,
          color: Colors.white,
          child: QrDisplayDialog(
            qrData: "https://example.com/your-ticket-id",
            onClose: () => Navigator.of(context).pop(),
          ),
        );
      },
    );
  }

  void _showDetails(BuildContext context, Ticket ticket) {
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
              Container(
                width: 40.w,
                height: 4.h,
                margin: EdgeInsets.only(top: 12.h),
                decoration: BoxDecoration(
                  color: AppColors.textSecondary.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16.r),
                        child: Image.asset(
                          ticket.image,
                          width: double.infinity,
                          height: 200.h,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              width: double.infinity,
                              height: 200.h,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    AppColors.primary.withOpacity(0.1),
                                    AppColors.primary.withOpacity(0.2),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(16.r),
                              ),
                              child: Icon(
                                Iconsax.ticket_discount_copy,
                                color: AppColors.primary.withOpacity(0.5),
                                size: 60.sp,
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12.w, vertical: 6.h),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(16.r),
                            ),
                            child: Text(
                              ticket.genre.toUpperCase(),
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12.w, vertical: 6.h),
                            decoration: BoxDecoration(
                              color: AppColors.success.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(16.r),
                            ),
                            child: Text(
                              ticket.status,
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.success,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        ticket.title,
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                          height: 1.3,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        ticket.subtitle,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textSecondary,
                          height: 1.4,
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Container(
                        padding: EdgeInsets.all(16.w),
                        decoration: BoxDecoration(
                          color: AppColors.background,
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                            color: AppColors.primary.withOpacity(0.1),
                            width: 1,
                          ),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(8.w),
                                  decoration: BoxDecoration(
                                    color: AppColors.primary.withOpacity(0.1),
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
                                        'Место проведения',
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.textSecondary,
                                        ),
                                      ),
                                      SizedBox(height: 2.h),
                                      Text(
                                        ticket.place,
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
                            SizedBox(height: 16.h),
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(8.w),
                                  decoration: BoxDecoration(
                                    color: AppColors.primary.withOpacity(0.1),
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
                                        'Дата и время',
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.textSecondary,
                                        ),
                                      ),
                                      SizedBox(height: 2.h),
                                      Text(
                                        dateFormatter.format(ticket.datetime),
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
                      Text(
                        'Описание',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        ticket.description,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textSecondary,
                          height: 1.5,
                        ),
                      ),
                      SizedBox(height: 30.h),
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                                _showQRCode(context, ticket);
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 14.h),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: AppColors.primary,
                                    width: 1.5,
                                  ),
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Iconsax.scan_barcode_copy,
                                      size: 18.sp,
                                      color: AppColors.primary,
                                    ),
                                    SizedBox(width: 6.w),
                                    Flexible(
                                      child: Text(
                                        'QR-код',
                                        style: TextStyle(
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.primary,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 14.h),
                                decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.close,
                                      size: 18.sp,
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: 6.w),
                                    Flexible(
                                      child: Text(
                                        'Закрыть',
                                        style: TextStyle(
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
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
        );
      },
    );
  }
}

class Ticket {
  final String id;
  final String title;
  final String subtitle;
  final String description;
  final String place;
  final DateTime datetime;
  final String genre;
  final String image;
  final String status;

  const Ticket({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.place,
    required this.datetime,
    required this.genre,
    required this.image,
    required this.status,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
      id: json['id'] as String,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String,
      description: json['description'] as String,
      place: json['place'] as String,
      datetime: DateTime.parse(json['datetime'] as String),
      genre: json['genre'] as String,
      image: json['image'] as String,
      status: json['status'] as String,
    );
  }
}

class TicketRepository {
  static const List<Map<String, dynamic>> _ticketsData = [
    {
      "id": "m1",
      "title": "Казахстан - Уэльс",
      "subtitle": "Отборочный матч Чемпионата мира-2026 в Астане!",
      "description":
          "4 сентября а 19:00 на стадионе «Астана Арена» сборная Казахстана по футболу примет гостей из Уэльса!\n\nКоманда Али Алиева жаждет взять реванш за обидное поражение в Кардиффе и порадовать родные трибуны победой!\n\nНе пропустите!",
      "place": "г. Астана, Астана Арена, Туран 48",
      "datetime": "2025-09-04 19:00",
      "genre": "футбол",
      "image": "assets/images/match_1.jpeg",
      "status": "Доступно"
    },
    {
      "id": "m2",
      "title": "Астана - Елимай",
      "subtitle": "Премьер-лига Казахстана",
      "description":
          "ФК Астана – ведущий клуб Казахстана, многократный чемпион страны и участник еврокубков, известный своей стабильностью и современным стилем игры.\nФК Елимай – легендарная команда из Семея, возрождённая после долгого перерыва, символ казахстанского футбольного наследия и преданности болельщиков.",
      "place": "г. Астана, Астана Арена",
      "datetime": "2025-09-14 19:00",
      "genre": "футбол",
      "image": "assets/images/match_2.png",
      "status": "Доступно"
    },
    {
      "id": "m3",
      "title": "ФК Атырау – ФК Тобол",
      "subtitle": "Премьер-лига Казахстана",
      "description":
          "ФК Атырау – клуб с богатой историей, известный своей боевитостью и преданной поддержкой местных болельщиков, особенно на домашнем стадионе у берегов Каспия.\nФК Тобол – один из сильнейших клубов Казахстана, чемпион страны, регулярно борющийся за лидирующие позиции и участие в еврокубках.",
      "place": "г. Атырау, Стадион имени Мунайшы",
      "datetime": "2025-09-13 19:00",
      "genre": "футбол",
      "image": "assets/images/match_3.png",
      "status": "Доступно"
    },
    {
      "id": "m4",
      "title": "Ордабасы – Женис",
      "subtitle": "Премьер-лига Казахстана",
      "description":
          "ФК Ордабасы – клуб из Шымкента, стабильно выступающий в Премьер-лиге Казахстана, славится сильной поддержкой болельщиков и упорным характером на поле.\nФК Женис – команда из Астаны с богатым прошлым, возрождённая в последние годы и стремящаяся вернуть себе статус одного из лидеров казахстанского футбола.",
      "place": "г. Шымкент, Стадион имени Кажымукана М.",
      "datetime": "2025-09-13 19:00",
      "genre": "футбол",
      "image": "assets/images/match_4.png",
      "status": "Доступно"
    }
  ];

  Future<List<Ticket>> getActiveTickets() async {
    await Future.delayed(const Duration(milliseconds: 500));

    return _ticketsData
        .where((data) => data['status'] == 'Доступно')
        .map((data) => Ticket.fromJson(data))
        .toList();
  }
}
