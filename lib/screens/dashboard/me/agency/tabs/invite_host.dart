import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/utils/utils_assets.dart';

class HostMember extends StatefulWidget {
  const HostMember({super.key});

  @override
  State<HostMember> createState() => _HostMemberState();
}

class _HostMemberState extends State<HostMember> {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    double b = a * 0.97;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(15 * a),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10 * a,
              ),
              // Center(
              //   child: cont_method('Members', 158),
              // ),
              // SizedBox(
              //   height: 10 * a,
              // ),
              // Table(
              //   children: [
              //     TableRow(
              //       children: [
              //         red_conta("UseFunds\nID"),
              //         red_conta(
              //           "Valid Days\n(04.\n6.23",
              //         ),
              //         red_conta(
              //           "Room\nGifts(04.\n6.23",
              //         ),
              //         red_conta(
              //           "Valid Days\n(04.\n6.23",
              //         ),
              //         red_conta(
              //           "Valid Days\n(04.\n6.23",
              //         ),
              //       ],
              //     ),
              //     tablerow(),
              //     tablerow(),
              //   ],
              // ),
              // SizedBox(
              //   height: 25 * a,
              // ),
              Center(child: Container(
                padding: EdgeInsets.symmetric(horizontal: 18 * a, vertical: 6 * a),
                color: Colors.deepOrange,
                child: Text(
                  'Invite host to join',
                  style: SafeGoogleFont(
                    'Poppins',
                    fontSize: 14 * b,
                    fontWeight: FontWeight.w500,
                    height: 1.5 * b / a,
                    color: Colors.white,
                  ),
                ),
              )),
              SizedBox(
                height: 20 * a,
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Agency: Usefuns',
                      style: SafeGoogleFont(
                        'Poppins',
                        fontSize: 12 * b,
                        fontWeight: FontWeight.w400,
                        height: 1.5 * b / a,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      width: 30 * a,
                    ),
                    Text(
                      'Agency Code: 4257k',
                      style: SafeGoogleFont(
                        'Poppins',
                        fontSize: 12 * b,
                        fontWeight: FontWeight.w400,
                        height: 1.5 * b / a,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20 * a,
              ),
              txtt2('How to invite host to join Your Agency', Alignment.centerLeft),
              SizedBox(
                height: 10 * a,
              ),
              txtt(
                '1. In june you can invite 144 more host. (all the hodt under\napplication. Under audition anf audition failed will \nYour invited Host. ',
              ),
              SizedBox(
                height: 10 * a,
              ),
              txtt(
                '2. Host basic Requirements:\nHost age should be 22 Years old above, or will be rejected\nHe/she has not add any other agency yet\nHe/she Completed His/Her Bio .',
              ),
              SizedBox(
                height: 10 * a,
              ),
              txtt(
                '3. Agency Invite host Process: \nFill your invited host usefun id and Watsapp number      \n ask he/her to fill the application form on app \nWait for official team’s audition result within 48 hours',
              ),
              SizedBox(
                height: 30 * a,
              ),
              txtt2('UseFun ID', Alignment.bottomLeft),
              SizedBox(
                height: 10 * a,
              ),
              Container(
                width: 299 * a,
                height: 44 * a,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(255, 255, 255, 1),
                  border: Border.all(
                    color: const Color.fromRGBO(0, 0, 0, 1),
                    width: 1 * b,
                  ),
                ),
                child: ListTile(
                  leading: Text(
                    'His/Her Usefuns ID',
                    textAlign: TextAlign.left,
                    style: SafeGoogleFont(
                      'Poppins',
                      fontSize: 14 * b,
                      fontWeight: FontWeight.w500,
                      height: 1.5 * b / a,
                      color: Colors.black,
                    ),
                  ),
                  trailing: Container(
                    width: 68 * a,
                    height: 19 * a,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(9 * a),
                        topRight: Radius.circular(9 * a),
                        bottomLeft: Radius.circular(9 * a),
                        bottomRight: Radius.circular(9 * a),
                      ),
                      color: Colors.deepOrange,
                    ),
                    child: Center(
                        child: Text(
                      'Confirm',
                      style: SafeGoogleFont(
                        'Poppins',
                        fontSize: 12 * b,
                        fontWeight: FontWeight.w500,
                        height: 1.5 * b / a,
                        color: const Color.fromARGB(255, 253, 253, 253),
                      ),
                    )),
                  ),
                ),
              ),
              // SizedBox(
              //   height: 25 * a,
              // ),
              // txtt2('WhatsApp No.', Alignment.bottomLeft),
              // SizedBox(
              //   height: 10 * a,
              // ),
              // Container(
              //   width: 299 * a,
              //   height: 44 * a,
              //   decoration: BoxDecoration(
              //     color: const Color.fromRGBO(255, 255, 255, 1),
              //     border: Border.all(
              //       color: const Color.fromRGBO(0, 0, 0, 1),
              //       width: 1 * b,
              //     ),
              //   ),
              //   child: ListTile(
              //     leading: Text(
              //       'His/Her Usefun ID',
              //       textAlign: TextAlign.left,
              //       style: SafeGoogleFont(
              //         'Poppins',
              //         fontSize: 14 * b,
              //         fontWeight: FontWeight.w500,
              //         height: 1.5 * b / a,
              //         color: Colors.black,
              //       ),
              //     ),
              //   ),
              // ),
              SizedBox(
                height: 20 * a,
              ),
              Center(child: GestureDetector(onTap: () {}, child: Container(
                padding: EdgeInsets.symmetric(horizontal: 18 * a, vertical: 6 * a),
                color: Colors.deepOrange,
                child: Text(
                  'Submit',
                  style: SafeGoogleFont(
                    'Poppins',
                    fontSize: 14 * b,
                    fontWeight: FontWeight.w500,
                    height: 1.5 * b / a,
                    color: const Color.fromARGB(255, 253, 253, 253),
                  ),
                ),
              ))),
            ],
          ),
        ),
      ),
    );
  }

  Container red_conta(txt) {
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    double b = a * 0.97;
    return Container(
      height: 45 * a,
      decoration: const BoxDecoration(color: Colors.deepOrange),
      child: Text(
        txt,
        style: TextStyle(fontSize: 8.0 * a, color: Colors.white),
      ),
    );
  }

  Align txtt2(text, ali) {
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    double b = a * 0.97;
    return Align(
      alignment: ali,
      child: Text(
        text,
        style: SafeGoogleFont(
          'Poppins',
          fontSize: 12 * b,
          fontWeight: FontWeight.w500,
          height: 1.5 * b / a,
          color: Colors.black,
        ),
      ),
    );
  }

  Text txtt(txt) {
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    double b = a * 0.97;
    return Text(
      txt,
      style: SafeGoogleFont(
        'Poppins',
        fontSize: 9 * b,
        fontWeight: FontWeight.w400,
        height: 1.5 * b / a,
        color: Colors.black,
      ),
    );
  }

  TableRow tablerow() {
    return const TableRow(children: [
      Text(
        "    0",
        style: TextStyle(fontSize: 15.0),
      ),
      Text(
        "     0",
        style: TextStyle(fontSize: 15.0),
      ),
      Text(
        "     0",
        style: TextStyle(fontSize: 15.0),
      ),
      Text(
        "     0",
        style: TextStyle(fontSize: 15.0),
      ),
      Text(
        "     0",
        style: TextStyle(fontSize: 15.0),
      ),
    ]);
  }
}
