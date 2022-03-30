import 'package:glass_mor/data/services/auth_services.dart';

abstract class BaseRepo {
  AuthService authRepo = AuthService();
}