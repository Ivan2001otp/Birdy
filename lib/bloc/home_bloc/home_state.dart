import 'package:user_chat_app/Models/UserInfo.dart' as Us;
import 'package:user_chat_app/bloc/home_bloc/home_status.dart';

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
