import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/provider/zego_room_provider.dart';
import 'package:live_app/utils/utils_assets.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../../provider/rooms_provider.dart';
import '../../../provider/user_data_provider.dart';
import '../../../utils/common_widgets.dart';

class AdminsBottomSheet extends StatefulWidget {
  const AdminsBottomSheet({Key? key}) : super(key: key);

  @override
  State<AdminsBottomSheet> createState() => _AdminsBottomSheetState();
}

class _AdminsBottomSheetState extends State<AdminsBottomSheet> {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 390;
    double a = MediaQuery.of(context).size.width / baseWidth;
    double b = a * 0.97;
    return Consumer<ZegoRoomProvider>(
      builder: (context, value, child) {
        final admins = value.room!.admin!;
        return Container(
          color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 12 * a,
              ),
              SizedBox(
                height: 24 * a,
                child: Text(
                  'Room Admins',
                  style: SafeGoogleFont(
                    'Poppins',
                    fontSize: 16 * b,
                    fontWeight: FontWeight.w400,
                    height: 1.5 * b / a,
                    letterSpacing: 0.64 * a,
                    color: const Color(0xff000000),
                  ),
                ),
              ),
              SizedBox(
                height: 12 * a,
              ),
            admins.isEmpty
            ? SizedBox(
              height: 210*a,
              child: const Center(child: Text('No Room Admins!')),
            )
             : SizedBox(
                width: double.infinity,
                height: Get.height / 3,
                child: ListView.builder(
                  itemCount: admins.length,
                  itemBuilder: (context, index) {
                    return FutureBuilder(
                        future: Provider.of<UserDataProvider>(context,listen: false).getUser(id: admins[index]),
                        builder: (context, snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.none:
                              return const Text('none...');
                            case ConnectionState.active:
                              return const Text('active...');
                            case ConnectionState.waiting:
                              return Container(
                                  width: double.infinity,
                                  height: 70 * a,
                                  decoration: BoxDecoration(
                                    border: Border(top: BorderSide(color: Colors.black.withOpacity(0.06),width: 1)),
                                  ),
                                  padding: EdgeInsets.all(10*a),
                                  child: Row(
                                    children: [
                                      Shimmer.fromColors(
                                        baseColor: const Color.fromARGB(248, 188, 187, 187),
                                        highlightColor: Colors.white,
                                        period: const Duration(seconds: 1),
                                        child: Container(
                                          margin: EdgeInsets.fromLTRB(
                                              0 * a, 0 * a, 12 * a, 0 * a),
                                          width: 50 * a,
                                          height: 50 * a,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: AssetImage('assets/profile.png'),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Shimmer.fromColors(
                                            baseColor: const Color.fromARGB(248, 188, 187, 187),
                                            highlightColor: Colors.white,
                                            period: const Duration(seconds: 1),
                                            child: Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * a, 2 * a, 7 * a, 8 * a),
                                              height: 21 * a,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius.circular(8)
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                              );
                            case ConnectionState.done:
                              if (snapshot.hasError || snapshot.data?.status==0 || snapshot.data==null) {
                                return ListTile(
                                  title: Text('Error: ${snapshot.error}'),
                                );
                              }else {
                                final user = snapshot.data!.data;
                                return Container(
                                  width: double.infinity,
                                  height: 70 * a,
                                  decoration: BoxDecoration(
                                    border: Border(top: BorderSide(color: Colors.black.withOpacity(0.06),width: 1)),
                                  ),
                                  padding: EdgeInsets.all(10*a),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          // showModalBottomSheet(
                                          //     context: context,
                                          //     builder: (BuildContext context) {
                                          //       return Container(
                                          //
                                          //       );
                                          //     });
                                        },
                                        child: Row(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * a, 0 * a, 7 * a, 0 * a),
                                              width: 50 * a,
                                              height: 50 * a,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                image: user!.images!.isEmpty
                                                    ? const DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: AssetImage('assets/profile.png'),
                                                )
                                                    :DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(user.images!.first),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  3 * a, 0 * a, 6 * a, 2 * a),
                                              child: Text(
                                                user.name.toString(),
                                                style: SafeGoogleFont(
                                                  'Poppins',
                                                  fontSize: 15 * b,
                                                  fontWeight: FontWeight.w400,
                                                  height: 1.5 * b / a,
                                                  letterSpacing: 0.48 * a,
                                                  color: const Color(0xff000000),
                                                ),
                                              ),
                                            ),
                                            userLevelTag(user.level??0,16 * a)
                                          ],
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: ()=> _showConfirmationDialog(
                                                  () async {
                                                    final p = Provider.of<RoomsProvider>(context,listen: false);
                                                    Get.back();
                                                    value.room!.admin!.remove(admins[index]);
                                                    await p.removeAdmin(value.room!.id!,admins[index]);
                                                    value.updateAdminList();
                                                  },
                                          user.name
                                                ),
                                        icon: const Icon(
                                          Icons.remove_circle_outline_rounded,
                                          color: Colors.deepOrangeAccent,
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              }
                          }
                        }
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _showConfirmationDialog(void Function() onConfirm, name) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          surfaceTintColor: Colors.white,
          shape: const RoundedRectangleBorder(),
          title: Text('Remove $name as admin?'),
          titleTextStyle: const TextStyle(fontSize: 16,color: Colors.black),
          actionsPadding: const EdgeInsets.all(3),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel',style: TextStyle(color: Colors.black54)),
            ),
            TextButton(
              onPressed: onConfirm,
              child: const Text('Confirm',style: TextStyle(color: Colors.deepOrangeAccent)),
            ),
          ],
        );
      },
    );
  }
}
