// class User {
//   User(String username, String email, String accessToken, String refreshToken) {
//     _username = username;
//     _email = email;
//     _accessToken = accessToken;
//     _refreshToken = refreshToken;
//   }

//   String _username;
//   String _email;
//   String _accessToken;
//   String _refreshToken;

//   String get username => _username;
//   String get email => _email;
//   String get accessToken => _accessToken;
//   String get refreshToken => _refreshToken;

//   void updateAccessToken(String newAccessToken) {
//     _accessToken = newAccessToken;
//   }
// }

// class UserInfo with ChangeNotifier {
//   final User _userInfo = User();

//   Task getTaskFronIndex(int index) {
//     if (index < _taskList.length)
//       return _taskList[index];
//     else
//       return null;
//   }

//   int getLength() {
//     return _taskList.length;
//   }

//   void addTask(String text) {
//     _taskList.add(Task(text));
//     notifyListeners();
//   }

//   void switchCheckedTask(Task task) {
//     task.switchChecked();
//     notifyListeners();
//   }

//   void deleteTask(Task task) {
//     _taskList.remove(task);
//     notifyListeners();
//   }
// }
