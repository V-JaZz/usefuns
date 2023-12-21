import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/provider/seller_agency_provider.dart';

import 'package:live_app/utils/utils_assets.dart';
import 'package:provider/provider.dart';

import '../../../data/model/response/notification_model.dart';
import '../../../provider/messages_provider.dart';
import '../../../provider/user_data_provider.dart';

class System extends StatelessWidget {
  const System({super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    double b = a * 0.97;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0x339E26BC),
        automaticallyImplyLeading: true,
        centerTitle: true,
        elevation: 1,
        title: const Text('System'),
      ),
      body: Consumer<MessagesProvider>(
        builder: (context, value, _) => Padding(
          padding: EdgeInsets.all(18.0 * a),
          child: Column(
            children: [
              if((value.notifications?.data??[]).isEmpty)
                const Center(child: Text('No Notifications yet!')),
              for (NotificationData m in value.notifications?.data??[])
                Column(
                  children: [
                    ListTile(
                      onTap: () {},
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      leading: CircleAvatar(
                        backgroundColor: const Color(0xFFFF9933),
                        radius: 15 * a,
                        child: const Icon(
                          Icons.notifications_none,
                          color: Colors.white,
                        ),
                      ),
                      title: Text(
                        'Agency Invite',
                        style: SafeGoogleFont(
                          'Poppins',
                          fontSize: 15 * b,
                          fontWeight: FontWeight.w400,
                          height: 1.5 * b / a,
                          letterSpacing: 0.6 * a,
                          color: const Color(0xff000000),
                        ),
                      ),
                      subtitle: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${m.message}, your request will be send to admins and once approved you are ready to earn target based reward and salary",
                                maxLines: 10,
                                overflow: TextOverflow.ellipsis,
                                style: SafeGoogleFont('Poppins',
                                    fontSize: 10 * b,
                                    height: 1.5 * b / a,
                                    letterSpacing: 0.4 * a,
                                    color: Colors.black.withOpacity(0.54)),
                              ),
                              Text(
                                '5 hours ago',
                                maxLines: 10,
                                overflow: TextOverflow.ellipsis,
                                style: SafeGoogleFont(
                                  'Poppins',
                                  fontSize: 10 * b,
                                  fontWeight: FontWeight.w300,
                                  height: 1.5 * b / a,
                                  letterSpacing: 0.4 * a,
                                  color: const Color(0x99000000),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    if (m.message!.contains('invited to join the host'))
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                  foregroundColor: Colors.white),
                              onPressed: () async {
                                String uid = Provider.of<UserDataProvider>(context,listen: false).userData!.data!.userId!;
                                String code = m.message!.split(' ').first;
                                final model = await Provider.of<SellerAgencyProvider>(context,listen: false).addHost(uid,code);
                                if(model.status==1) value.deleteNotification(m.id!,uid);
                              },
                              child: const Text('Accept')),
                          SizedBox(width: 18 * a),
                          ElevatedButton(
                              onPressed: () {
                                String uid = Provider.of<UserDataProvider>(context,listen: false).userData!.data!.userId!;
                                value.deleteNotification(m.id!,uid);
                              },
                              child: const Text('Decline'))
                        ],
                      ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
