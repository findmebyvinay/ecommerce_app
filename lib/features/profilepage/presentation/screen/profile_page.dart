

import 'dart:developer';
import 'package:ecom_app/core/constants/app_colors.dart';
import 'package:ecom_app/core/extension/build_context_extension.dart';
import 'package:ecom_app/core/extension/widget_extensions.dart';
import 'package:ecom_app/core/services/app_clear_service.dart';
import 'package:ecom_app/core/services/local_database/local_database_mixin.dart';
import 'package:ecom_app/core/services/local_database/local_database_table.dart';
import 'package:ecom_app/features/auth/domain/model/user_model.dart';
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
  bool isLoading=true;

  @override
  void initState() {
    getUser();
    super.initState();
    
  }
  void getUser()async{
    setState(() {
      isLoading=true;
    });
     List<Map<String,dynamic>> userList=await getAllData(LocalDatabaseTable.users);
     log('saved database data from userlist:$userList');
   try{
    if(userList.isNotEmpty){
      setState(() {
        userModel= UserModel.fromJson(userList.first);
        isLoading=false;
      });
      log('user is: ${userModel?.username}');
      log('firstname:${userModel?.firstName ?? 'no name available'}');
    }
    else{
      setState(() {
        userModel=null;
        isLoading =false;
      });
      log('returning null in usermodel');
    }   
   }
   catch(e){
      setState(() {
              userModel=null;
              isLoading=false;
      });
   }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body:
      // userModel==null && !isLoading? 
      // Center(child: CircularProgressIndicator()): 
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: CircleAvatar(
                radius: 80.r,
                child: userModel?.image==null? 
                Icon(Icons.person,
              size: 80,
              color: AppColors.blackColor,
              ):Image.network('${userModel?.image}',
              scale: 1,),
              ).padBottom(
                bottom: 20.h
              ),
            ),
            Expanded(
              child: Container(
                height: 200.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                    // boxShadow: [
                    //   BoxShadow(
                    //     color: Colors.transparent,
                    //     blurRadius: 5.r,
                    //     offset: Offset(0, 2)
                    // //   )
                    // ]
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                      Divider(
                thickness: 0.5,
                color: AppColors.darkGreyColor,
              ),
                    Text('User Id: ${userModel?.id}',
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: Colors.black 
                        ),).padBottom(
                          bottom: 10.h
                        ),
                         Divider(
                thickness: 0.5,
                color: AppColors.darkGreyColor,
              ),
                      Text('Firstname: ${userModel?.username}',
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: Colors.black 
                        ),).padBottom(
                          bottom: 10.h
                        ),
                         Divider(
                thickness: 0.5,
                color: AppColors.darkGreyColor,
              ),
                    Text('Email: ${userModel?.email}',
                    style:context.textTheme.bodyMedium?.copyWith(
                          color: Colors.black
                        ),).padBottom(
                          bottom: 10.h
                        ),
                         Divider(
                thickness: 0.5,
                color: AppColors.darkGreyColor,
              ),
                        Text('Gender: ${userModel?.gender}',
                         style:context.textTheme.bodyMedium?.copyWith(
                          color: Colors.black
                        ),),
                         Divider(
                thickness: 0.5,
                color: AppColors.darkGreyColor,
              ),
                  ],
                  
                ),
              ).padHorizontal(horizontal: 25.w),
            ),
              ButtonWidget(
                height: 50.h,
                width: 150,
                buttonColor:AppColors.primaryColor,
              onTap: (){
                AppClearService().clearAllData();
              },
              lable: 'Logout',
              ),
              20.verticalSpace,
          ],
        ).padHorizontal(
          horizontal: 20.w
        ),
      ),
    );
  }
}