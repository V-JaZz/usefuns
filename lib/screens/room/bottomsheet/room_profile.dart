import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/provider/zego_room_provider.dart';
import 'package:live_app/utils/utils_assets.dart';
import 'package:provider/provider.dart';
import '../widget/room_settings.dart';

class RoomProfileBottomSheet extends StatefulWidget {
  const RoomProfileBottomSheet({Key? key}) : super(key: key);

  @override
  State<RoomProfileBottomSheet> createState() => _RoomProfileBottomSheetState();
}

class _RoomProfileBottomSheetState extends State<RoomProfileBottomSheet> {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double a = MediaQuery.of(context).size.width / baseWidth;
    double b = a * 0.97;
    return Consumer<ZegoRoomProvider>(
      builder: (context, value, child) => Container(
        width: double.infinity,
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 18 * a,
            ),
            SizedBox(
              width: 125 * a,
              height: 24 * a,
              child: Text(
                'Room Profile',
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
              height: 18 * a,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if(value.isOwner)SizedBox(width: 80 * a),
                Container(
                    height: 64 * a,
                    width: 64 * a,
                  decoration: BoxDecoration(
                    image: value.room!.images!.isEmpty
                        ? const DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        'assets/room_icons/ic_room_dp.png',
                      ),
                    )
                        : DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        value.room!.images!.first,
                      ),
                    ),
                  ),
                  child: value.roomPassword != null
                      ?Align(
                    alignment: Alignment.bottomRight,
                    child: SizedBox(
                      width: 24 * a,
                      height: 14 * a,
                      child: Image.asset(
                        'assets/room_icons/lock.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  )
                      :null,
                ),
                if(value.isOwner)SizedBox(width: 40 * a),
                if(value.isOwner)GestureDetector(
                  onTap: () {
                    Get.to(() => const RoomSettings());
                  },
                  child: Column(
                    children: [
                      Icon(Icons.settings,
                          color: const Color(0x99000000), size: 16 * a),
                      Text(
                        'Settings',
                        style: SafeGoogleFont(
                          'Poppins',
                          fontSize: 9 * b,
                          fontWeight: FontWeight.w400,
                          height: 1.5 * b / a,
                          letterSpacing: 0.64 * a,
                          color: const Color(0x99000000),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: 6 * a,
            ),
            Text(
              value.room!.name!,
              style: SafeGoogleFont(
                'Lato',
                fontSize: 12 * b,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: 6 * a,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(0 * a, 0 * a, 9 * a, 0 * a),
                          width: 14 * a,
                          height: 14 * a,
                          child: Image.asset(
                            'assets/icons/ic_diamond.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                        Text(
                          value.room!.totalDiamonds.toString(),
                          style: SafeGoogleFont(
                            'Poppins',
                            fontSize: 9 * b,
                            fontWeight: FontWeight.w400,
                            height: 1.5 * b / a,
                            letterSpacing: 0.36 * a,
                            color: const Color(0xff000000),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'Total Diamond',
                      style: SafeGoogleFont(
                        'Poppins',
                        fontSize: 9 * b,
                        fontWeight: FontWeight.w400,
                        height: 1.5 * b / a,
                        letterSpacing: 0.36 * a,
                        color: const Color(0xff000000),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 19 * a),
                Container(
                  margin: EdgeInsets.fromLTRB(0 * a, 0 * a, 26 * a, 1 * a),
                  width: 1 * a,
                  height: 32 * a,
                  decoration: const BoxDecoration(
                    color: Color(0x66000000),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(0 * a, 0 * a, 9 * a, 0 * a),
                          width: 14 * a,
                          height: 14 * a,
                          child: Image.asset(
                            'assets/room_icons/members.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                        Text(
                          value.activeCount.toString(),
                          style: SafeGoogleFont(
                            'Poppins',
                            fontSize: 9 * b,
                            fontWeight: FontWeight.w400,
                            height: 1.5 * b / a,
                            letterSpacing: 0.36 * a,
                            color: const Color(0xff000000),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'Members',
                      style: SafeGoogleFont(
                        'Poppins',
                        fontSize: 9 * b,
                        fontWeight: FontWeight.w400,
                        height: 1.5 * b / a,
                        letterSpacing: 0.36 * a,
                        color: const Color(0xff000000),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 12 * a,
            ),
            Container(
              margin: EdgeInsets.only(left: 30 * a),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Language',
                    style: SafeGoogleFont(
                      'Poppins',
                      fontSize: 9 * b,
                      fontWeight: FontWeight.w300,
                      height: 1.5 * b / a,
                      letterSpacing: 0.36 * a,
                      color: const Color(0xff000000),
                    ),
                  ),
                  SizedBox(
                    height: 3 * a,
                  ),
                  Text(
                    value.room?.language??'English',
                    style: SafeGoogleFont(
                      'Poppins',
                      fontSize: 12 * b,
                      fontWeight: FontWeight.w400,
                      height: 1.5 * b / a,
                      letterSpacing: 0.48 * a,
                      color: const Color(0xff000000),
                    ),
                  ),
                  SizedBox(
                    height: 12 * a,
                  ),
                  Text(
                    'Country',
                    style: SafeGoogleFont(
                      'Poppins',
                      fontSize: 9 * b,
                      fontWeight: FontWeight.w300,
                      height: 1.5 * b / a,
                      letterSpacing: 0.36 * a,
                      color: const Color(0xff000000),
                    ),
                  ),
                  SizedBox(
                    height: 3 * a,
                  ),
                  Text(
                    value.room?.country??'India',
                    style: SafeGoogleFont(
                      'Poppins',
                      fontSize: 12 * b,
                      fontWeight: FontWeight.w400,
                      height: 1.5 * b / a,
                      letterSpacing: 0.48 * a,
                      color: const Color(0xff000000),
                    ),
                  ),
                  SizedBox(
                    height: 12 * a,
                  ),
                  Text(
                    'Announcement',
                    style: SafeGoogleFont(
                      'Poppins',
                      fontSize: 9 * b,
                      fontWeight: FontWeight.w300,
                      height: 1.5 * b / a,
                      letterSpacing: 0.36 * a,
                      color: const Color(0xff000000),
                    ),
                  ),
                  SizedBox(
                    height: 3 * a,
                  ),
                  Text(
                    (value.room?.announcement??'')==''?'Welcome to my room!':value.room!.announcement!,
                    style: SafeGoogleFont(
                      'Poppins',
                      fontSize: 12 * b,
                      fontWeight: FontWeight.w400,
                      height: 1.5 * b / a,
                      letterSpacing: 0.48 * a,
                      color: const Color(0xff000000),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 24 * a,
            ),
          ],
        ),
      ),
    );
  }
}
