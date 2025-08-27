class ApiConstant {
  //Base URL to Sota
  static const String BaseURL = "http://localhost:5000/api/";
  //Get Product URL
  static const String PaginateAllProductsUrl = "${BaseURL}product/";
  static const String GetAllProductsUrl = "${BaseURL}product/all/";
  static String GetFullProductDetailUrl(int productId) {
    return "${BaseURL}product/get-full-product/$productId/";
  }
}
