import 'package:flutter/material.dart';

class Coins extends StatefulWidget {
  const Coins({super.key});

  @override
  State<Coins> createState() => _WalletState();
}

class _WalletState extends State<Coins> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: Column(
        children: [
          Padding(
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
                          balanceupdate('0'),
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
          containermethod('20','1'),
          containermethod('2020','15'),
           containermethod('80','35'),

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
      ),
    );
  }

  Padding containermethod(text,t1) {
    return Padding(
          padding: const EdgeInsets.all(15.0),
          child: SizedBox(
            width: double.infinity,
            child: ListTile(
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
                    Image.asset('assets/diamond.png'),
                    const SizedBox(width: 19,),
                    Text(t1),
                  ],
                ),
              ),
            ),
          ),
        );
  }

  Text balanceupdate(text) => Text(
        text,
        style: const TextStyle(color: Colors.white),
      );
}
