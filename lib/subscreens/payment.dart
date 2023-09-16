import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Paym extends StatefulWidget {
  const Paym({super.key});

  @override
  State<Paym> createState() => _PaymState();
}

class _PaymState extends State<Paym> {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    double b = a * 0.97;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text('Diamond Seller'),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0 * a),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text('Recharge'),
                Image.asset('assets/payment.png'),
                const Text('6576867'),
              ],
            ),
            const SizedBox(
              height: 35,
            ),
            const Text('Recharged BY'),
            paymethod('assets/visa.png', 'VISA'),
            const SizedBox(
              height: 30,
            ),
            paymethod('assets/paytm.png', 'Paytm'),
            const SizedBox(
              height: 30,
            ),
            paymethod('assets/upi.png', 'UPI'),
            const SizedBox(
              height: 30,
            ),
            paymethod('assets/phonepay.png', 'PhonePay'),
          ],
        ),
      ),
    );
  }

  Row paymethod(img, txt) {
    return Row(
      children: [
        Image.asset(img),
        const SizedBox(
          width: 35,
        ),
        Text(txt),
      ],
    );
  }
}
