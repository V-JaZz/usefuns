import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/provider/zego_room_provider.dart';
import 'package:live_app/utils/common_widgets.dart';
import 'package:live_app/utils/utils_assets.dart';
import 'package:provider/provider.dart';
import '../../../data/model/response/user_data_model.dart';
import '../../../provider/rooms_provider.dart';
import '../../dashboard/me/profile/user_profile.dart';
import '../widget/kick_room.dart';
import 'manager.dart';

class ActiveUsersBottomSheet extends StatefulWidget {
  final String ownerId;
  final ScrollController controller;
  const ActiveUsersBottomSheet({Key? key, required this.ownerId, required this.controller})
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
        List<UserData> reorderedUsers = reorderList(
            ownerId: widget.ownerId,
            adminIds: value.room!.admin!,
            onSeatUsers: onSeat,
            activeUsers: value.roomUsersList);

        return Container(
          color: Colors.white,
          child: Column(
            children: [
              SizedBox(
                height: 12 * a,
              ),
              SizedBox(
                height: 24 * a,
                child: Text(
                  'Active Users',
                  style: safeGoogleFont(
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
              Expanded(
                child: ListView.builder(
                  controller: widget.controller,
                  itemCount: reorderedUsers.length,
                  itemBuilder: (context, index) {
                    final user = reorderedUsers[index];
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
                            onTap: () {
                              final myId = value.userID;
                              Get.back();
                              if (user.id == myId) {
                                Get.to(() => const UserProfile());
                                return;
                              }
                              LiveRoomBottomSheets(context)
                                  .showAudienceBottomSheet(
                                user: user,
                                admin: value.room?.admin?.contains(myId)??false,
                                owner: value.room?.userId == myId
                              );
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
                                    image: user.images!.isEmpty
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
                                    style: safeGoogleFont(
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
                          reorderedUsers[index].id!.trim() ==
                              widget.ownerId.trim() ||
                              value.room!.admin!.contains(
                                  reorderedUsers[index]
                                      .id!
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
                                  .id!
                                  .trim() ==
                                  widget.ownerId.trim()
                                  ? const Color(0xFF138808)
                                  : const Color(0xffFF9933),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              reorderedUsers[index]
                                  .id!
                                  .trim() ==
                                  widget.ownerId.trim()
                                  ? 'Owner'
                                  : 'Admin',
                              style: safeGoogleFont(
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
                                  .id!
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
                              style: safeGoogleFont(
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
                                value.userID ||
                                value.room!.admin!.contains(
                                    value.userID
                                        .trim())) &&
                                user.id! !=
                                    value.userID
                                ? Row(
                              crossAxisAlignment:
                              CrossAxisAlignment.center,
                              children: [
                                if (!value.room!.admin!
                                    .contains(
                                    reorderedUsers[
                                    index]
                                        .id!
                                        .trim()) &&
                                    widget.ownerId.trim() ==
                                        value.userID)
                                  InkWell(
                                    onTap: () =>
                                        _showConfirmationDialog(
                                                () async {
                                              Get.back();
                                              if (value.room!.admin!
                                                  .length >=
                                                  20) {
                                                showCustomSnackBar(
                                                    'Maximum admin limit is 20!',
                                                    context);
                                              } else {
                                                final p = Provider.of<
                                                    RoomsProvider>(
                                                    Get.context!,
                                                    listen: false);
                                                value.room!.admin!
                                                    .add(user.id!);
                                                await p.addAdmin(
                                                    value.room!.id!,
                                                    user.id!);
                                                value.updateAdminList();
                                              }
                                            }, user.name),
                                    child: Icon(
                                        Icons
                                            .admin_panel_settings_outlined,
                                        color: Colors.grey,
                                        size: 21 * a),
                                  ),
                                if (reorderedUsers[index]
                                    .id!
                                    .trim() !=
                                    widget.ownerId
                                        .trim() &&
                                    !value.room!.admin!
                                        .contains(
                                        reorderedUsers[
                                        index]
                                            .id!
                                            .trim()))
                                  SizedBox(width: 12 * a),
                                if (reorderedUsers[index]
                                    .id!
                                    .trim() !=
                                    widget.ownerId
                                        .trim() &&
                                    !value.room!.admin!
                                        .contains(
                                        reorderedUsers[
                                        index]
                                            .id!
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
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  List<UserData> reorderList(
      {required String ownerId,
      required List<String> adminIds,
      required List<String> onSeatUsers,
      required List<UserData> activeUsers}) {
    // Reordering the list
    List<UserData> reorderedUsers = [];

    // Adding owner to the top
    UserData? owner =
        activeUsers.firstWhereOrNull((user) => user.id == ownerId);
    if (owner != null) reorderedUsers.add(owner);

    // Adding admins after the owner
    List<UserData> admins =
        activeUsers.where((user) => adminIds.contains(user.id)).toList();
    reorderedUsers.addAll(admins);

    // Adding on seat users after owner and admin
    List<UserData> onSeat = activeUsers
        .where((user) =>
            user.id != ownerId &&
            !adminIds.contains(user.id) &&
            onSeatUsers.contains(user.id))
        .toList();
    reorderedUsers.addAll(onSeat);

    // Adding remaining users (excluding owner, admins and on seat users)
    List<UserData> remainingUsers = activeUsers
        .where((user) =>
            user.id != ownerId &&
            !adminIds.contains(user.id) &&
            !onSeatUsers.contains(user.id))
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
