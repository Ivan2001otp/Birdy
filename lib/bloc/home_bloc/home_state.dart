import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:user_chat_app/Models/UserInfo.dart' as Us;

/*
class HomeState {
  final List<Us.UserInfo> friendList;
  final HomeStatus responseStatus;

  HomeState(
      {required this.friendList,
      this.responseStatus = const HomeInitialStatus()});

  HomeState copyWith({
    List<Us.UserInfo>? friendList,
    HomeStatus? responseStatus,
  }) {
    return HomeState(
      friendList: friendList ?? this.friendList,
      responseStatus: responseStatus ?? this.responseStatus,
    );
  }
}
*/

abstract class HomeState {
  HomeState();
}

class HomeInitial extends HomeState {
  HomeInitial();
}

class HomeLoading extends HomeState {
  HomeLoading();
}

class HomeSuccessStatus extends HomeState {
  final List<Us.UserInfo> resultList;

  HomeSuccessStatus(this.resultList);
}

class HomeFailureStatus extends HomeState {
  final String message;

  HomeFailureStatus(this.message);
}
