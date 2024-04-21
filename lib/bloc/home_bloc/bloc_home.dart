import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_chat_app/Models/UserInfo.dart' as Us;
import 'package:user_chat_app/bloc/home_bloc/home_event.dart';
import 'package:user_chat_app/bloc/home_bloc/home_state.dart';
import 'package:user_chat_app/bloc/home_bloc/home_status.dart';

import '../../services/cloud_firestore.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  FirestoreCloud _firestoreCloudService = FirestoreCloud();
  HomeBloc()
      : super(
          HomeState(
            friendList: [],
          ),
        ) {
    on<onLoadChatEvent>((event, emit) async {
      emit(
        state.copyWith(
          responseStatus: HomeLoadingStatus(message: 'Fetching Data...'),
        ),
      );

      try {
        List<Us.UserInfo> result =
            await _firestoreCloudService.fetchAllFriends();

        emit(
          state.copyWith(
            friendList: result,
            responseStatus: const HomeSuccessStatus(),
          ),
        );
      } catch (err, trace) {
        print("error -> ${err.toString()}");
        print("StackTrace -> ${trace.toString()}");

        emit(
          state.copyWith(
            responseStatus: const HomeFailureStatus(),
          ),
        );
      }
    });
  }
}
