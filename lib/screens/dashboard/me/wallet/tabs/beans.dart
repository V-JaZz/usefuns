import 'package:flutter/material.dart';
import 'package:live_app/provider/shop_wallet_provider.dart';
import 'package:live_app/utils/common_widgets.dart';
import 'package:provider/provider.dart';
import '../../../../../provider/user_data_provider.dart';

class BeanTabView extends StatefulWidget {
  const BeanTabView({super.key});

  @override
  State<BeanTabView> createState() => _BeanTabViewState();
}

class _BeanTabViewState extends State<BeanTabView> {
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
              color: const Color(0xffFEA500),
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
                          'assets/beans.png',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 39.0, left: 50),
                      child: Column(
                        children: [
                          beansWidget(Provider.of<UserDataProvider>(context).userData?.data?.beans??0),
                          const Text(
                            'Account Balance',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          beansValueWidget('1','4'),
          beansValueWidget('10','40'),
          beansValueWidget('100','400'),
          beansValueWidget('1000','4000'),
          beansValueWidget('5000','20000'),
          beansValueWidget('10000','40000'),
        ],
      ),
    );
  }

  Text beansWidget(text) => Text(
        text.toString(),
        style: const TextStyle(color: Colors.white),
      );

  Padding beansValueWidget(diamonds,beans) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 5),
      child: SizedBox(
        width: double.infinity,
        child: ListTile(
          onTap: (){
            if((Provider.of<UserDataProvider>(context,listen: false).userData?.data?.beans??0)>int.parse(beans)) {
              _showConfirmationDialog(
              () {
                Navigator.of(context).pop();
                Provider.of<ShopWalletProvider>(context,listen: false).convertBeans(int.parse(diamonds), int.parse(beans));
              },
              beans,
              diamonds
            );
            }else{
              showCustomSnackBar('Not Enough Beans!', context);
            }
          },
          leading: Image.asset(
            'assets/icons/ic_diamond.png',
            height: 24
          ),
          title: Text(diamonds),
          trailing: Container(
            height: 30,
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xffFEA500)),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(width: 12,),
                Image.asset('assets/beans.png',
                    height: 12,
                    fit: BoxFit.fitHeight),
                const SizedBox(width: 6),
                Text(beans),
                const SizedBox(width: 12,),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showConfirmationDialog(void Function() onConfirm, beans, diamonds) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          surfaceTintColor: Colors.white,
          shape: const RoundedRectangleBorder(),
          title: Text('Trade $beans beans for $diamonds diamonds?'),
          titleTextStyle: const TextStyle(fontSize: 16, color: Colors.black),
          actionsPadding: const EdgeInsets.all(3),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child:
              const Text('Cancel', style: TextStyle(color: Colors.black54)),
            ),
            TextButton(
              onPressed: onConfirm,
              child: const Text('Confirm',
                  style: TextStyle(color: Color(0xffFEA500))),
            ),
          ],
        );
      },
    );
  }
}
