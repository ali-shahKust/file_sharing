import 'package:firebase_auth/firebase_auth.dart';
import 'package:quick_backup/data/base/base_repo.dart';

abstract class LoginRepo extends BaseRepo {
  Future<String?> signInWithGoogle();
}
