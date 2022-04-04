import 'package:firebase_auth/firebase_auth.dart';
import 'package:glass_mor/data/repo/main/main_repo.dart';

class MainRepoImp extends MainRepo {
  @override
  Future<String?> signInWithGoogle() async {
    return await authRepo.signInWithGoogle();
  }
}