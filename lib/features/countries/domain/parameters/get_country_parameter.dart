import '../../../../core/utils/typedef.dart';

class GetCountryParameter {
  final int page;
  final int perPage;

  const GetCountryParameter({this.page = 1, this.perPage = 250});

  DataMap toMap() {
    return {
      "page": page.toString(),
      "page_size": perPage.toString(),
    };
  }
}
