import 'package:quick_backup/data/repo/dashboard/dashboard_repo.dart';

class DashBoardRepoImp extends DashBoardRepo{
  @override
  login() async{
    return await authRepo.signInAnnonynomously();
  }
}