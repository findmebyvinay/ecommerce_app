import 'package:ecom_app/core/common/abs_normal_state.dart';
import 'package:ecom_app/features/auth/domain/model/user_model.dart';
import 'package:equatable/equatable.dart';

sealed class LoginState extends Equatable {
  final AbsNormalState<UserModel> loginState;
    const LoginState({required this.loginState});

  LoginState copyWith({AbsNormalState<UserModel>? loginState}){
    return LoginStateImpl(loginState: loginState ?? this.loginState);
  }

  @override
  List<Object?> get props=>[loginState];
}

class LoginStateImpl extends LoginState{
    const  LoginStateImpl({required super.loginState});

  @override
  LoginState copyWith({AbsNormalState<UserModel>? loginState}){
    return LoginStateImpl(loginState: loginState?? this.loginState);
  }

  @override
  List<Object?> get props=>[loginState];
}

class LoginInitial extends LoginState{
   LoginInitial():super(loginState: AbsNormalInitialState<UserModel>());
}