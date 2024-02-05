import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:live_app/provider/seller_agency_provider.dart';
import 'package:live_app/provider/user_data_provider.dart';
import 'package:provider/provider.dart';
import '../../../data/model/response/rooms_model.dart';
import '../../../provider/zego_room_provider.dart';

class LiveRecord extends StatefulWidget {
  const LiveRecord({super.key});
  @override
  State<LiveRecord> createState() => _LiveRecordState();
}

class _LiveRecordState extends State<LiveRecord> {
  Room? room;
  @override
  void initState() {
    room = Provider.of<ZegoRoomProvider>(context, listen: false).room;
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
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  title('Agency Host'),
                  const SizedBox(
                    height: 10,
                  ),
                  if (room?.roomId != null)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      textView('Room id :  ', FontWeight.normal,
                          const Color(0xff000000).withOpacity(0.7)),
                      textView(room?.roomId??'', FontWeight.normal,
                          const Color(0xff000000)),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      textView('Agency :  ', FontWeight.normal,
                          const Color(0xff000000).withOpacity(0.7)),
                      textView(value.host?.agencyCode??'Not Joined', FontWeight.normal,
                          const Color(0xff000000)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  if(value.host!=null)Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      textView('Joining date :  ', FontWeight.normal,
                          const Color(0xff000000).withOpacity(0.7)),
                      textView(
                          (value.host?.createdAt).toString().substring(0,10), FontWeight.normal, const Color(0xff000000)),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  title('Active Season Data'),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 50,
                    child: Row(
                      children: [
                        tableHeading("Month"),
                        const SizedBox(width: 10),
                        tableHeading("Valid Days"),
                        const SizedBox(width: 10),
                        tableHeading("Room Gifts")
                      ],
                    ),
                  ),
                  Table(
                    children: [
                      tableRow(DateFormat('MMMM').format(DateTime.now()), '0', '${room?.halfMonthlyDiamonds}'),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  title('Last Season Data'),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 50,
                    child: Row(
                      children: [
                        tableHeading("Month"),
                        const SizedBox(width: 10),
                        tableHeading("Valid Days"),
                        const SizedBox(width: 10),
                        tableHeading("Room Gifts")
                      ],
                    ),
                  ),
                  Table(
                    children: [
                      tableRow(DateFormat('MMMM').format(DateTime.now().subtract(const Duration(days: 31))), '0', '${room?.monthlyDiamonds}'),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Text textView(text, fo, color) {
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

  Widget tableHeading(text) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(color: const Color(0xffffa600).withOpacity(0.4)),
        alignment: Alignment.center,
        child: Text(
          text,
          style: const TextStyle(fontSize: 12.0, color: Colors.black),
        ),
      ),
    );
  }

  TableRow tableRow(text, t1, t2) {
    return TableRow(children: [
      Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 15.0),
      ),
      Text(
        t1,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 15.0),
      ),
      Text(
        t2,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 15.0),
      ),
    ]);
  }
}
