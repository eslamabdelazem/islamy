class ApiConstants {
  static const String players = '................................';

  static const String users = 'user';
  static const String locations = 'locations';


  // Common
  static const String switchNotify = 'switch-notify';
  static const String changeLang = 'change-lang';
  static const String contact = 'contact';
  static const String getAllContacts = 'get-all-contacts';
  static const String getCities = 'cities';
  static const String addRate = 'add-rate';

  // static pages
  static const String about = '$users/about';
  static const String terms = '$users/terms';
  static const String privacy = '$users/privacy';
  static const String questionsAnswers = '$users/fqs';


  // auth
  static const String register = '$users/register';
  static const String activate = '$users/activate'; // method = put
  static const String completeProfile = '$users/complete-profile';
  static const String verifyLogin = '$users/verify-login';
  static const String sendCode = '$users/resend-code';
  static const String logout = '$users/logout';
  static const String deleteAccount = '$users/delete-account';

  // Home
  static const String home = '$users/home';
  static const String storeLocation = '$locations/store';
  // static const String updateLocation = '$locations/26/update';

  // categories
  static const String showProviderDetailsOrGetProviders = '$users/providers/';
  static const String getAllCategories = 'categories';
  static const String check = '$users/check';
  static const String products = '/products';
  static const String offers = '/offers';

  //profile
  static const String getProfile = '$users/profile/';
  static const String updateProfile = '$users/profile/update';
  static const String sendCodeToOldPhone = '$users/send-code-to-old-phone';
  static const String verifyOldPhone = '$users/verify-old-phone';
  static const String sendCodeToNewPhone = '$users/send-code-to-new-phone';
  static const String verifyNewPhone = '$users/verify-new-phone';


}
