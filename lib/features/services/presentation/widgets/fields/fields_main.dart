import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jankuier_mobile/features/services/presentation/widgets/fields_sorting_filter.dart';

import '../field_card.dart';

class FieldsMain extends StatelessWidget {
  const FieldsMain({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FieldsSortingFilter(),
          SizedBox(
            height: 12.h,
          ),
          FieldCard(
            title: "Академия им. С. Квочкина",
            subtitle: "(верхнее поле)",
            imagePath: 'assets/images/fields_1.jpg',
            size: "54×40м",
            duration: "60/90 минут",
            capacity: "до 18 человек",
            price: "15 000тг",
          ),
          FieldCard(
            title: "Академия им. Льва Яшина",
            subtitle: "(верхнее-правое поле)",
            imagePath: 'assets/images/fields_2.jpg',
            size: "45×90м",
            duration: "60/90 минут",
            capacity: "до 24 человек",
            price: "20 000тг",
          ),
        ],
      ),
    );
  }
}
