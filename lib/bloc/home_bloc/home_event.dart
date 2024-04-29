import 'package:user_chat_app/Models/UserInfo.dart' as Us;

abstract class HomeEvent {
  const HomeEvent();
}

class onLoadChatEvent extends HomeEvent {
  const onLoadChatEvent();
}
