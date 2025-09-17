import '../../../../core/constants/ticketon_api_constants.dart';
import '../../../../core/utils/typedef.dart';

class TicketonGetShowsParameter {
  final int? place;
  final String? withParam;
  final String? i18n;
  final String? type;

  const TicketonGetShowsParameter(
      {this.place = null,
      this.withParam = "future",
      this.i18n = "ru",
      this.type = TicketonApiConstant.CategoryType});

  DataMap toMap() {
    return {
      "type[]": type.toString(),
      //"place[]": place.toString(),
      "with[]": withParam.toString(),
      "i18n": i18n.toString(),
    };
  }
}
