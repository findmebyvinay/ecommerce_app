import 'dart:developer';

import 'package:ecom_app/core/common/abs_normal_state.dart';
import 'package:ecom_app/core/constants/enum.dart';
import 'package:ecom_app/core/constants/typedef.dart';
import 'package:ecom_app/core/routes/routes_name.dart';
import 'package:ecom_app/core/services/get_it/service_locator.dart';
import 'package:ecom_app/core/services/local_database/local_database_mixin.dart';
import 'package:ecom_app/core/services/local_database/local_database_table.dart';
import 'package:ecom_app/core/services/local_storage/shared_pref_data.dart';
import 'package:ecom_app/core/services/navigation_service.dart';
import 'package:ecom_app/features/auth/domain/model/user_model.dart';
import 'package:ecom_app/features/auth/domain/repo/auth_repo.dart';
import 'package:ecom_app/features/auth/presentation/Login_bloc/login_event.dart';
import 'package:ecom_app/features/auth/presentation/Login_bloc/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class LoginBloc extends Bloc<LoginEvent,LoginState>with LocalDatabaseOperationsMixin {
LoginBloc():super(LoginInitial()){
on<LoginEvent> ((event, emit) {},);
on<LoginSubmittedEvent> (_onLoginSubmiitedEvent);
}

Future<void> _onLoginSubmiitedEvent(LoginSubmittedEvent event,Emitter<LoginState> emit)async{
emit(state.copyWith(
  loginState: AbsNormalLoadingState<UserModel>()
));
 DynamicResponse response = await getIt<AuthRepo>().login(
  username: event.username,
   password:event.password);

   response.fold(
    (l){
      UserModel? userModel;
      String? token;
      try{
          if(l != null &&
              l is Map<String, dynamic> &&
              l.containsKey('data') &&
              l['data'] is Map<String, dynamic>
           ){
            final data = l['data'] as Map<String,dynamic>;
            try {
              if (data.containsKey('accessToken')) {
                token = data['accessToken'];
                log('Access token found: ${token?.substring(0, 10)}...'); // Log first 10 chars for security
              } else {
                log('No access token found in response');
              }
            } catch (e) {
              log('Error parsing token: $e');
              rethrow;
            }
            try {
              
                if(l.containsKey('data')){
                    final userData = l['data'] as Map<String,dynamic>;
                userModel = UserModel.fromJson(userData);
                // Save user data to local database
                  insertMapData(
                    LocalDatabaseTable.users,
                    userModel.toJson(),
                  ).catchError((error) {
                    log('Error saving user data: $error');
                  });
                  log('Successfully saved inside database:$userData');
                }              
                  

            } catch (e) {
              log('Error parsing user data: $e');
              rethrow;
            }
          }
           }
      catch(e){
        log('Error occured on login submit');
      }   log('$response');
          log('successfully saved used accessToken:$token');
        emit(
          state.copyWith(
            loginState: state.loginState.copyWith(
              absNormalStatus: AbsNormalStatus.SUCCESS,
              data: userModel,
            ),
          ),
        );
        if ((token ?? '').isNotEmpty) {
          getIt<SharedPrefData>().saveAuthToken(token: token ?? '');
          getIt<NavigationService>().pushNamedAndRemoveUntil(
            RoutesName.dashboardScreen,
            false,
          );
        }

    },
     (r){final loginState = AbsNormalStateImpl<UserModel>(
          absNormalStatus: AbsNormalStatus.ERROR,
        );
        emit(state.copyWith(loginState: loginState));

     });
}

}