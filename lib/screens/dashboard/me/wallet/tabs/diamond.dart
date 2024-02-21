import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:live_app/provider/shop_wallet_provider.dart';
import 'package:live_app/provider/user_data_provider.dart';
import 'package:provider/provider.dart';

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
              padding: const EdgeInsets.all(15.0),
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
                      )
                    ],
                  ),
                ),
              ),
            ),
            value.iapLoading || value.iapDiamondsList == null
                ? const Center(child: CircularProgressIndicator(color: Colors.green))
                : !value.iapAvailable
                ? const Text(' In-App-Purchase not available!')
                : Column(
                    children: [
                      for(var product in value.iapDiamondsList!)
                        diamondValueTile(product)
                    ],
                  )
          ],
        ),
      ),
    );
  }

  Padding diamondValueTile(ProductDetails dv) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
      child: SizedBox(
        width: double.infinity,
        child: ListTile(
          onTap: () {
            Provider.of<ShopWalletProvider>(context, listen: false)
                .purchaseDiamonds(dv);
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

  Text diamondsWidget(text) => Text(
        text.toString(),
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 18),
      );
}
