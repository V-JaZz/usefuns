import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/utils/utils_assets.dart';
import 'package:provider/provider.dart';

import '../../../../../data/model/response/user_data_model.dart';
import '../../../../../provider/seller_agency_provider.dart';
import '../../../../../provider/user_data_provider.dart';
import '../../../../../utils/common_widgets.dart';

class InviteHostTabView extends StatefulWidget {
  const InviteHostTabView({super.key});

  @override
  State<InviteHostTabView> createState() => _InviteHostTabViewState();
}

class _InviteHostTabViewState extends State<InviteHostTabView> {
  UserDataModel? user;
  TextEditingController userIdController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    double b = a * 0.97;

    return Consumer<SellerAgencyProvider>(
      builder: (context, value, _) => Scaffold(
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
                Center(
                    child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 18 * a, vertical: 6 * a),
                  decoration: BoxDecoration(
                      color: Colors.deepOrange,
                      borderRadius: BorderRadius.circular(4 * a)),
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
                        'Agency: ${value.agent?.data?.name}',
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
                        'Agency Code: ${value.agent?.data?.code}',
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
                title(
                    'Invite host to join your agency :', Alignment.centerLeft),
                para(
                  '1. In june you can invite 144 more host. (all the hodt under application. Under audition anf audition failed will your invited Host. ',
                ),
                para(
                  '2. Host basic Requirements: Host age should be 22 Years old above, or will be rejected He/she has not add any other agency yet He/she Completed His/Her Bio .',
                ),
                para(
                  '3. Agency Invite host Process:  Fill your invited host usefun id and Watsapp number ask he/her to fill the application form on app  Wait for official team’s audition result within 48 hours',
                ),
                SizedBox(
                  height: 20 * a,
                ),
                title('UseFun ID', Alignment.bottomLeft),
                Container(
                  decoration: BoxDecoration(
                      color: const Color.fromRGBO(255, 255, 255, 1),
                      border: Border.all(
                        color: Colors.black54,
                        width: 1 * b,
                      ),
                      borderRadius: BorderRadius.circular(4 * a)),
                  child: ListTile(
                    title: user != null
                        ? userDetails(a, b, user!)
                        : Align(
                            alignment: Alignment.centerLeft,
                            child: TextField(
                              controller: userIdController,
                              textAlign: TextAlign.left,
                              keyboardType: TextInputType.number,
                              style: SafeGoogleFont(
                                'Poppins',
                                fontSize: 14 * b,
                                fontWeight: FontWeight.w500,
                                height: 1.5 * b / a,
                                color: Colors.black,
                              ),
                              decoration: const InputDecoration(
                                  hintText: 'His/Her Usefuns ID',
                                  isDense: true,
                                  border: InputBorder.none),
                            ),
                          ),
                    trailing: InkWell(
                      onTap: () async {
                        if (user == null) {
                          final ud = await Provider.of<UserDataProvider>(
                                  context,
                                  listen: false)
                              .getUser(
                                  id: userIdController.text, isUsefunId: true);
                          setState(() {
                            user = ud;
                          });
                        } else {
                          setState(() {
                            user = null;
                            userIdController.clear();
                          });
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 6 * a, vertical: 6 * a),
                        decoration: BoxDecoration(
                            color: user == null
                                ? Colors.deepOrange
                                : Colors.purpleAccent.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(4 * a)),
                        child: Text(
                          user == null ? 'Confirm' : 'Update',
                          style: SafeGoogleFont(
                            'Poppins',
                            fontSize: 12 * b,
                            fontWeight: FontWeight.w500,
                            height: 1.5 * b / a,
                            color: user == null ? Colors.white : Colors.deepOrange,
                          ),
                        ),
                      ),
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
                Center(
                    child: GestureDetector(
                        onTap: () async {
                          if(userIdController.text.isEmpty){
                            showCustomSnackBar('Enter User ID!', Get.context!, isToaster: true);
                          }else if(user?.data==null){
                            showCustomSnackBar('Please Confirm User!', Get.context!, isToaster: true);
                          }else{
                            await value.inviteHost(userIdController.text.trim());
                            setState(() {
                              user = null;
                              userIdController.clear();
                            });
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 18 * a, vertical: 6 * a),
                          decoration: BoxDecoration(
                              color: Colors.deepOrange,
                              borderRadius: BorderRadius.circular(4 * a)),
                          child: Text(
                            value.inviteRequestLoading?'Sending..':'Submit',
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
      ),
    );
  }

  Widget userDetails(double a, double b, UserDataModel user) {
    if (user.data == null) {
      return Text('User ID Not Found - ${userIdController.text}');
    }
    return Container(
      // padding: EdgeInsets.symmetric(horizontal: 12 * a, vertical: 3 * a),
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 36 * a,
            height: 36 * a,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black54, width: 1),
                shape: BoxShape.circle),
            child: user.data!.images!.isEmpty
                ? CircleAvatar(
                    foregroundImage: const AssetImage('assets/profile.png'),
                    radius: 18 * a)
                : CircleAvatar(
                    foregroundImage:
                        NetworkImage(user.data!.images?.first ?? ''),
                    radius: 18 * a),
          ),
          SizedBox(width: 6 * a),
          Text(
            '${user.data?.name} (${user.data?.userId})',
            textAlign: TextAlign.left,
            style: SafeGoogleFont(
                color: Colors.black.withOpacity(0.7),
                'Poppins',
                fontSize: 14,
                fontWeight: FontWeight.w500,
                height: 1),
          ),
          SizedBox(width: 6 * a),
        ],
      ),
    );
  }

  Align title(text, ali) {
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    double b = a * 0.97;
    return Align(
      alignment: ali,
      child: Text(
        '$text\n',
        style: SafeGoogleFont(
          'Poppins',
          fontSize: 14 * b,
          fontWeight: FontWeight.w500,
          height: 1.5 * b / a,
          color: Colors.black87,
        ),
      ),
    );
  }

  Text para(txt) {
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    double b = a * 0.97;
    return Text(
      '$txt\n',
      style: SafeGoogleFont(
        'Poppins',
        fontSize: 12 * b,
        fontWeight: FontWeight.w400,
        height: 1.5 * b / a,
        color: Colors.black87,
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
