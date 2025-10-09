class FormValidationConstant {
  static String UserNameRegExp = r'^[a-zA-Z0-9._@-]{3,255}$';
  static String EmailRegExp =
      r'^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$';
  static String PhoneRegExp = r'^77\d{9}$';
  static String IinRegExp = r'^\d{12}$';
}
