import 'package:quick_backup/data/repo/login/login_repo.dart';

class LoginRepoImp extends LoginRepo {
  @override
  Future<String?> signInWithGoogle() async {
    return await authRepo.signInWithGoogle();
  }
}
