import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/provider/zego_room_provider.dart';
import 'package:live_app/utils/common_widgets.dart';
import 'package:live_app/utils/utils_assets.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:zego_express_engine/zego_express_engine.dart';
import '../../../data/datasource/local/sharedpreferences/storage_service.dart';
import '../../../provider/rooms_provider.dart';
import '../../../provider/user_data_provider.dart';
import '../../../utils/constants.dart';
import '../../../utils/zego_config.dart';
import '../../dashboard/me/profile/user_profile.dart';
import '../widget/kick_room.dart';

class ActiveUsersBottomSheet extends StatefulWidget {
  final String ownerId;
  const ActiveUsersBottomSheet({Key? key, required this.ownerId})
      : super(key: key);

  @override
  State<ActiveUsersBottomSheet> createState() => _ActiveUsersBottomSheetState();
}

class _ActiveUsersBottomSheetState extends State<ActiveUsersBottomSheet> {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 390;
    double a = MediaQuery.of(context).size.width / baseWidth;
    double b = a * 0.97;
    return Consumer<ZegoRoomProvider>(
      builder: (context, value, child) {
        // Reordering the list
        List<String> onSeat =
            value.roomStreamList.map((e) => e.streamId.toString()).toList();
        List<ZegoUser> reorderedUsers = reorderList(
            ownerId: widget.ownerId,
            adminIds: value.zegoRoom!.admins,
            onSeatUsers: onSeat,
            activeUsers: value.roomUsersList);

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
                  'Active Users',
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
              SizedBox(
                width: double.infinity,
                height: Get.height / 3,
                child: ListView.builder(
                  itemCount: reorderedUsers.length,
                  itemBuilder: (context, index) {
                    return FutureBuilder(
                        future: Provider.of<UserDataProvider>(context,
                                listen: false)
                            .getUser(id: reorderedUsers[index].userID),
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
                                    border: Border(
                                        top: BorderSide(
                                            color:
                                                Colors.black.withOpacity(0.06),
                                            width: 1)),
                                  ),
                                  padding: EdgeInsets.all(10 * a),
                                  child: Row(
                                    children: [
                                      Shimmer.fromColors(
                                        baseColor: const Color.fromARGB(
                                            248, 188, 187, 187),
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
                                              image: AssetImage(
                                                  'assets/profile.png'),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Shimmer.fromColors(
                                            baseColor: const Color.fromARGB(
                                                248, 188, 187, 187),
                                            highlightColor: Colors.white,
                                            period: const Duration(seconds: 1),
                                            child: Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * a, 2 * a, 7 * a, 8 * a),
                                              height: 21 * a,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(8)),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ));
                            case ConnectionState.done:
                              if (snapshot.hasError ||
                                  snapshot.data?.status == 0 ||
                                  snapshot.data?.data == null) {
                                return ListTile(
                                  title: Text('Error: ${snapshot.error}'),
                                );
                              } else {
                                final user = snapshot.data!.data;
                                print(
                                    '${reorderedUsers[index].userID.trim() != widget.ownerId.trim()} || ${!value.zegoRoom!.admins.contains(reorderedUsers[index].userID.trim())}');
                                print(reorderedUsers[index].userID.trim() !=
                                        widget.ownerId.trim() &&
                                    !value.zegoRoom!.admins.contains(
                                        reorderedUsers[index].userID.trim()));
                                return Container(
                                  width: double.infinity,
                                  height: 70 * a,
                                  decoration: BoxDecoration(
                                    border: Border(
                                        top: BorderSide(
                                            color:
                                                Colors.black.withOpacity(0.06),
                                            width: 1)),
                                  ),
                                  padding: EdgeInsets.all(10 * a),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap: () async {
                                          final myId = ZegoConfig.instance.streamID;
                                          if(user.id == myId){
                                            Get.to(()=>const UserProfile());
                                            return;
                                          }
                                          final u = await Provider.of<UserDataProvider>(context,listen: false).addVisitor(user.id!);
                                          Get.to(()=>UserProfile(userData: u.data!));
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
                                                        image: AssetImage(
                                                            'assets/profile.png'),
                                                      )
                                                    : DecorationImage(
                                                        fit: BoxFit.cover,
                                                        image: NetworkImage(
                                                            user.images!.first),
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
                                                  color:
                                                      const Color(0xff000000),
                                                ),
                                              ),
                                            ),
                                            userLevelTag(
                                                user.level ?? 0, 17 * a)
                                          ],
                                        ),
                                      ),

                                      //if user is an owner or admin
                                      reorderedUsers[index].userID.trim() ==
                                                  widget.ownerId.trim() ||
                                              value.zegoRoom!.admins.contains(
                                                  reorderedUsers[index]
                                                      .userID
                                                      .trim())
                                          ? Container(
                                              margin:
                                                  EdgeInsets.only(left: 5 * a),
                                              padding: EdgeInsets.fromLTRB(
                                                  5 * a, 0 * a, 6 * a, 0 * a),
                                              height: 18 * a,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        12 * a),
                                                color: reorderedUsers[index]
                                                            .userID
                                                            .trim() ==
                                                        widget.ownerId.trim()
                                                    ? const Color(0xFF138808)
                                                    : const Color(0xffFF9933),
                                              ),
                                              alignment: Alignment.center,
                                              child: Text(
                                                reorderedUsers[index]
                                                            .userID
                                                            .trim() ==
                                                        widget.ownerId.trim()
                                                    ? 'Owner'
                                                    : 'Admin',
                                                style: SafeGoogleFont(
                                                  'Poppins',
                                                  fontSize: 11 * b,
                                                  fontWeight: FontWeight.w400,
                                                  height: 1.5 * b / a,
                                                  letterSpacing: 0.36 * a,
                                                  color:
                                                      const Color(0xffffffff),
                                                ),
                                              ),
                                            )
                                          //if user is on seat
                                          : (onSeat.contains(
                                                  reorderedUsers[index]
                                                      .userID
                                                      .trim())
                                              ? Container(
                                                  margin: EdgeInsets.only(
                                                      left: 5 * a),
                                                  padding: EdgeInsets.fromLTRB(
                                                      5 * a,
                                                      0 * a,
                                                      6 * a,
                                                      0 * a),
                                                  height: 18 * a,
                                                  decoration: BoxDecoration(
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12 * a)),
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    'On Seat',
                                                    style: SafeGoogleFont(
                                                      'Poppins',
                                                      fontSize: 11 * b,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      height: 1.5 * b / a,
                                                      letterSpacing: 0.36 * a,
                                                      color: const Color(
                                                          0xffffffff),
                                                    ),
                                                  ),
                                                )
                                              : const SizedBox.shrink()),
                                      const Spacer(),

                                      Container(
                                        padding: EdgeInsets.fromLTRB(
                                            4 * a, 0 * a, 0 * a, 4 * a),
                                        height: double.infinity,
                                        //if viewer is owner or admin
                                        child: (widget.ownerId.trim() ==
                                                        ZegoConfig.instance
                                                            .streamID ||
                                                    value.zegoRoom!.admins
                                                        .contains(ZegoConfig
                                                            .instance.streamID
                                                            .trim())) &&
                                                user.id! !=
                                                    ZegoConfig.instance.streamID
                                            ? Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  if (!value.zegoRoom!.admins
                                                          .contains(
                                                              reorderedUsers[
                                                                      index]
                                                                  .userID
                                                                  .trim()) &&
                                                      widget.ownerId.trim() ==
                                                          ZegoConfig.instance
                                                              .streamID)
                                                    InkWell(
                                                      onTap: () =>
                                                          _showConfirmationDialog(
                                                              () async {
                                                        final p = Provider.of<
                                                                RoomsProvider>(
                                                            context,
                                                            listen: false);
                                                        final list = value
                                                            .zegoRoom!.admins;
                                                        Get.back();
                                                        if (list.length > 3) {
                                                          showCustomSnackBar(
                                                              'Max Admin limit is 4!',
                                                              context,
                                                              isToaster: true);
                                                        } else {
                                                          list.add(user.id!);
                                                          value.updateAdmin(
                                                              list);
                                                          await p.addAdmin(
                                                              value.room!.id!,
                                                              user.id!);
                                                          p.getAllMine();
                                                        }
                                                      }, user.name),
                                                      child: Icon(
                                                          Icons
                                                              .admin_panel_settings_outlined,
                                                          color: Colors.grey,
                                                          size: 21 * a),
                                                    ),
                                                  if (reorderedUsers[index]
                                                              .userID
                                                              .trim() !=
                                                          widget.ownerId
                                                              .trim() &&
                                                      !value.zegoRoom!.admins
                                                          .contains(
                                                              reorderedUsers[
                                                                      index]
                                                                  .userID
                                                                  .trim()))
                                                    SizedBox(width: 12 * a),
                                                  if (reorderedUsers[index]
                                                              .userID
                                                              .trim() !=
                                                          widget.ownerId
                                                              .trim() &&
                                                      !value.zegoRoom!.admins
                                                          .contains(
                                                              reorderedUsers[
                                                                      index]
                                                                  .userID
                                                                  .trim()))
                                                    InkWell(
                                                      onTap: () {
                                                        kickRoomWidget(context,
                                                            user.name, user.id);
                                                      },
                                                      child: Icon(
                                                          Icons.exit_to_app,
                                                          color: Colors.grey,
                                                          size: 21 * a),
                                                    ),
                                                ],
                                              )
                                            : const SizedBox.shrink(),
                                      ),
                                    ],
                                  ),
                                );
                              }
                          }
                        });
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  List<ZegoUser> reorderList(
      {required String ownerId,
      required List<String> adminIds,
      required List<String> onSeatUsers,
      required List<ZegoUser> activeUsers}) {
    // Reordering the list
    List<ZegoUser> reorderedUsers = [];

    // Adding owner to the top
    ZegoUser? owner =
        activeUsers.firstWhereOrNull((user) => user.userID == ownerId);
    if (owner != null) reorderedUsers.add(owner);

    // Adding admins after the owner
    List<ZegoUser> admins =
        activeUsers.where((user) => adminIds.contains(user.userID)).toList();
    reorderedUsers.addAll(admins);

    // Adding on seat users after owner and admin
    List<ZegoUser> onSeat = activeUsers
        .where((user) =>
            user.userID != ownerId &&
            !adminIds.contains(user.userID) &&
            onSeatUsers.contains(user.userID))
        .toList();
    reorderedUsers.addAll(onSeat);

    // Adding remaining users (excluding owner, admins and on seat users)
    List<ZegoUser> remainingUsers = activeUsers
        .where((user) =>
            user.userID != ownerId &&
            !adminIds.contains(user.userID) &&
            !onSeatUsers.contains(user.userID))
        .toList();
    reorderedUsers.addAll(remainingUsers);

    return reorderedUsers.toList();
  }

  Future<void> _showConfirmationDialog(void Function() onConfirm, name) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          surfaceTintColor: Colors.white,
          shape: const RoundedRectangleBorder(),
          title: Text('Add $name as admin?'),
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
              child: Text('Confirm',
                  style: TextStyle(color: Theme.of(context).primaryColor)),
            ),
          ],
        );
      },
    );
  }
}
