import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/provider/seller_agency_provider.dart';
import 'package:live_app/provider/user_data_provider.dart';
import 'package:provider/provider.dart';
import '../../../provider/zego_room_provider.dart';

class LiveRecord extends StatefulWidget {
  const LiveRecord({super.key});
  @override
  State<LiveRecord> createState() => _LiveRecordState();
}

class _LiveRecordState extends State<LiveRecord> {
  String? room;
  @override
  void initState() {
    room = Provider.of<ZegoRoomProvider>(context, listen: false).room?.roomId;
    Provider.of<SellerAgencyProvider>(context, listen: false).host = null;
    Provider.of<SellerAgencyProvider>(context, listen: false).getHostData(
        Provider.of<UserDataProvider>(context, listen: false).userData!.data!.userId!
    );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 67,
          automaticallyImplyLeading: true,
          backgroundColor: const Color(0xff9E26BC).withOpacity(0.2),
          title: const Text('Live Record')),
      body: Consumer<SellerAgencyProvider>(
        builder: (context, value, _) {
          if (!value.isHostLoaded) {
            return const LinearProgressIndicator(color: Colors.deepOrange);
          }
          if(value.host==null){
            return const Center(child: Text('Not in Agency Yet!'));
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                title('Agency Host'),
                const SizedBox(
                  height: 10,
                ),
                if (room != null)
                  textmethod('Room id:$room', FontWeight.normal,
                      const Color(0xff000000)),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    textmethod('Agency: ', FontWeight.w300,
                        const Color(0xff000000).withOpacity(0.8)),
                    textmethod('${value.host?.agencyCode}', FontWeight.normal,
                        const Color(0xff000000)),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    textmethod('Joining date:', FontWeight.w300,
                        const Color(0xff000000).withOpacity(0.8)),
                    textmethod(
                        '${value.host?.createdAt}', FontWeight.normal, const Color(0xff000000)),
                  ],
                ),
                // const SizedBox(height: 10),
                // GestureDetector(
                //   onTap: () async {
                //     await value.deleteHost(value.host!.id!);
                //     Get.back();
                //   },
                //   child: Container(
                //     padding:
                //         const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(9),
                //       color: const Color(0xFFFFE500),
                //     ),
                //     child: const Text(
                //       'Left Agency',
                //       style: TextStyle(color: Colors.black, fontSize: 9),
                //     ),
                //   ),
                // ),
                const SizedBox(
                  height: 16,
                ),
                // title('Weekly data'),
                // Row(
                //   children: [
                //     heading_widget("Week"),
                //     heading_widget("ValidDays"),
                //     heading_widget("Room\nGifts")
                //   ],
                // ),
                // Padding(
                //   padding: const EdgeInsets.all(15.0),
                //   child: Table(
                //     children: [
                //       tablerow('05-22-05-28', '0', '0', '0'),
                //       tablerow('05-08-05-28', '0', '0', '0'),
                //       tablerow('07-08-05-28', '0', '0', '0'),
                //       tablerow('03-08-05-28', '0', '0', '0'),
                //     ],
                //   ),
                // ),
                title('Monthly data'),
                Row(
                  children: [
                    heading_widget("Month"),
                    heading_widget("ValidDays"),
                    heading_widget("Room\nGifts")
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Table(
                    children: [
                      tablerow('November', '0', '0', '0'),
                      tablerow('December', '0', '0', '0'),
                    ],
                  ),
                ),
                // title('Daily data'),
                // const SizedBox(
                //   height: 10,
                // ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   children: [
                //     heading_widget("Data"),
                //     heading_widget("Visitor"),
                //     heading_widget("Room\nGifts")
                //   ],
                // ),
                // Padding(
                //   padding: const EdgeInsets.all(15.0),
                //   child: Table(
                //     children: [
                //       tablerow('564756689', '0', '10', '0'),
                //       tablerow('564756689', '0', '10', '0'),
                //       tablerow('564756689', '0', '10', '0'),
                //       tablerow('564756689', '0', '10', '0'),
                //       tablerow('564756689', '0', '10', '0'),
                //       tablerow('564756689', '0', '10', '0'),
                //       tablerow('564756689', '0', '10', '0'),
                //     ],
                //   ),
                // )
              ],
            ),
          );
        },
      ),
    );
  }

  Text textmethod(text, fo, color) {
    return Text(
      text,
      textAlign: TextAlign.left,
      style: TextStyle(
          color: color,
          fontFamily: 'Poppins',
          letterSpacing:
              0 /*percentages not used in flutter. defaulting to zero*/,
          fontWeight: fo,
          height: 1),
    );
  }

  Container title(text) {
    return Container(
      width: 158,
      height: 30,
      color: Colors.deepOrange,
      child: Center(
          child: Text(
        text,
        style: const TextStyle(color: Colors.white),
      )),
    );
  }

  Padding heading_widget(text) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 50,
        width: 100,
        decoration:
            BoxDecoration(color: const Color(0xffffa600).withOpacity(0.4)),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(fontSize: 12.0, color: Colors.black),
          ),
        ),
      ),
    );
  }

  TableRow tablerow(text, t1, t2, t3) {
    return TableRow(children: [
      Text(
        text,
        style: const TextStyle(fontSize: 15.0),
      ),
      Center(
        child: Text(
          t1,
          style: const TextStyle(fontSize: 15.0),
        ),
      ),
      Center(
        child: Text(
          t2,
          style: const TextStyle(fontSize: 15.0),
        ),
      ),
    ]);
  }
}
