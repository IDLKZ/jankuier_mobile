import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jankuier_mobile/core/common/entities/file_entity.dart';

import '../constants/api_constants.dart';

class FileUtils {
  static const String LocalProductImage = "assets/images/no_product.png";

  static Widget getProductImage(FileEntity? file) {
    if (file != null) {
      return Image.network(
        ApiConstant.GetImageUrl(file.filePath),
        width: double.infinity,
        height: 120.h,
        fit: BoxFit.cover,
      );
    }
    return Image.asset(
      LocalProductImage,
      width: double.infinity,
      height: 120.h,
      fit: BoxFit.cover,
    );
  }
}
