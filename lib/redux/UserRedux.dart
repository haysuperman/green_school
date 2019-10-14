import 'package:green_school/manager/UserManager.dart';
import 'package:redux/redux.dart';

import 'package:green_school/model/User.dart';

final UserReducer = combineReducers<User>([
    TypedReducer<User, UpdateUserAction>(updateUserInfo)
]);

User updateUserInfo(User user, action) {
  user = action.userInfo;
  UserManager.instance.user = action.userInfo;
  return user;
}

class UpdateUserAction{
    final User userInfo;
    UpdateUserAction(this.userInfo);
}
