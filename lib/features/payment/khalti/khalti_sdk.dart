// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:khalti_checkout_flutter/khalti_checkout_flutter.dart';

// class KhaltiSdk extends StatefulWidget {
//   const KhaltiSdk({super.key});

//   @override
//   State<KhaltiSdk> createState() => _KhaltiSdkState();
// }

// class _KhaltiSdkState extends State<KhaltiSdk> {
//   late final Future<Khalti?> khalti;
//   String pidx='rdGXtVHR2Tkw3AnksYErWR';
//   PaymentResult? paymentResult;
//   @override
//   void initState() {
//     super.initState();
//     final payConfig= KhaltiPayConfig(
//       environment: Environment.test,
//       publicKey: 'test_public_key_d5d9f63743584dc38753056b0cc737d5',
//        pidx: pidx);

//        khalti= Khalti.init(
//         payConfig: payConfig,
//         onPaymentResult: (onPaymentResult,khalti){
//           log(paymentResult.toString());
//           setState(() {
//             paymentResult = paymentResult;
//           });
//           khalti.close(context);
//         },
//          onMessage: (khalti,{
//             description,
//             statusCode,
//             event,
//             needsPaymentConfirmation,
//           })async{
//               log(
//                 'Description: $description,Status Code: $statusCode, Event: $event, NeedsPaymentConfirmation: $needsPaymentConfirmation '
//               );
//               khalti.close(context);
//          },
//          onReturn: () =>  log('Successully redirected to return_url'),
//          );
    
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: FutureBuilder(
//           future: khalti,
//           initialData: null,
//           builder: (context, snapshot) {
//             final khaltiSnapshot = snapshot.data;
//             if (khaltiSnapshot == null) {
//               return const CircularProgressIndicator.adaptive();
//             }
//             return Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const SizedBox(height: 120),
//                 const Text(
//                   'Rs. 22',
//                   style: TextStyle(fontSize: 25),
//                 ),
//                 const Text('1 day fee'),
//                 OutlinedButton(
//                   onPressed: () => khaltiSnapshot.open(context),
//                   child: const Text('Pay with Khalti'),
//                 ),
//                 const SizedBox(height: 120),
//                 paymentResult == null
//                     ? Text(
//                         'pidx: $pidx',
//                         style: const TextStyle(fontSize: 15),
//                       )
//                     : Column(
//                         children: [
//                           Text(
//                             'pidx: ${paymentResult!.payload?.pidx}',
//                           ),
//                           Text('Status: ${paymentResult!.payload?.status}'),
//                           Text(
//                             'Amount Paid: ${paymentResult!.payload?.totalAmount}',
//                           ),
//                           Text(
//                             'Transaction ID: ${paymentResult!.payload?.transactionId}',
//                           ),
//                         ],
//                       ),
//                 const SizedBox(height: 120),
//                 const Text(
//                   'This is a demo application developed by some merchant.',
//                   style: TextStyle(fontSize: 12),
//                 )
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
// }