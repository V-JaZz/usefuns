import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    double b = a * 0.97;
    return Column(
      children: [
        const SizedBox(height: 30),
        if(user != null) userDetails(a,b,user!),
        if(user != null) const SizedBox(height: 10),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 18),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: TextField(
                  controller: userIdController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      labelText: 'Usefun ID',
                      isDense: true),
                  onChanged: (value) {
                    setState(() {
                      user = null;
                    });
                  },
                  onSubmitted: (value) async {
                    final ud = await Provider.of<UserDataProvider>(context,listen: false).getUser(id: userIdController.text,isUsefunId: true);
                    setState(() {
                      user = ud;
                    });
                  },
                ),
              ),
              InkWell(
                  onTap: () async {
                    final ud = await Provider.of<UserDataProvider>(context,listen: false).getUser(id: userIdController.text,isUsefunId: true);
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
                              color: Colors.black54,
                              offset: Offset(0, 1))
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
          margin: const EdgeInsets.symmetric(horizontal: 18),
          child: const TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'Amount', isDense: true),
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

  Widget userDetails(double a,double b,UserDataModel user) {
    if(user.data == null){
      return const ListTile(
        title: Text('No User Found'),
      );
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12*a, vertical: 3*a),
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 36 * a,
            height: 36 * a,
            decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).primaryColor.withOpacity(0.4),width: 3),
                shape: BoxShape.circle
            ),
            child: user.data!.images!.isEmpty
                ? CircleAvatar(
                foregroundImage:
                const AssetImage('assets/profile.png'),
                radius: 18 * a)
                : CircleAvatar(
                foregroundImage: NetworkImage(
                    user.data!.images
                        ?.first ??
                        ''),
                radius: 18 * a),
          ),
          SizedBox(width: 6*a),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${user.data?.name}',
                textAlign: TextAlign.left,
                style: SafeGoogleFont(
                    color: Colors.black.withOpacity(0.7),
                    'Poppins',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    height: 1),
              ),
              SizedBox(height: 6*a),
            ],
          )
        ],
      ),
    );
  }
}
