
import 'package:flutter/material.dart';

class Rechargeagent extends StatefulWidget {
  const Rechargeagent({super.key});

  @override
  State<Rechargeagent> createState() => _RechargeagentState();
}

class _RechargeagentState extends State<Rechargeagent> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 67,
            backgroundColor: const Color(0xff9E26BC).withOpacity(0.2),
            leading: const Icon(Icons.arrow_back_ios_new_outlined),
            title: const Text('Agency'),
            bottom: const TabBar(tabs: [
              Text('Income'),
              Text('Record'),
            ]),
          ),
          body: const TabBarView(
            children: [
              incomegen(),
              Column(
                children: [
                  Text('Your Payment'),
                  Text('Rules'),
                  Text('Weekly Payment will Send as Beans'),
                ],
              ),
            ],
          )),
    );
  }
}

class incomegen extends StatelessWidget {
  const incomegen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Your Payment',
          style: TextStyle(fontSize: 25,fontWeight: FontWeight.w500),
        ),
        Table(
          children: [
            TableRow(
              children: [
                headerlabel("Time"),
                headerlabel("Total \nRecharge"),
                headerlabel(
                  "Reward \nPayment",
                ),
                headerlabel("Status"),
              ],
            ),
            tablerow(),
            tablerow(),
            tablerow(),
            tablerow(),
          ],
        ),
        
        const Padding(
          padding: EdgeInsets.only(top: 40),
          child: Text('Rules', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),),
        ),
        const Text('Weekly Payment will Send as Beans',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400),),
        Table(
          children: [
            TableRow(
              children: [
                headerlabel("Total recharge"),
                headerlabel("Reward Date"),
                headerlabel(
                  "Reward Payment",
                ),
               
              ],
            ),
            tablerow1(),
            tablerow1(),
            tablerow1(),
          
          ],
        ),
        
      ],
    );
  }

  Container headerlabel(txt) {
    return Container(
      height: 50,
      decoration: const BoxDecoration(color: Color(0xffFF9933)),
      child: Text(
        txt,
        style: const TextStyle(fontSize: 12.0, color: Colors.white),
      ),
    );
  }

  TableRow tablerow() {
    return  TableRow(children: [
      textmethod('5/6-11/6'),
      textmethod('  0'),
      textmethod('+inr 0(0)'),
      textmethod('/') 
     
    ]);
  }
  TableRow tablerow1() {
    return  TableRow(children: [
      textmethod('5/6-11/6'),
      textmethod('   0'),
      textmethod('+inr 0(0)'),
      
     
    ]);
  }

  Text textmethod(txt) {
    return Text(
      txt,
      style: const TextStyle(fontSize: 15.0),
    );
  }
}
