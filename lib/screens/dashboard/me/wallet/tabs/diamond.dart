import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:live_app/data/model/response/diamond_value_model.dart';
import 'package:live_app/data/model/response/seller_model.dart';
import 'package:live_app/provider/shop_wallet_provider.dart';
import 'package:live_app/provider/user_data_provider.dart';
import 'package:live_app/utils/common_widgets.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../recharge_history.dart';

class DiamondTabView extends StatefulWidget {
  const DiamondTabView({super.key});

  @override
  State<DiamondTabView> createState() => _DiamondTabViewState();
}

class _DiamondTabViewState extends State<DiamondTabView> {

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Consumer<ShopWalletProvider>(
        builder: (context, value, _) =>  Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Container(
                width: double.infinity,
                height: 119,
                color: Colors.green,
                child: Center(
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 15, left: 35),
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white),
                          child: Image.asset(
                            'assets/icons/ic_diamond.png',
                            height: 12,
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 39.0, left: 50),
                        child: Column(
                          children: [
                            diamondsWidget(Provider.of<UserDataProvider>(context)
                                    .userData
                                    ?.data
                                    ?.diamonds ??
                                0),
                            const Text(
                              'Account Balance',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Align(
                        alignment: Alignment.topRight,
                        child: TextButton(
                          onPressed: () {
                            Get.to(()=>const DiamondsHistoryList());
                          },
                          child: const Row(
                            children: [
                              Icon(
                                  Icons.access_time_rounded,
                                  color: Colors.white,
                                size: 18
                              ),
                              SizedBox(width: 1),
                              Text(
                                'History',
                                style: TextStyle(
                                    color: Colors.white,
                                  fontSize: 12
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            ExpansionTile(
              initiallyExpanded: false,
              title: const Text('Google Wallet'),
              leading: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Image.asset('assets/google_wallet_ic.png'),
              ),
              children: [
                !value.iapAvailable
                    ? const ListTile(title: Text('In-App-Purchase not available!'))
                    : value.loading || value.iapDiamondsList == null
                    ? const Center(child: CircularProgressIndicator(color: Colors.green))
                    : Column(
                      children: [
                        for(var product in value.iapDiamondsList!)
                          iapProductTile(product)
                      ],
                    )
              ],
            ),
            //todo test and add phone pe
            // ExpansionTile(
            //   initiallyExpanded: false,
            //   title: Row(
            //     children: [
            //       const Text('Phone Pe'),
            //       const SizedBox(width: 12),
            //       Container(
            //         decoration: BoxDecoration(
            //           color: Colors.amber,
            //           borderRadius: BorderRadius.circular(6)
            //         ),
            //         padding: const EdgeInsets.symmetric(horizontal: 6),
            //         child: const Text('+3%',style: TextStyle(color: Colors.white)),
            //       )
            //     ],
            //   ),
            //   subtitle: value.result != null ? Text('${value.result}') : null,
            //   leading: Padding(
            //     padding: const EdgeInsets.all(12.0),
            //     child: Image.asset('assets/phone_pe_ic.png'),
            //   ),
            //   children: [
            //     Provider.of<UserDataProvider>(context).userData?.data?.countryCode != 'IN'
            //         ? const ListTile(title: Text('Phone Pe not available in your country!'))
            //         : value.loading || value.apiDiamondsList == null
            //         ? Center(child: Row(
            //           children: [
            //             Text(value.loading.toString()),
            //             Text(value.apiDiamondsList?.length.toString()??''),
            //             const CircularProgressIndicator(color: Colors.green),
            //           ],
            //         ))
            //         : Column(
            //           children: [
            //             for(var product in value.apiDiamondsList!)
            //               phonePayProductTile(product)
            //           ],
            //     )
            //   ],
            // ),
            ExpansionTile(
              initiallyExpanded: false,
              title: Row(
                children: [
                  const Text('Diamond Seller'),
                  const SizedBox(width: 12),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(6)
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: const Text('+5%',style: TextStyle(color: Colors.white)),
                  )
                ],
              ),
              leading: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Image.asset(
                  'assets/profile.png'
                ),
              ),
              children: [
                value.loading || value.sellersList == null
                    ? const Center(child: CircularProgressIndicator(color: Colors.green))
                    : Column(
                  children: [
                    for(var seller in value.sellersList!)
                      sellerTile(seller)
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Padding iapProductTile(ProductDetails dv) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
      child: SizedBox(
        width: double.infinity,
        child: ListTile(
          onTap: () {
            Provider.of<ShopWalletProvider>(context, listen: false)
                .inAppPurchaseDiamonds(dv);
          },
          leading: Image.asset(
            'assets/icons/ic_diamond.png',
            height: 24,
            fit: BoxFit.fitHeight,
          ),
          title: Text(dv.title.split(' ').first),
          trailing: Container(
            height: 30,
            width: 97,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.green),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(dv.price),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding phonePayProductTile(DiamondValue dv) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
      child: SizedBox(
        width: double.infinity,
        child: ListTile(
          onTap: Provider.of<ShopWalletProvider>(context, listen: false)
              .startPhonePeTransaction,
          leading: Image.asset(
            'assets/icons/ic_diamond.png',
            height: 24,
            fit: BoxFit.fitHeight,
          ),
          title: Text(dv.diamond.toString()),
          trailing: Container(
            height: 30,
            width: 97,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.green),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(dv.price.toString()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding sellerTile(SellerData sd) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
      child: SizedBox(
        width: double.infinity,
        child: ListTile(
          onTap: () {
            redirectToWhatsApp(sd.mobile);
          },
          leading: Image.asset(
            'assets/profile.png',
            height: 30,
            fit: BoxFit.fitHeight,
          ),
          title: Text(sd.sellerName.toString()),
          trailing: Image.asset('assets/whatsapp_ic.png', height: 36)
        ),
      ),
    );
  }

  Text diamondsWidget(text) => Text(
        text.toString(),
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 18),
      );

  void redirectToWhatsApp(int? phoneNumber) async {
    String url = "https://wa.me/$phoneNumber/?text=${Uri.encodeFull('Hii! I want to make diamond transaction.')}";

    if (phoneNumber!=null && await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      showCustomSnackBar('currently unable to connect!', Get.context!);
    }
  }
}

class DiamondsHistoryList extends StatefulWidget {
  const DiamondsHistoryList({super.key});

  @override
  State<DiamondsHistoryList> createState() => _DiamondsHistoryListState();
}

class _DiamondsHistoryListState extends State<DiamondsHistoryList> {
  String type = 'All';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Diamond History'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: DropdownButton<String>(
              value: type,
              underline: const SizedBox.shrink(),
              onChanged: (String? newValue) {
                setState(() {
                  type = newValue as String;
                });
              },
              items: <String>['All', 'Gift', 'Shop', 'Game', 'Treasure Box', 'Lucky Wheel', 'Beans To Diamonds']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: FutureBuilder(
                future: Provider.of<ShopWalletProvider>(context).getDiamondHistory(type),
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
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      boldText(
                                          '${details.uses}',
                                          const Color(0xff1D3A70),
                                          18),
                                      const SizedBox(height: 4),
                                      regularText(
                                          '${details.createdAt?.toLocal()}',
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
                                          '${details.type == 1 ? '-' : '+'} ₹${details.diamonds}',
                                          details.type == 2
                                              ? const Color(0xff00B428)
                                              : const Color(0xffFB923C),
                                          20),
                                      Padding(
                                        padding:
                                        const EdgeInsets.only(top: 4),
                                        child: regularText(
                                            details.type == 2 ? 'credited':'debited',
                                            details.type == 2
                                                ? const Color(0xff00B428)
                                                : const Color(0xffFB923C),
                                            14),
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
          ),
        ],
      ),
    );
  }
}