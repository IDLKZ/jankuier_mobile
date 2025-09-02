class ApiConstant {
  //Base URL to Sota
  static const String BaseURL = "http://10.0.2.2:8000/api/";
  static const String ImageURL = "http://10.0.2.2:8000/";
  //Get Product URL
  static const String PaginateAllProductsUrl = "${BaseURL}product/";
  static const String GetAllProductsUrl = "${BaseURL}product/all/";
  static String GetFullProductDetailUrl(int productId) {
    return "${BaseURL}product/get-full-product/$productId/";
  }

  static const String GetAllProductCategoriesUrl =
      "${BaseURL}product-category/all";

  static String GetImageUrl(String url) {
    return "${ImageURL}$url";
  }

  //Field
  static const String PaginateFieldsUrl = "${BaseURL}field/";
  static const String AllFieldsUrl = "${BaseURL}field/all";
  static String GetFieldByIdUrl(int fieldId) {
    return "${BaseURL}product/field/get/$fieldId/";
  }

  //FieldParty
  static const String PaginateFieldPartiesUrl = "${BaseURL}field-party/";
  static const String AllFieldPartiesUrl = "${BaseURL}field-party/all";
  static String GetFieldPartyByIdUrl(int fieldId) {
    return "${BaseURL}product/field-party/get/$fieldId/";
  }

  //FieldPartyGeneratedSchedule
  static const String GetFieldPartyGeneratedSchdedulePreviewUrl =
      "${BaseURL}field-party-schedule/preview";

  //Field Gallery
  static const String AllFieldGalleryUrl = "${BaseURL}field-gallery/all";

  //Academy
  static const String PaginateAcademyUrl = "${BaseURL}academy/";
  static String GetFullAcademyDetailByIdUrl(int academyId) {
    return "${BaseURL}academy/get-full/$academyId/";
  }

  static const String GetAcademyGroupScheduleByDayAndGroupsIdUrl =
      "${BaseURL}academy-group-schedule/get-by-day-and-groups/";
}
