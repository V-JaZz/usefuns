import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/provider/shop_wallet_provider.dart';
import 'package:provider/provider.dart';

class RechargeHistory extends StatefulWidget {
  const RechargeHistory({super.key});
  @override
  State<RechargeHistory> createState() => _RechargeHistoryState();
}

class _RechargeHistoryState extends State<RechargeHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recharge History'),
      ),
      body: Container(
        height: Get.height,
        width: Get.width,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: FutureBuilder(
          future: Provider.of<ShopWalletProvider>(context).getRechargeHistory(),
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting){
              return const Center(child: CircularProgressIndicator());
            }else if(snapshot.data == null){
              return const Center(child: Text('Error!'));
            }else if(snapshot.data!.isEmpty){
              return const Center(child: Text('No Data!'));
            }else{
              return ListView(
                padding: const EdgeInsets.only(top: 0),
                physics: const BouncingScrollPhysics(),
                children: List.generate(
                    snapshot.data!.length,
                        (i) {
                  final details = snapshot.data![i];
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    padding: const EdgeInsets.symmetric(
                        vertical: 8, horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                          color: const Color(0xffF3F4F6),
                          width: 1),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        regularText(
                            '${details.createdAt?.toLocal()}',
                            Colors.grey,
                            14),
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                boldText(
                                    '${details.diamonds} Diamonds',
                                    const Color(0xff1D3A70),
                                    18),
                                const SizedBox(height: 4),
                                Text(
                                  '${details.transactionId}',
                                  style: TextStyle(
                                      fontFamily: TextFontFamily.ROBOTO_MEDIUM,
                                      fontSize: 16,
                                      color: const Color(0xff6B7280)),
                                ),
                                regularText(
                                    '${details.paymentMethod}',
                                    Colors.grey,
                                    14),
                                const SizedBox(height: 4),
                              ],
                            ),
                            Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.end,
                              children: [
                                boldText(
                                    '₹${details.price}',
                                    details.status == 'purchased'
                                        ? const Color(0xff00B428)
                                        : const Color(0xffFB923C),
                                    20),
                                  Padding(
                                    padding:
                                    const EdgeInsets.only(top: 4),
                                    child: regularText(
                                        "${details.status}",
                                        details.status == 'purchased'
                                            ? const Color(0xff00B428)
                                            : const Color(0xffFB923C),
                                        14),
                                  )
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  );
                }),
              );
            }
          },
        ),
      ),
    );
  }
}

boldText(text, color, double size, [align]) => Text(
  text,
  textAlign: align,
  style: TextStyle(
      fontFamily: TextFontFamily.ROBOTO_BOLD, fontSize: size, color: color),
);

regularText(text, color, double size, [align]) => Text(
  text,
  textAlign: align,
  style: TextStyle(
      fontFamily: TextFontFamily.ROBOTO_REGULAR,
      fontSize: size,
      color: color),
);
class TextFontFamily{
  static String  ROBOTO_BOLD = "RobotoBold";
  static String  ROBOTO_REGULAR = "RobotoRegular";
  static String  ROBOTO_LIGHT = "RobotoLight";
  static String  ROBOTO_BLACK = "RobotoBlack";
  static String  ROBOTO_MEDIUM = "RobotoMedium";
}