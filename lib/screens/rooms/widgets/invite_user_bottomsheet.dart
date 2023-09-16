import 'package:flutter/material.dart';

import 'package:live_app/utils/utils_assets.dart';

class InviteUserBottomSheet extends StatefulWidget {
  const InviteUserBottomSheet({Key? key}) : super(key: key);

  @override
  State<InviteUserBottomSheet> createState() => _InviteUserBottomSheetState();
}

class _InviteUserBottomSheetState extends State<InviteUserBottomSheet> {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 380;
    double a = MediaQuery.of(context).size.width / baseWidth;
    double b = a * 0.97;
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.all(18 * a),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'User List',
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
          Container(
            width: 267 * a,
            height: 26 * a,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(9 * a),
              color: const Color(0xffd9d9d9),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 12 * a,
                ),
                Image.asset(
                  'assets/icons/ic_search.png',
                  width: 12 * a,
                  height: 12 * a,
                  fit: BoxFit.cover,
                ),
                SizedBox(
                  width: 12 * a,
                ),
                Text(
                  'Search Usefuns ID',
                  style: SafeGoogleFont(
                    'Poppins',
                    fontSize: 12 * b,
                    fontWeight: FontWeight.w300,
                    height: 1.5 * b / a,
                    letterSpacing: 0.36 * a,
                    color: const Color(0x99000000),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 32 * a,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(0 * a, 0 * a, 19 * a, 0 * a),
                child: Image.asset(
                  'assets/dummy/g2.png',
                  fit: BoxFit.cover,
                  width: 67 * a,
                  height: 64 * a,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(0 * a, 0 * a, 0 * a, 7 * a),
                      child: Text(
                        'Dimple Ayesha',
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
                    Text(
                      'Welcome to my room,let’s.',
                      style: SafeGoogleFont(
                        'Poppins',
                        fontSize: 12 * b,
                        fontWeight: FontWeight.w400,
                        height: 1.5 * b / a,
                        letterSpacing: 0.48 * a,
                        color: const Color(0x99000000),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 45 * a,
                height: 15 * a,
                margin: EdgeInsets.only(top: 27 * a),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5 * a),
                  color: const Color(0xffffe500),
                ),
                child: Center(
                  child: Text(
                    'Add',
                    style: SafeGoogleFont(
                      'Poppins',
                      fontSize: 10 * b,
                      fontWeight: FontWeight.w400,
                      height: 1.5 * b / a,
                      letterSpacing: 0.4 * a,
                      color: const Color(0xff000000),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 36 * a,
          ),
        ],
      ),
    );
  }
}
