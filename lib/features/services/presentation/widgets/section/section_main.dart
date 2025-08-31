import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:jankuier_mobile/features/services/domain/parameters/paginate_academy_parameter.dart';
import 'package:jankuier_mobile/features/services/domain/use_cases/academy/paginate_academy_case.dart';
import 'package:jankuier_mobile/features/services/presentation/bloc/academy/academy_bloc.dart';
import 'package:jankuier_mobile/features/services/presentation/bloc/academy/academy_event.dart';
import 'package:jankuier_mobile/features/services/presentation/bloc/academy/academy_state.dart';
import 'package:jankuier_mobile/shared/widgets/main_title_widget.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_route_constants.dart';
import '../../../../../core/di/injection.dart';
import '../section_card.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:jankuier_mobile/features/services/domain/parameters/paginate_academy_parameter.dart';
import 'package:jankuier_mobile/features/services/domain/use_cases/academy/paginate_academy_case.dart';
import 'package:jankuier_mobile/features/services/presentation/bloc/academy/academy_bloc.dart';
import 'package:jankuier_mobile/features/services/presentation/bloc/academy/academy_event.dart';
import 'package:jankuier_mobile/features/services/presentation/bloc/academy/academy_state.dart';
import 'package:jankuier_mobile/shared/widgets/main_title_widget.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_route_constants.dart';
import '../../../../../core/di/injection.dart';
import '../section_card.dart';

class SectionMain extends StatefulWidget {
  const SectionMain({super.key});

  @override
  State<SectionMain> createState() => _SectionMainState();
}

class _SectionMainState extends State<SectionMain>
    with AutomaticKeepAliveClientMixin {
  final PaginateAcademyParameter paginateAcademyParameter =
      PaginateAcademyParameter();

  late final AcademyBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = AcademyBloc(
      paginateAcademyCase: getIt<PaginateAcademyCase>(),
    )..add(PaginateAcademyEvent(paginateAcademyParameter));
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // ⚡ обязательно для AutomaticKeepAliveClientMixin
    return BlocProvider.value(
      value: _bloc,
      child: BlocBuilder<AcademyBloc, AcademyState>(
        builder: (context, state) {
          if (state is PaginateAcademyLoadedState) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const MainTitleWidget(title: "Запись в секцию"),
                        IconButton(
                            onPressed: () {
                              showModalBottomSheet<void>(
                                context: context,
                                useRootNavigator: false,
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                builder: (BuildContext context) {
                                  return const SizedBox();
                                },
                              );
                            },
                            icon: Icon(
                              Iconsax.filter_square_copy,
                              size: 18.sp,
                            ))
                      ]),
                  SizedBox(height: 12.h),
                  Column(
                    children: state.academies
                        .map((item) => SectionCardWidget(
                              entity: item,
                              onTap: () {
                                context.push(
                                  "${AppRouteConstants.ServiceSectionSinglePagePath}${item.id}",
                                );
                              },
                            ))
                        .toList(),
                  )
                ],
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
