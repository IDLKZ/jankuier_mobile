class ApiConstant {
  //Base URL to Sota
  static const String BaseURL = "http://10.0.2.2:5000/api/";
  static const String ImageURL = "http://10.0.2.2:5000/";
  // static const String BaseURL = "https://api.jankuier.kz/api/";
  // static const String ImageURL = "https://api.jankuier.kz/";
  static const String WebFrameGetShowURL =
      "https://jankuier.kz/web-frame-ticket/get-show/";
  static const String WebFrameRecreateOrderURL =
      "https://jankuier.kz/web-frame-ticket/get-widget/";
  //Get Cities URL
  static const String GetAllCitiesUrl = "${BaseURL}city/all/";
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

  //Ticketon Get Shows
  static const String GetAllTicketonShowsUrl = "${BaseURL}ticketon/shows";

  //Ticketon PaginateTicketonOrderUrl
  static const String PaginateClientTicketOrderUrl =
      "${BaseURL}ticketon-order/client/my-ticketon-orders";

  static String GetMyTicketOrderUrl(int ticketonOrderId) {
    return "${BaseURL}ticketon-order/client/my-ticketon-order/${ticketonOrderId}";
  }

  static String GetCheckTicketUrl(int ticketonOrderId, String ticketId) {
    return "${BaseURL}ticketon-order/check-ticket/${ticketonOrderId}/${ticketId}";
  }

  static String GetCheckOrderUrl(int ticketonOrderId) {
    return "${BaseURL}ticketon-order/check-order/${ticketonOrderId}";
  }

  //Auth Me, Login, Register
  static const String GetMeUrl = "${BaseURL}auth/me";
  static const String RegisterUrl = "${BaseURL}auth/register";
  static const String LoginUrl = "${BaseURL}auth/login";

  //User Update Profile, Password, Avatar
  static const String UpdateProfileUrl = "${BaseURL}auth/update-profile";
  static const String UpdatePasswordUrl = "${BaseURL}auth/update-password";
  static const String UpdateProfilePhoto =
      "${BaseURL}auth/update-profile-photo";
}
