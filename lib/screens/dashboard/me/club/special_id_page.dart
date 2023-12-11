import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utils/utils_assets.dart';

class SpecialIdPage extends StatefulWidget {
  const SpecialIdPage({super.key});

  @override
  State<SpecialIdPage> createState() => _SpecialIdPageState();
}

class _SpecialIdPageState extends State<SpecialIdPage> {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    double b = a * 0.97;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0x339E26BC),
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 1,
        title: Text(
          'Special Id',
          style: SafeGoogleFont(
            'Poppins',
            fontSize: 20 * b,
            fontWeight: FontWeight.w400,
            height: 1.5 * b / a,
            letterSpacing: 0.8 * a,
            color: const Color(0xff000000),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.yellow, width: 4),
                          ),
                          child: ClipOval(
                            child: Image.network(
                              "",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 1e-8,
                          child: Container(
                              padding: EdgeInsets.only(left: 8,right: 8),
                              decoration: BoxDecoration(
                                color: Color(0xFFFFE500
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                "LIVE",
                                style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                              ),
                            ),
                        ),
                      ],
                    ),
                    title: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("Name"),
                        // Image.asset("",width: 5,height: 5,),
                      ],
                    ),
                    subtitle: Column(
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              "",
                              width: 5,
                              height: 5,
                            ),
                            Text(
                              "Score",
                              style: TextStyle(
                                color: Color(0xFFFFE500),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text("Loren Ipsum is simply dummy test"),
                      ],
                    ),
                    trailing: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color(0xFFFFE500),
                      ),padding: EdgeInsets.only(left: 10,right: 10),
                      height: 20,
                      width: 60,
                      child: Center(
                        child: Text("Follow"),
                      ),
                    ),
                    // title: Text("Name"),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
