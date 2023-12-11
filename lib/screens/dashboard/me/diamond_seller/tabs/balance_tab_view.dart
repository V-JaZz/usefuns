import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../../../provider/seller_agency_provider.dart';

class BalanceTabView extends StatefulWidget {
  const BalanceTabView({super.key});

  @override
  State<BalanceTabView> createState() => _BalanceTabViewState();
}

class _BalanceTabViewState extends State<BalanceTabView> {
  final amountController = TextEditingController();
  String dropdownValue = 'Select Pay method';
  String? selectedAmount = '100';

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    return Consumer<SellerAgencyProvider>(
      builder: (context, value, _) => Column(
        children: [
          const SizedBox(height: 30),
          Text('My Balance: ${value.seller?.data?.totalCoins ?? 0}',style: const TextStyle(color: Colors.black),),
          const SizedBox(height: 10),
          DropdownButton<String>(
            value: dropdownValue,
            onChanged: (String? newValue) {
              setState(() {
                dropdownValue = newValue!;
                // You can perform actions based on the selected value here
              });
            },
            style: const TextStyle(color: Colors.black),
            items: <String>['Select Pay method', 'Direct', 'UPI']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          GestureDetector(
            onTap: () async {
              await showDialog(
              context: context,
              builder: (BuildContext context) {
                return amountSelectionList();
              });
              setState(() {amountController.text = selectedAmount??'';});
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 30 * a),
              child: TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.black87),
                decoration: const InputDecoration(
                    labelText: 'Amount',
                    labelStyle: TextStyle(color: Colors.black87),
                    isDense: true,
                  enabled: false,
                  disabledBorder: UnderlineInputBorder(),
                ),
                onChanged: (value) {},
                onSubmitted: (value) async {},
              ),
            ),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.white),
              onPressed: () {},
              child: const Text('Recharge Now'))
        ],
      ),
    );
  }
  amountSelectionList() {
    return StatefulBuilder(
      builder: (BuildContext context, void Function(void Function()) setState) {
        return AlertDialog(
          title: const Text('Select Amount'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ListTile(
                title: const Text('5,000'),
                subtitle: const Text('(81320 + 7%)'),
                leading: Radio(
                  value: '5000',
                  groupValue: selectedAmount,
                  onChanged: (value) {
                    setState(() {
                      selectedAmount = value;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('10,000'),
                subtitle: const Text('(162640 + 7%)'),
                leading: Radio(
                  value: '10000',
                  groupValue: selectedAmount,
                  onChanged: (value) {
                    setState(() {
                      selectedAmount = value;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('30,000'),
                subtitle: const Text('(528960 + 8%)'),
                leading: Radio(
                  value: '30000',
                  groupValue: selectedAmount,
                  onChanged: (value) {
                    setState(() {
                      selectedAmount = value;
                    });
                  },
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Select'),
              onPressed: () {
                Navigator.of(context).pop(selectedAmount);
              },
            ),
          ],
        );
      },
    );
  }
}
