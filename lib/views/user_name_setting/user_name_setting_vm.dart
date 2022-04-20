import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:quick_backup/data/base/base_vm.dart';

import '../../utilities/pref_provider.dart';

class UserNameSettingVm extends BaseVm{
  TextEditingController userName = TextEditingController(text: FirebaseAuth.instance.currentUser!.displayName);

  getUserName(context)async {
    userName.text = Provider.of<PreferencesProvider>(context,listen: false).userName;
  }
}