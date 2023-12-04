import 'package:flutter/material.dart';

class BalanceTabView extends StatefulWidget {
  const BalanceTabView({super.key});

  @override
  State<BalanceTabView> createState() => _BalanceTabViewState();
}

class _BalanceTabViewState extends State<BalanceTabView> {
  final amountController = TextEditingController();
  String dropdownValue = 'Select Pay method';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 30),
      DropdownButton<String>(
      value: dropdownValue,
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
          // You can perform actions based on the selected value here
        });
      },
      items: <String>['Select Pay method', 'Direct', 'UPI']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    ),
        const SizedBox(height: 10),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 18),
          child: TextField(
            controller: amountController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
                labelText: 'Amount',
                isDense: true),
            onChanged: (value) {
            },
            onSubmitted: (value) async {
            },
          ),
        ),
        const SizedBox(height: 30),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white
            ),
            onPressed: () {},
            child: const Text('Recharge Now'))
      ],
    );
  }
}
