import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../utils/utils_assets.dart';

class ClubPage extends StatefulWidget {
  const ClubPage({super.key});

  @override
  State<ClubPage> createState() => _ClubPageState();
}

class _ClubPageState extends State<ClubPage> {
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
        leading: IconButton(onPressed: (){Get.back();}, icon: const Icon(Icons.arrow_back_ios,color: Colors.white,),),
        title: Text(
          'Usefuns',
          style: SafeGoogleFont(
            'Poppins',
            fontSize: 20 * b,
            fontWeight: FontWeight.w400,
            height: 1.5 * b / a,
            letterSpacing: 0.8 * a,
            color: const Color(0xff000000),
          ),
        ),
        actions: [
          IconButton(onPressed: (){}, icon: const Icon(Icons.question_mark,color: Colors.white,),)
        ],
      ),
      body: Column(
          children: [
            Expanded(
              child: ListView.builder(itemCount: 5,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                    leading: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("${index+3}"),
                        const SizedBox(width: 10,),
                        Center(
                          child: ClipOval(
                            child: Image.asset(
                              "assets/dummy/g4.png",
                              width: 20,
                              height: 20,
                              fit: BoxFit.cover,
                            ),
                          )
                        ),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset("assets/icons/ic_coin.png",width: 10,height: 10,),
                        const SizedBox(width: 10,),
                        const Text("10002"),
                      ],
                    ),
                    title: const Text("Name"),
                );
              }),
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(8),
              color: const Color(0xFF031F46),
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    color: const Color(0xFFB3924E),
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(4),
                    height: 30,
                    child: const Icon(Icons.add,color: Colors.black,),
                  ),
                  const SizedBox(width: 20,),
                  const Text("Create a club",style: TextStyle(color: Colors.white),),
                ],
              ),
            ),
          ],
        ),
    );
  }
}
