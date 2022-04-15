import 'package:quick_backup/data/services/auth_services.dart';

abstract class BaseRepo {
  AuthService authRepo = AuthService();
}