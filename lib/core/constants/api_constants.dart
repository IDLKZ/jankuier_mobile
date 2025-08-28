class ApiConstant {
  //Base URL to Sota
  static const String BaseURL = "http://10.0.2.2:5000/api/";
  static const String ImageURL = "http://10.0.2.2:5000/";
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
}
