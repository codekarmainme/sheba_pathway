import 'package:chapasdk/chapasdk.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:chapasdk/features/native-checkout/chapa_native_payment.dart';
class PaymentRepository {
  Future<void> processPayment(
      final BuildContext context,
      final double amount,
      final String email,
      final String phone,
      final String firstName,
      final String lastName,
      final String txRef,
      final String title,
      final String desc,
      final String travelPlanID) async {
    String chapakey = await dotenv.env['CHAPA']!;
    print(chapakey);
    try{
      await Chapa.paymentParameters(
      context: context,
      publicKey: 'CHAPUBK_TEST-9uxNcKzrZ3vIvPvJK3tpw2DJyrPd5ZOc',
      currency: 'ETB',
      amount: amount.toString(),
      email: email,
      phone: phone,
      firstName: firstName,
      lastName: lastName,
      txRef: txRef,
      title: title,
      desc: desc,
      namedRouteFallBack: '/added_travel_plans',
      nativeCheckout: true,
      availablePaymentMethods: ['mpesa','telebirr'],
      
    );
    
    await FirebaseFirestore.instance
        .collection('travel_plans')
        .doc(travelPlanID)
        .update({'isPaid': true});

    }
   catch(e){
    print(e);
   } 
   
  }
}
