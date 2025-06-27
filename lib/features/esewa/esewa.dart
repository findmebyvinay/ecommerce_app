import 'dart:developer';
import 'package:esewa_flutter_sdk/esewa_config.dart';
import 'package:esewa_flutter_sdk/esewa_flutter_sdk.dart';
import 'package:esewa_flutter_sdk/esewa_payment_success_result.dart';
import 'package:esewa_flutter_sdk/esewa_payment.dart';

class Esewa{
  final String productId;
  final String productName;
  final String productPrice;
Esewa({
  this.productId='1',
  this.productName='Chicken',
  this.productPrice= '3000'
});
  pay(){
 try{
    EsewaFlutterSdk.initPayment(esewaConfig:EsewaConfig(
          environment: Environment.test,
          clientId:'JB0BBQ4aD0UqIThFJwAKBgAXEUkEGQUBBAwdOgABHD4DChwUAB0R',
          secretId: 'BhwIWQQADhIYSxILExMcAgFXFhcOBwAKBgAXEQ==',
        ), 
    esewaPayment:EsewaPayment( productId: productId,
          productName: productName,
          productPrice: productPrice,
           callbackUrl: 'https://jsonplaceholder.typicode.com/posts',
     ), 
    onPaymentSuccess:(EsewaPaymentSuccessResult result){
      log('Payment Success');
      verify(result);
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
 verify(EsewaPaymentSuccessResult result){

 }
   
}