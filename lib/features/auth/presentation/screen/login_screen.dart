import 'dart:developer';

import 'package:ecom_app/core/constants/app_colors.dart';
import 'package:ecom_app/core/constants/enum.dart';
import 'package:ecom_app/core/extension/build_context_extension.dart';
import 'package:ecom_app/core/extension/widget_extensions.dart';
import 'package:ecom_app/core/services/get_it/service_locator.dart';
import 'package:ecom_app/core/services/local_storage/shared_pref_data.dart';
import 'package:ecom_app/features/auth/presentation/Login_bloc/login_bloc.dart';
import 'package:ecom_app/features/auth/presentation/Login_bloc/login_event.dart';
import 'package:ecom_app/features/auth/presentation/Login_bloc/login_state.dart';
import 'package:ecom_app/widget/button_widget.dart';
import 'package:ecom_app/widget/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController= TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    getIt<SharedPrefData>().clearAuthToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.bgColor,
          body:Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Cheapify',
                style: context.textTheme.displayMedium?.copyWith(
                  color: AppColors.primaryColor,
                ),),
                Lottie.asset('assets/animations/shooping.json',
                height: 200.h,
                width: double.infinity),
                Text('The cheapest online store!',
                style: context.textTheme.bodyMedium?.copyWith(
                  color: AppColors.primaryColor,
                  fontStyle: FontStyle.italic
                ),).padBottom(bottom: 20.h),
                 if (state.loginState.absNormalStatus ==
                          AbsNormalStatus.ERROR) ...{
                        Text(
                          state.loginState.failure?.message ??
                              'Invalid Email',
                          style: context.textTheme.bodyLarge!.copyWith(
                            color: AppColors.errorColor,
                          ),
                        ).padBottom(bottom: 20.h).padHorizontal(horizontal: 20.w),
                      },
                  TextFieldWidget(
                    controller: _usernameController,
                    labelText: 'Username',
                    hintText: 'enter user name',
                    validator: (value) {
                      if(value==null || value.isEmpty){
                        return 'Username required';
                      }
                      return null;
                    },
                  ).padBottom(
                    bottom: 20.h
                  ),
                  TextFieldWidget(
                    controller: _passwordController,
                    labelText: 'Password',
                    hintText: 'Password',
                    validator: (value) {
                      if(value==null|| value.isEmpty){
                        return 'Password Required';
                      }
                      return null;
                    },
                  ).padBottom(bottom: 40.h),
                
                  ButtonWidget(
                    buttonColor: AppColors.primaryColor,
                    lable: 'LOGIN',
                    isLoading:state.loginState.absNormalStatus ==AbsNormalStatus.LOADING,
                    onTap: (){
                      log('user tapped button');
                      if(_formKey.currentState?.validate()??false){
                        
                       getIt<LoginBloc>().add(LoginSubmittedEvent(
                          username: _usernameController.text,
                           password: _passwordController.text));
                      }
                    })
                
                  
                
                
              ],
            ).padHorizontal(horizontal: 20.w),
          )
        );
      },
    );
  }
}
