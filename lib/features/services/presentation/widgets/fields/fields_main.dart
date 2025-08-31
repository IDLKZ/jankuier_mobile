import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:jankuier_mobile/features/services/data/entities/field/field_party_entity.dart';
import 'package:jankuier_mobile/features/services/domain/parameters/paginate_field_party_parameter.dart';
import 'package:jankuier_mobile/features/services/presentation/bloc/field_party/field_party_event.dart';
import 'package:jankuier_mobile/features/services/presentation/bloc/field_party/field_party_state.dart';

import '../../../../../core/di/injection.dart';
import '../../../../../shared/widgets/main_title_widget.dart';
import '../../../domain/use_cases/field/paginate_field_party_case.dart';
import '../../bloc/field_party/field_party_bloc.dart';
import '../field_card.dart';

class FieldsMain extends StatefulWidget {
  const FieldsMain({super.key});

  @override
  State<FieldsMain> createState() => _FieldsMainState();
}

class _FieldsMainState extends State<FieldsMain>
    with AutomaticKeepAliveClientMixin {
  late final FieldPartyBloc _bloc;
  final PaginateFieldPartyParameter _params =
      PaginateFieldPartyParameter(orderBy: "field_id", orderDirection: "desc");

  @override
  void initState() {
    super.initState();
    _bloc = FieldPartyBloc(
      paginateFieldPartyCase: getIt<PaginateFieldPartyCase>(),
    )..add(PaginateFieldPartyEvent(_params));
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // важно для AutomaticKeepAliveClientMixin
    return BlocProvider.value(
      value: _bloc,
      child: BlocBuilder<FieldPartyBloc, FieldPartyState>(
        builder: (context, state) {
          if (state is PaginateFieldPartyLoadedState) {
            final fieldParties = state.fieldParties;

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(context),
                  SizedBox(height: 15.h),
                  _buildFieldList(fieldParties),
                ],
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const MainTitleWidget(title: "Аренда полей"),
        IconButton(
          icon: Icon(Iconsax.filter_square_copy, size: 18.sp),
          onPressed: () {
            showModalBottomSheet<void>(
              context: context,
              useRootNavigator: false,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (_) => const SizedBox(), // TODO: фильтр
            );
          },
        ),
      ],
    );
  }

  Widget _buildFieldList(List<FieldPartyEntity> fieldParties) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: fieldParties.length,
      separatorBuilder: (_, __) => SizedBox(height: 12.h),
      itemBuilder: (context, index) {
        return FieldCard(fieldPartyEntity: fieldParties[index]);
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
