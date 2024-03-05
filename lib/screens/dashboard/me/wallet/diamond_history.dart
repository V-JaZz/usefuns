import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DiamondHistory extends StatefulWidget {
  const DiamondHistory({super.key});

  @override
  State<DiamondHistory> createState() => _DiamondHistoryState();
}

class _DiamondHistoryState extends State<DiamondHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: Get.height,
        width: Get.width,
        child: ListView(
          padding: const EdgeInsets.only(top: 0),
          physics: const BouncingScrollPhysics(),
          children: List.generate(10, (i) {
            return InkWell(
              onTap: () {
                // showReportInfo(reports![i]);
              },
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 6),
                padding: const EdgeInsets.symmetric(
                    vertical: 8, horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: const Color(0xffF3F4F6),
                      width: 1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    regularText(
                        "createdAt",
                        Colors.grey,
                        14),
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            boldText(
                                '₹13423',
                                const Color(0xff1D3A70),
                                18),
                            const SizedBox(height: 4),
                            mediumText(
                                'txnid.toString()',
                                const Color(0xff6B7280),
                                16),
                            regularText(
                                'sgghnf fgd ',
                                Colors.grey,
                                14),
                            const SizedBox(height: 4),
                          ],
                        ),
                        Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.end,
                          children: [
                            boldText(
                                '${i == 1 ? '-' : '+'} ₹${1231}',
                                i==2 ||
                                    i==1
                                    ? const Color(0xffFB923C)
                                    : const Color(0xff00B428),
                                20),
                            if (i==2)
                              Padding(
                                padding:
                                const EdgeInsets.only(top: 4),
                                child: regularText(
                                    'status',
                                    const Color(0xffFB923C),
                                    14),
                              ),
                            if (i == 2)
                              Padding(
                                padding:
                                const EdgeInsets.only(top: 4),
                                child: regularText(
                                    'status',
                                    const Color(0xffFB923C),
                                    14),
                              ),
                            if (i==4)
                              Padding(
                                padding:
                                const EdgeInsets.only(top: 4),
                                child: regularText(
                                    'status',
                                    const Color(0xff00B428),
                                    14),
                              ),
                            if (i==0)
                              Padding(
                                padding:
                                const EdgeInsets.only(top: 4),
                                child: regularText(
                                    "transType",
                                    i==1
                                        ? const Color(0xffFB923C)
                                        : const Color(0xff00B428),
                                    14),
                              )
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}


mediumText(text, color, double size, [align]) => Text(
  text,
  textAlign: align,
  style: TextStyle(
      fontFamily: TextFontFamily.ROBOTO_MEDIUM,
      fontSize: size,
      color: color),
);

boldText(text, color, double size, [align]) => Text(
  text,
  textAlign: align,
  style: TextStyle(
      fontFamily: TextFontFamily.ROBOTO_BOLD, fontSize: size, color: color),
);

blackText(text, color, double size, [align]) => Text(
  text,
  textAlign: align,
  style: TextStyle(
      fontFamily: TextFontFamily.ROBOTO_BLACK,
      fontSize: size,
      color: color),
);

lightText(text, color, double size, [align]) => Text(
  text,
  textAlign: align,
  style: TextStyle(
      fontFamily: TextFontFamily.ROBOTO_LIGHT,
      fontSize: size,
      color: color),
);

regularText(text, color, double size, [align]) => Text(
  text,
  textAlign: align,
  style: TextStyle(
      fontFamily: TextFontFamily.ROBOTO_REGULAR,
      fontSize: size,
      color: color),
);
class TextFontFamily{
  static String  ROBOTO_BOLD = "RobotoBold";
  static String  ROBOTO_REGULAR = "RobotoRegular";
  static String  ROBOTO_LIGHT = "RobotoLight";
  static String  ROBOTO_BLACK = "RobotoBlack";
  static String  ROBOTO_MEDIUM = "RobotoMedium";
}