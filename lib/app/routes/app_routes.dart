part of 'app_pages.dart'; // Pastikan ini menunjuk ke file utama

abstract class Routes {
  Routes._();
  static const HOME = _Paths.HOME;
  static const LOGIN = _Paths.LOGIN;
  static const REGISTER = _Paths.REGISTER;
  static const DASHBOARD = _Paths.DASHBOARD;
  static const PROFILE = _Paths.PROFILE;
}

abstract class _Paths {
  _Paths._();
  static const HOME = '/home';
  static const LOGIN = '/login';
  static const REGISTER = '/register';
  static const DASHBOARD = '/dashboard';
  static const PROFILE = '/user';
}
