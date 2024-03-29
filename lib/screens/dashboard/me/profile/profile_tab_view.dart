import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/screens/dashboard/me/profile/ranking.dart';
import '../../../../data/model/response/user_data_model.dart';
import '../../../../utils/utils_assets.dart';

class ProfileTabView extends StatefulWidget {
  final UserData userData;
  const ProfileTabView({super.key, required this.userData});

  @override
  State<ProfileTabView> createState() => _ProfileTabViewState();
}

class _ProfileTabViewState extends State<ProfileTabView> {
  late UserData userData;
  @override
  void initState() {
    userData = widget.userData;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    double b = a * 0.97;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 15 * a,
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                '   About me',
                style: safeGoogleFont(
                    color: const Color.fromRGBO(0, 0, 0, 1),
                    'Poppins',
                    fontSize: 12 * a,
                    fontWeight: FontWeight.w500,
                    height: 1 * b / a),
              ),
            ),
            SizedBox(
              height: 10 * a,
            ),
            SizedBox(
              width: Get.width,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '    Bio  :  ',
                    style: safeGoogleFont(
                        color: const Color.fromRGBO(0, 0, 0, 1),
                        'Poppins',
                        fontSize: 13 * a,
                        fontWeight: FontWeight.w300,
                        height: 1 * b / a),
                  ),
                  Expanded(
                    child: Text(
                      '${userData.bio}',
                      style: safeGoogleFont(
                          color: Colors.black87,
                          'Poppins',
                          fontSize: 12 * a,
                          fontWeight: FontWeight.w300,
                          height: 1 * b / a),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Top Supporters',
                    style: safeGoogleFont(
                        color: const Color.fromRGBO(0, 0, 0, 1),
                        'Poppins',
                        fontSize: 12 * a,
                        fontWeight: FontWeight.w500,
                        height: 1 * a),
                  ),
                  Row(
                    children: [
                      Text(
                        'More',
                        style: safeGoogleFont(
                            color: const Color.fromRGBO(0, 0, 0, 1),
                            'Poppins',
                            fontSize: 12 * a,
                            fontWeight: FontWeight.w500,
                            height: 1 * a),
                      ),
                      IconButton(
                          onPressed: () {
                            // Get.to(() => Ranking());
                          },
                          icon: Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 14 * a,
                          ))
                    ],
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 10, left: 16),
              child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CircleAvatar(
                          foregroundImage: AssetImage('assets/dummy/g1.png')),
                      CircleAvatar(
                          foregroundImage: AssetImage('assets/dummy/g2.png')),
                      CircleAvatar(
                          foregroundImage: AssetImage('assets/dummy/g3.png')),
                    ],
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Room'),
                  Row(
                    children: [
                      Text(
                        'Go',
                        style: safeGoogleFont(
                            color: const Color.fromRGBO(0, 0, 0, 1),
                            'Poppins',
                            fontSize: 12 * a,
                            fontWeight: FontWeight.w500,
                            height: 1 * a),
                      ),
                      IconButton(
                          onPressed: () {
                            Get.to(() => const RankingPage());
                          },
                          icon: const Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 14,
                          ))
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'My CLub',
                    style: safeGoogleFont(
                        color: const Color.fromRGBO(0, 0, 0, 1),
                        'Poppins',
                        fontSize: 12 * a,
                        fontWeight: FontWeight.w500,
                        height: 1 * a),
                  ),
                  Row(
                    children: [
                      Text(
                        'More',
                        style: safeGoogleFont(
                            color: const Color.fromRGBO(0, 0, 0, 1),
                            'Poppins',
                            fontSize: 12 * a,
                            fontWeight: FontWeight.w500,
                            height: 1 * a),
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 14,
                          ))
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
