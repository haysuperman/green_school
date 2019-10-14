import 'package:flutter/material.dart';

import 'package:redux/redux.dart';
//import State


final ThemeDataReducer = combineReducers<ThemeData>([
    TypedReducer<ThemeData, UpdateThemeDataAction>(_reducer)
]);

ThemeData _reducer(ThemeData state, action) {
  state = action.state;
  return state;
}

class UpdateThemeDataAction{
    final ThemeData state;
    UpdateThemeDataAction(this.state);
}
