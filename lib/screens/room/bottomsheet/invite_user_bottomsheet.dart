import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/provider/zego_room_provider.dart';
import 'package:live_app/utils/common_widgets.dart';

import 'package:live_app/utils/utils_assets.dart';
import 'package:live_app/utils/zego_config.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:zego_express_engine/zego_express_engine.dart';

import '../../../provider/user_data_provider.dart';

class InviteUserBottomSheet extends StatefulWidget {
  final int seat;
  final String ownerId;
  const InviteUserBottomSheet({Key? key, required this.ownerId, required this.seat}) : super(key: key);
  @override
  State<InviteUserBottomSheet> createState() => _InviteUserBottomSheetState();
}

class _InviteUserBottomSheetState extends State<InviteUserBottomSheet> {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 380;
    double a = MediaQuery.of(context).size.width / baseWidth;
    double b = a * 0.97;
    return Consumer<ZegoRoomProvider>(
      builder: (context, value, child) {
        List<String> onSeat =  value.roomStreamList.map((e) => e.streamId.toString()).toList();
        List<ZegoUser> activeNotOnSeat = value.roomUsersList.where((e) => !onSeat.contains(e.userID)).toList();
        List<ZegoUser> reorderedUsers = reorderList(ownerId: widget.ownerId,adminIds: value.room!.admin!, activeNotOnSeat: activeNotOnSeat);

        return Container(
        width: double.infinity,
        color: Colors.white,
        padding: EdgeInsets.all(18 * a),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Invite User',
              style: SafeGoogleFont(
                'Poppins',
                fontSize: 18 * b,
                fontWeight: FontWeight.w400,
                height: 1.5 * b / a,
                letterSpacing: 0.64 * a,
                color: const Color(0xff000000),
              ),
            ),
            SizedBox(
              height: 12 * a,
            ),
            // Container(
            //   width: 267 * a,
            //   height: 26 * a,
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(9 * a),
            //     color: const Color(0xffd9d9d9),
            //   ),
            //   child: Row(
            //     children: [
            //       SizedBox(
            //         width: 12 * a,
            //       ),
            //       Image.asset(
            //         'assets/icons/ic_search.png',
            //         width: 12 * a,
            //         height: 12 * a,
            //         fit: BoxFit.cover,
            //       ),
            //       SizedBox(
            //         width: 12 * a,
            //       ),
            //       Text(
            //         'Search Usefuns ID',
            //         style: SafeGoogleFont(
            //           'Poppins',
            //           fontSize: 12 * b,
            //           fontWeight: FontWeight.w300,
            //           height: 1.5 * b / a,
            //           letterSpacing: 0.36 * a,
            //           color: const Color(0x99000000),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            // SizedBox(
            //   height: 32 * a,
            // ),
            reorderedUsers.isNotEmpty
                ? SizedBox(
              width: double.infinity,
              height: Get.height / 3,
              child: ListView.builder(
                itemCount: reorderedUsers.length,
                itemBuilder: (context, index) {
                  return FutureBuilder(
                      future: Provider.of<UserDataProvider>(context,listen: false).getUser(id: reorderedUsers[index].userID),
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
                                          userLevelTag(user.level??0,15 * a)
                                        ],
                                      ),
                                    ),

                                    //if user is an owner or admin
                                    if(reorderedUsers[index].userID.trim() == widget.ownerId.trim() || value.room!.admin!.contains(reorderedUsers[index].userID.trim()))
                                      Container(
                                        margin: EdgeInsets.only(left: 5*a),
                                        padding: EdgeInsets.fromLTRB(5 * a, 0 * a, 6 * a, 0 * a),
                                        height: reorderedUsers[index].userID.trim() == widget.ownerId.trim() ?18 * a:16 * a,
                                        decoration: BoxDecoration(
                                          color: reorderedUsers[index].userID.trim() == widget.ownerId.trim()?const Color(0xFF138808):const Color(0xffFF9933),
                                        ),
                                        alignment: Alignment.center,
                                        child: Text(
                                          reorderedUsers[index].userID.trim() == widget.ownerId.trim() ? 'Owner' : 'Admin',
                                          style: SafeGoogleFont(
                                            'Poppins',
                                            fontSize: 11 * b,
                                            fontWeight: FontWeight.w400,
                                            height: 1.5 * b / a,
                                            letterSpacing: 0.36 * a,
                                            color: const Color(0xffffffff),
                                          ),
                                        ),
                                      ),
                                    const Spacer(),
                                    IconButton(
                                        onPressed: (){
                                          value.inviteSeat(user.id!,user.name!,widget.seat.toString());
                                          Get.back();
                                          showCustomSnackBar('Invitation Sent!', context, isToaster: true, isError: false);
                                        },
                                        icon: Icon(Icons.add_circle,color: const Color(0xff4285f4),size: 27*a)
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
            )
                : SizedBox(
              height: Get.width/4,
              child: Center(
                child: Text(
                  value.roomUsersList.length>1?'None Unseated Active User!':'No Active User!'
                ),
              ),
            ),
          ],
        ),
      );
      },
    );
  }

  List<ZegoUser> reorderList(
      {required String ownerId, required List<String> adminIds, required List<ZegoUser> activeNotOnSeat}) {
    //Remove the viewer
    activeNotOnSeat.removeWhere((e) => e.userID == ZegoConfig.instance.streamID);

    // Reordering the list
    List<ZegoUser> reorderedUsers = [];

    // Adding owner to the top
    ZegoUser? owner = activeNotOnSeat.firstWhereOrNull((user) => user.userID == ownerId);
    if(owner!=null)reorderedUsers.add(owner);

    // Adding admins after the owner
    List<ZegoUser> admins = activeNotOnSeat.where((user) => adminIds.contains(user.userID)).toList();
    reorderedUsers.addAll(admins);

    // Adding remaining users (excluding owner and admins)
    List<ZegoUser> remainingUsers = activeNotOnSeat.where((user) => user.userID != ownerId && !adminIds.contains(user.userID)).toList();
    reorderedUsers.addAll(remainingUsers);

    return reorderedUsers.toSet().toList();
  }

}
