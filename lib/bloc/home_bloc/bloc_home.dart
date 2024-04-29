import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_chat_app/Models/UserInfo.dart' as Us;
import 'package:user_chat_app/bloc/home_bloc/home_event.dart';
import 'package:user_chat_app/bloc/home_bloc/home_state.dart';

import '../../services/cloud_firestore.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  FirestoreCloud _firestoreCloudService = FirestoreCloud();

  HomeBloc() : super(HomeInitial()) {
    on<onLoadChatEvent>((event, emit) async {
      bool isSuccess = false;
      List<Us.UserInfo> result = [];

      emit(HomeLoading());

      try {
        result = await _firestoreCloudService.fetchAllFriends();

        if (result != null && (result.length > 0 || result.length == 0)) {
          isSuccess = true;
        }
      } catch (err, trace) {
        print("error -> ${err.toString()}");
        print("StackTrace -> ${trace.toString()}");

        emit(HomeFailureStatus(err.toString()));
      }

      if (isSuccess) {
        emit(HomeSuccessStatus(result));
      }
    });
  }
}
