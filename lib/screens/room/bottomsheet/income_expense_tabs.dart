import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/utils/utils_assets.dart';



class IncomeExpense extends StatefulWidget {
  const IncomeExpense({Key? key}) : super(key: key);

  @override
  State<IncomeExpense> createState() => _IncomeExpenseState();
}

class _IncomeExpenseState extends State<IncomeExpense> {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    double b = a * 0.97;
    return Container(
      color: Colors.white,
      child: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            TabBar(
              indicatorColor: Colors.black,
              indicatorWeight: 1.3,
              labelColor: const Color(0xff000000),
              dividerColor: Colors.transparent,
              unselectedLabelColor: const Color(0x99000000),
              labelStyle: SafeGoogleFont(
                'Poppins',
                fontSize: 16 * b,
                fontWeight: FontWeight.w400,
                height: 1.5 * b / a,
                letterSpacing: 0.96 * a,
                color: const Color(0xff000000),
              ),
              unselectedLabelStyle: SafeGoogleFont(
                'Poppins',
                fontSize: 16 * b,
                fontWeight: FontWeight.w400,
                height: 1.5 * b / a,
                letterSpacing: 0.96 * a,
                color: const Color(0x99000000),
              ),
              padding: EdgeInsets.symmetric(horizontal: 30 * a),
              labelPadding: EdgeInsets.zero,
              tabs: const [
                Tab(
                  text: "Income",
                ),
                Tab(
                  text: "Expenditure",
                )
              ],
            ),
            Expanded(
              child: TabBarView(children: [
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 18 * a, vertical: 8 * a),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 50 * a,
                      ),
                      Image.asset(
                        "assets/icons/ic_empty.png",
                        width: Get.width / 3,
                        height: Get.width / 3,
                      ),
                      Text(
                        'Oops, Currently Empty',
                        style: SafeGoogleFont(
                          'Poppins',
                          fontSize: 16 * b,
                          fontWeight: FontWeight.w400,
                          height: 1.5 * b / a,
                          letterSpacing: 0.64 * a,
                          color: const Color(0xff000000),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 18 * a, vertical: 8 * a),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 50 * a,
                      ),
                      Image.asset(
                        "assets/icons/ic_empty.png",
                        width: Get.width / 3,
                        height: Get.width / 3,
                      ),
                      Text(
                        'Oops, Currently Empty',
                        style: SafeGoogleFont(
                          'Poppins',
                          fontSize: 16 * b,
                          fontWeight: FontWeight.w400,
                          height: 1.5 * b / a,
                          letterSpacing: 0.64 * a,
                          color: const Color(0xff000000),
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
