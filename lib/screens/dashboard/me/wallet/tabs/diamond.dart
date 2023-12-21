import 'package:flutter/material.dart';
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
  void initState() {
    Provider.of<ShopWalletProvider>(context,listen: false).getDiamondValueList();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
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
                          diamondsWidget(Provider.of<UserDataProvider>(context).userData?.data?.diamonds??0),
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
          Provider.of<ShopWalletProvider>(context).diamondValueList == null
              ? const Center(child: CircularProgressIndicator())
              : Column(
            children: [
              for(var dv in Provider.of<ShopWalletProvider>(context).diamondValueList!)
                customValueTile('${dv.diamond}','${dv.price}')
            ],
          )

        ],
      ),
    );
  }

  Padding customValueTile(String text,String t1) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 5),
      child: SizedBox(
        width: double.infinity,
        child: ListTile(
          leading: Image.asset(
            'assets/icons/ic_diamond.png',
            height: 24,
            fit: BoxFit.fitHeight,
          ),
          title: Text(text),
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
                Text('$t1 INR'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Text diamondsWidget(text) => Text(
        text.toString(),
        style: const TextStyle(color: Colors.white),
      );
}
