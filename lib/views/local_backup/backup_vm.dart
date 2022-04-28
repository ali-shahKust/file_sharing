// import 'package:get_it/get_it.dart';
// import 'package:quick_backup/data/base/base_vm.dart';
//
// import '../../data/local_db/database_helper.dart';
// import '../../data/models/queue_model.dart';
//
// class BackUpVm extends BaseVm {
//   List<QueueModel?> _backupFiles = [];
//   var dbHelper = GetIt.I.get<DatabaseHelper>();
//   List<QueueModel?> get backupFiles => _backupFiles;
//   bool _backFileSelected = false;
//
//   bool get backFileSelected => _backFileSelected;
//
//   set backFileSelected(bool value) {
//     _backFileSelected = value;
//     notifyListeners();
//   }
//
//   set backupFiles(List<QueueModel?> value) {
//     _backupFiles = value;
//     notifyListeners();
//   }
//   selectItem(index) {
//     backupFiles[index]!.isSelected = "1";
//     notifyListeners();
//   }
//
//   unSelectItem(index) {
//     backupFiles[index]!.isSelected = "0";
//     notifyListeners();
//   }
//
//   getBackUpFiles() async {
//     backupFiles.clear();
//     backupFiles = await dbHelper.getAllBackupFilesFromDb();
//   }
// }
