

import 'dart:developer';
import 'package:ecom_app/core/constants/app_colors.dart';
import 'package:ecom_app/core/extension/build_context_extension.dart';
import 'package:ecom_app/core/extension/widget_extensions.dart';
import 'package:ecom_app/core/services/app_clear_service.dart';
import 'package:ecom_app/core/services/local_database/local_database_mixin.dart';
import 'package:ecom_app/core/services/local_database/local_database_table.dart';
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
      body:userModel==null && !isLoading? 
      Center(child: CircularProgressIndicator()): 
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              child: userModel?.image==null? 
              Icon(Icons.person,
            size: 80,
            color: AppColors.blackColor,
            ):Image.network('${userModel?.image}',
            scale: 1,),
            ).padBottom(
              bottom: 20.h
            ),
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12)
              ),
              child: Column(
                children: [
                  Text('User Id: ${userModel?.id}',
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: Colors.black 
                      ),).padBottom(
                        bottom: 10.h
                      ),
                    Text('Firstname: ${userModel?.username}',
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: Colors.black 
                      ),).padBottom(
                        bottom: 10.h
                      ),
                  Text('Email: ${userModel?.email}',
                  style:context.textTheme.bodyMedium?.copyWith(
                        color: Colors.black
                      ),).padBottom(
                        bottom: 10.h
                      ),
                      Text('Gender: ${userModel?.gender}',
                       style:context.textTheme.bodyMedium?.copyWith(
                        color: Colors.black
                      ),)
                ],
                
              ),
            ).padBottom(
              bottom: 20.h
            ),
              ButtonWidget(
                height: 50,
                width: double.infinity,
                buttonColor:AppColors.primaryColor,
              onTap: (){
                AppClearService().clearAllData();
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