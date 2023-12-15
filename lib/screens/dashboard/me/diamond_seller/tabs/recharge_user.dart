import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/provider/seller_agency_provider.dart';
import 'package:live_app/utils/common_widgets.dart';
import 'package:provider/provider.dart';
import '../../../../../data/model/response/user_data_model.dart';
import '../../../../../provider/user_data_provider.dart';
import '../../../../../utils/utils_assets.dart';

class RechargeUserTabView extends StatefulWidget {
  const RechargeUserTabView({super.key});

  @override
  State<RechargeUserTabView> createState() => _RechargeUserTabViewState();
}

class _RechargeUserTabViewState extends State<RechargeUserTabView> {
  UserDataModel? user;
  TextEditingController userIdController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    double b = a * 0.97;
    return Column(
      children: [
        const SizedBox(height: 30),
        user != null
            ? userDetails(a, b, user!)
            : Container(
                margin: EdgeInsets.symmetric(horizontal: 30 * a),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: userIdController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                            labelText: 'Usefun ID', isDense: true),
                      ),
                    ),
                    InkWell(
                        onTap: () async {
                          final ud = await Provider.of<UserDataProvider>(
                                  context,
                                  listen: false)
                              .getUser(
                                  id: userIdController.text, isUsefunId: true);
                          setState(() {
                            user = ud;
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 0.5),
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black54, offset: Offset(0, 1))
                              ]),
                          width: 81,
                          height: 42,
                          child: Center(
                            child: Text(
                              'Confirm',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ))
                  ],
                ),
              ),
        const SizedBox(height: 10),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 30 * a),
          child: TextField(
            controller: amountController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Amount', isDense: true),
          ),
        ),
        const SizedBox(height: 30),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white),
            onPressed: () {
              if(userIdController.text.isEmpty){
                showCustomSnackBar('Enter User ID!', context);
              }else if(user==null){
                showCustomSnackBar('Please Confirm User!', context);
              }else if(amountController.text.isEmpty){
                showCustomSnackBar('Enter Amount!', context);
              }else{
                Provider.of<SellerAgencyProvider>(context,listen: false).rechargeUser(
                    userIdController.text,
                  amountController.text
                ).then((value) {
                  if(value.status == 1){
                    showCustomSnackBar(value.message, context,isError: false);
                    clear();
                  }else{
                    showCustomSnackBar(value.message, context);
                  }
                });
              }
            },
            child: Text(
                Provider.of<SellerAgencyProvider>(context,listen: false).loadingUserRecharge
                    ? 'Please Wait..'
                    : 'Recharge Now',
            ))
      ],
    );
  }

  Widget userDetails(double a, double b, UserDataModel user) {
    if (user.data == null) {
      return ListTile(
          title: Text('User ID Not Found - ${userIdController.text}'),
          trailing: IconButton(
              onPressed: () {
                clear();
              },
              icon: const Icon(Icons.refresh, color: Colors.deepOrangeAccent)));
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12 * a, vertical: 3 * a),
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 36 * a,
            height: 36 * a,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black54, width: 1),
                shape: BoxShape.circle),
            child: user.data!.images!.isEmpty
                ? CircleAvatar(
                    foregroundImage: const AssetImage('assets/profile.png'),
                    radius: 18 * a)
                : CircleAvatar(
                    foregroundImage:
                        NetworkImage(user.data!.images?.first ?? ''),
                    radius: 18 * a),
          ),
          SizedBox(width: 6 * a),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${user.data?.name} (${user.data?.userId})',
                textAlign: TextAlign.left,
                style: SafeGoogleFont(
                    color: Colors.black.withOpacity(0.7),
                    'Poppins',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    height: 1),
              ),
              SizedBox(height: 3 * a),
              Text(
                '${user.data?.diamonds} Diamonds',
                textAlign: TextAlign.left,
                style: SafeGoogleFont(
                    color: Colors.black.withOpacity(0.7),
                    'Poppins',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    height: 1),
              ),
            ],
          ),
          const Spacer(),
          IconButton(
              onPressed: () {
                clear();
              },
              icon: const Icon(Icons.delete, color: Colors.deepOrangeAccent)),
          SizedBox(width: 6 * a),
        ],
      ),
    );
  }

  void clear() {
    setState(() {
      user = null;
      amountController.clear();
      userIdController.clear();
    });
  }
}