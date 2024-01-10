import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/utils/utils_assets.dart';
import 'package:live_app/utils/zego_config.dart';
import '../../../data/model/response/user_data_model.dart';

class GroupMembersBottomSheet extends StatefulWidget {
  final List<UserData>? members;
  final String owner;
  const GroupMembersBottomSheet({Key? key, required this.members, required this.owner}) : super(key: key);

  @override
  State<GroupMembersBottomSheet> createState() => _GroupMembersBottomSheetState();
}

class _GroupMembersBottomSheetState extends State<GroupMembersBottomSheet> {

  @override
  Widget build(BuildContext context) {
    double baseWidth = 390;
    double a = MediaQuery.of(context).size.width / baseWidth;
    double b = a * 0.97;
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
              'Group Members',
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
          Container(
            width: double.infinity,
            height: Get.height / 3,
            padding: EdgeInsets.all(27 * a),
            alignment: Alignment.topLeft,
            child: widget.members!.isNotEmpty
                ? ListView.builder(
                itemCount: widget.members!.length,
                itemBuilder: (context, index) => Container(
                  width: double.infinity,
                  height: 30 * a,
                  margin: EdgeInsets.only(bottom: 12 * a),
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
                              width: 36 * a,
                              height: 36 * a,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: widget.members![index].images!.isEmpty
                                    ?const DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage('assets/profile.png'),
                                )
                                    :DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(widget.members![index].images!.first),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(
                                  3 * a, 0 * a, 6 * a, 2 * a),
                              child: Text(
                                widget.members?[index].name??'',
                                style: SafeGoogleFont(
                                  'Poppins',
                                  fontSize: 14 * b,
                                  fontWeight: FontWeight.w400,
                                  height: 1.5 * b / a,
                                  letterSpacing: 0.48 * a,
                                  color: const Color(0xff000000),
                                ),
                              ),
                            ),
                            // Container(
                            //   padding: EdgeInsets.fromLTRB(
                            //       5 * a, 0 * a, 6 * a, 0 * a),
                            //   height: 15 * a,
                            //   decoration: BoxDecoration(
                            //     color: const Color(0xff4285f4),
                            //     borderRadius: BorderRadius.circular(9 * a),
                            //   ),
                            //   child: Row(
                            //     crossAxisAlignment:
                            //     CrossAxisAlignment.center,
                            //     children: [
                            //       Container(
                            //         margin: EdgeInsets.fromLTRB(
                            //             0 * a, 0 * a, 4 * a, 1 * a),
                            //         width: 11 * a,
                            //         height: 11 * a,
                            //         child: Image.asset(
                            //           'assets/room_icons/blue_diamond.png',
                            //           fit: BoxFit.cover,
                            //         ),
                            //       ),
                            //       Text(
                            //         'L.v 5',
                            //         style: SafeGoogleFont(
                            //           'Poppins',
                            //           fontSize: 11 * b,
                            //           fontWeight: FontWeight.w400,
                            //           height: 1.5 * b / a,
                            //           letterSpacing: 0.36 * a,
                            //           color: const Color(0xffffffff),
                            //         ),
                            //       ),
                            //     ],
                            //     ],
                            //   ),
                            // )
                          ],
                        ),
                      ),
                      const Spacer(),
                      widget.members![index].id!.trim() != widget.owner.trim()//if member is not an owner
                          ? Container(
                        padding: EdgeInsets.fromLTRB(
                            4 * a, 6 * a, 0 * a, 10 * a),
                        height: double.infinity,
                        child: widget.owner.trim() == ZegoConfig.instance.userID?//if viewer is owner
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.person_add,
                                color: Colors.grey, size: 18 * a),
                            SizedBox(width: 12 * a),
                            InkWell(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Dialog(
                                      backgroundColor: Colors.white,
                                      shape: ShapeBorder.lerp(
                                          InputBorder.none,
                                          InputBorder.none,
                                          0),
                                      child: Container(
                                        width: 280 * a,
                                        padding: EdgeInsets.all(21 * a),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(
                                                7 * a)),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              'Confirm to Kick Simple Boy Out Of the Group?',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 14 * a),
                                            ),
                                            SizedBox(height: 9 * a),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons
                                                      .radio_button_off_rounded,
                                                  size: 16 * a,
                                                ),
                                                SizedBox(width: 9 * a),
                                                Expanded(
                                                  child: Text(
                                                    "Permanently Block him and forbid him from entering Your group",
                                                    style: TextStyle(
                                                        color: const Color(
                                                            0x99000000),
                                                        fontWeight:
                                                        FontWeight.w300,
                                                        fontSize: 14 * a),
                                                  ),
                                                )
                                              ],
                                            ),
                                            SizedBox(height: 24 * a),
                                            Container(
                                              height: 20 * a,
                                              width: 140 * a,
                                              decoration: BoxDecoration(
                                                  color: const Color(
                                                      0xFFFF9933),
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      12 * a)),
                                              child: Center(
                                                child: Text(
                                                  "Confirm",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                      FontWeight.w300,
                                                      fontSize: 14 * a),
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 12 * a),
                                            InkWell(
                                              onTap: () {
                                                Get.back();
                                              },
                                              child: Text(
                                                "Cancel",
                                                style: TextStyle(
                                                    color: const Color(
                                                        0x99000000),
                                                    fontWeight:
                                                    FontWeight.w300,
                                                    fontSize: 14 * a),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Icon(Icons.exit_to_app,
                                  color: Colors.grey, size: 18 * a),
                            ),
                          ],
                        ) : const SizedBox.shrink(),
                      )
                          : Container(
                        padding: EdgeInsets.fromLTRB(5 * a, 0 * a, 6 * a, 0 * a),
                        height: 15 * a,
                        decoration: const BoxDecoration(
                          color: Color(0xffFF9933),
                        ),
                        child: Text(
                          'Owner',
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
                    ],
                  ),
                ),
              )
                :const Center(child: Text('No members yet!'),),
          ),
        ],
      ),
    );
  }
}
