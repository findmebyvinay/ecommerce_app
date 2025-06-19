

import 'dart:developer';

import 'package:ecom_app/core/constants/app_colors.dart';
import 'package:ecom_app/core/extension/build_context_extension.dart';
import 'package:ecom_app/core/extension/widget_extensions.dart';
import 'package:ecom_app/core/routes/routes_name.dart';
import 'package:ecom_app/core/services/get_it/service_locator.dart';
import 'package:ecom_app/core/services/local_database/local_database_mixin.dart';
import 'package:ecom_app/core/services/local_database/local_database_table.dart';
import 'package:ecom_app/core/services/local_storage/shared_pref_data.dart';
import 'package:ecom_app/core/services/navigation_service.dart';
import 'package:ecom_app/features/auth/domain/model/user_model.dart';
import 'package:ecom_app/widget/app_bar_widget.dart';
import 'package:ecom_app/widget/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>with LocalDatabaseOperationsMixin {
  UserModel? userModel;
  @override
  void initState() {
    getUser();
    super.initState();
    
  }
  void getUser()async{
    List<Map<String,dynamic>> userList=await getAllData(LocalDatabaseTable.users);
    if(userList.isNotEmpty){
      userModel= UserModel.fromJson(userList.first);
      log('firstname:${userModel?.firstName}');
    }
    else{
      userModel=null;
      log('returning null in usermodel');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: 'User Profile',
        isCenterTitle: true,
        backgroundColor: const Color.fromARGB(255, 5, 82, 9),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.person,
            size: 80,
            color: AppColors.blackColor,
            ).padBottom(
              bottom:20.h 
            ),
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                colors: [
                   const Color.fromARGB(255, 5, 82, 9).withValues(alpha: 0.5),
                  Colors.green[300]!.withValues(alpha: 0.5),

                  
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomLeft
                ),
                borderRadius: BorderRadius.circular(12)
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text('Firstname:',
                      style: context.textTheme.displaySmall?.copyWith(
                        color: Colors.white 
                      ),),
                      const SizedBox(width: 5,),
                      Text('${userModel?.firstName}',
                      style:context.textTheme.displaySmall?.copyWith(
                        color: Colors.white
                      ),
                      )
                    ],
                  ).padHorizontal(
                    horizontal: 10.w
                  )
                ],
                
              ),
            ).padBottom(
              bottom: 20.h
            ),
              ButtonWidget(
                height: 50,
                width: double.infinity,
                buttonColor:  const Color.fromARGB(255, 5, 82, 9),
              onTap: (){
                getIt<NavigationService>().pushNamedAndRemoveUntil(RoutesName.loginScreen, false);
                getIt<SharedPrefData>().clearAuthToken();
              },
              lable: 'Logout',
              ),
          ],
        ).padHorizontal(
          horizontal: 20.w
        ),
      ),
    );
  }
}