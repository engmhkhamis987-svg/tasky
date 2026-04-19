import 'package:flutter/material.dart';
import 'package:tasky/core/constants/storage_key.dart';
import 'package:tasky/core/services/preferences_manager.dart';
import 'package:tasky/models/task_model.dart';

class HomeController extends ChangeNotifier {
  String? userName;
  List<TaskModel> tasks = [];
  bool isLoading = false;
  String? userImagePath;

  void init() {
    loadUserData();
  }

  Future<void> loadUserData() async {
    userName = PreferencesManager().getString(StorageKey.username) ?? '';
    userImagePath = PreferencesManager().getString(StorageKey.userImage);
    notifyListeners();
  }
}
