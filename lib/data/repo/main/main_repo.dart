import 'package:firebase_auth/firebase_auth.dart';
import 'package:glass_mor/data/base/base_repo.dart';

abstract class MainRepo extends BaseRepo {
  Future<String?> signInAnnoynomously();
}
