import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Refund extends StatefulWidget {
  const Refund({super.key});

  @override
  State<Refund> createState() => _RefundState();
}

class _RefundState extends State<Refund> {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    double b = a * 0.97;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 67 * a,
        backgroundColor: const Color(0xff9E26BC).withOpacity(0.2),
        automaticallyImplyLeading: true,
        title: const Center(child: Text('Refund Policy')),
      ),
      body: Padding(
        padding: EdgeInsets.all(30.0 * a),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text('Refund Policy'),
                Text(
                    'Reading refund Policy of the website means\nthat you agree to electronically Sign the\nrefund Policy and terms of use and Privacy\n\nThe money You paid for the service you have \nrequested through out website or USE FUNS\nAPPLICATION is paid on advance and if the \nService is nor Successfully Performed, The money will returned to your bank account \nbase is reasons below.\n\nThe money will not returned in whole or in\npart after transferring the money to our \naccount for the following reasons.\nAttempting to steal or endanger othersaccounts.Fraud and manipulation of any information\nrequired.\nProvide incomplete and/or non compliant with information required.\n\nYou did not Provide the reqired information and/or no response from you within 72 hours.\n\nRequest a refund after informing you that Your Request has sent. Our during the estimated Period. our within 30 days or sending Your request\n\nThis website reserves the right to change\nand or modify and/or edit the money Back\nPolicy and/or not Policy at any time without\nprior notice and/or infrom the customer \nand visitor before and / or after'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
