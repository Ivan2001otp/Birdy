import 'package:user_chat_app/Models/UserInfo.dart' as Us;

abstract class HomeEvent {}

class onLoadChatEvent extends HomeEvent {
  final List<Us.UserInfo> friendsList;
  onLoadChatEvent({
    required this.friendsList,
  });
}
