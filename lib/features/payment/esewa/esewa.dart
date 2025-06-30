import 'dart:developer';
import 'package:ecom_app/core/constants/app_colors.dart';
import 'package:ecom_app/core/extension/build_context_extension.dart';
import 'package:esewa_flutter_sdk/esewa_config.dart';
import 'package:esewa_flutter_sdk/esewa_flutter_sdk.dart';
import 'package:esewa_flutter_sdk/esewa_payment_success_result.dart';
import 'package:esewa_flutter_sdk/esewa_payment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path/path.dart';

class Esewa{
  final String productId;
  final String  totalQauntity;
  final String productPrice;
Esewa({
   required this.productId,
    required this.totalQauntity,
  required  this.productPrice,
});
  pay(){
 try{
    EsewaFlutterSdk.initPayment(esewaConfig:EsewaConfig(
          environment: Environment.test,
          clientId:'JB0BBQ4aD0UqIThFJwAKBgAXEUkEGQUBBAwdOgABHD4DChwUAB0R',
          secretId: 'BhwIWQQADhIYSxILExMcAgFXFhcOBwAKBgAXEQ==',
        ), 
    esewaPayment:EsewaPayment( productId: productId,
          productName: totalQauntity,
          productPrice: productPrice,
           callbackUrl: 'https://jsonplaceholder.typicode.com/posts',
     ), 
    onPaymentSuccess:(EsewaPaymentSuccessResult result){
      log('Payment Success');
      verify(result,context);
    },
     onPaymentFailure: (){
     log('Failed Payment');
     }, 
     onPaymentCancellation: (){
     log('cancelled payment');
     });
    }
    catch(e){
    log('Failed to proccess payment');
    }
  }
 verify(EsewaPaymentSuccessResult result,context){
    showDialog(
      context: context,
       builder: (BuildContext context){
          return AlertDialog(
            backgroundColor: AppColors.bgColor,
            title: Text('Payment Success',
            style: context.textTheme.bodyMedium?..copyWith(
              fontWeight: FontWeight.bold
            ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Your Order has been Successfully placed!'),
                10.verticalSpace,
                Text('Product Details'),
                10.verticalSpace,
                Text('Product Id: 1'),
                10.verticalSpace,
                Text('Total Product item: $totalQauntity'),
                10.verticalSpace,
                Text('Total Amount for the product: $productPrice')
              ],
            ),
            actions: [
              TextButton(onPressed: (){}, child: Text('Go Back'))
            ],
          );
       });
 }   
}