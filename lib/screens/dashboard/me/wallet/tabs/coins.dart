import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../provider/user_data_provider.dart';
import '../../../../../utils/common_widgets.dart';

class CoinsTabView extends StatefulWidget {
  const CoinsTabView({super.key});

  @override
  State<CoinsTabView> createState() => _WalletState();
}

class _WalletState extends State<CoinsTabView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: (){
            showCustomSnackBar('Upcomming',context);
          },
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              width: double.infinity,
              height: 119,
              color: const Color(0xffF74928),
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
                          'assets/bitcoin.png',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 39.0, left: 50),
                      child: Column(
                        children: [
                          coinsWidget('${Provider.of<UserDataProvider>(context).userData?.data?.coins??0}'),
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
        ),
        coinsValueWidget('20','1'),
        coinsValueWidget('2020','15'),
        coinsValueWidget('80','35'),

        //  Container(
        //   child: ListTile(
        //     leading: Image.asset(
        //                   'assets/bitcoin.png',
        //                 ) ,
        //                 trailing: Container(
        //                   decoration: BoxDecoration(
        //                     border: Border.all()
        //                   ),
        //                 ),
        //   ),
        // )
      ],
    );
  }

  Padding coinsValueWidget(text,t1) {
    return Padding(
          padding: const EdgeInsets.all(15.0),
          child: SizedBox(
            width: double.infinity,
            child: ListTile(
              onTap: (){
                showCustomSnackBar('Upcomming',context);
              },
              leading: Image.asset(
                'assets/bitcoin.png',
              ),
              title: Text(text),
              trailing: Container(
                height: 30,
                width: 97,
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xffFFE500)),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(

                  children: [
                     const SizedBox(width: 19,),
                    Image.asset('assets/icons/ic_diamond.png',
                height: 12,
                fit: BoxFit.fitHeight),
                    const SizedBox(width: 19,),
                    Text(t1),
                  ],
                ),
              ),
            ),
          ),
        );
  }

  Text coinsWidget(text) => Text(
        text,
        style: const TextStyle(color: Colors.white),
      );
}
