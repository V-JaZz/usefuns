import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/provider/zego_room_provider.dart';
import 'package:provider/provider.dart';
import '../../../provider/user_data_provider.dart';
import '../../../utils/utils_assets.dart';
import '../../dashboard/me/shop/shop.dart';
import 'manager.dart';

class TopMore extends StatelessWidget {
  final bool owner;
  TopMore({super.key, required this.owner});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    double b = a * 0.97;

    bool isRoomLocked = Provider.of<ZegoRoomProvider>(context).roomPassword!=null;
    bool hasRoomLock = Provider.of<UserDataProvider>(context).userData?.data?.lockRoom?.isNotEmpty??false;

    return Container(
      color: Colors.white,
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18.0 * a),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 18 * a),
            if(owner)SizedBox(
              width: 120*a,
              child: GestureDetector(
                onTap: (){
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          backgroundColor: Colors.white,
                          content: SizedBox(
                              width: 50 * a,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Room Lock',
                                    style: SafeGoogleFont('Poppins',
                                        fontSize: 16 * b,
                                        fontWeight: FontWeight.w600,
                                        height: 1.5 * b / a,
                                        letterSpacing: 0.48 * a,
                                        color: Colors.black),
                                  ),
                                  SizedBox(height: 3*a),
                                  if(isRoomLocked != false)Text(
                                    isRoomLocked
                                        ? 'Room already Locked!'
                                        : 'You haven\'t purchased Room Lock yet\n       Get it now under Lock section',
                                    style: SafeGoogleFont('Poppins',
                                        fontSize: 10 * b,
                                        fontWeight: FontWeight.w500,
                                        height: 1.5 * b / a,
                                        letterSpacing: 0.48 * a,
                                        color: Colors.black),
                                  ),
                                  if(hasRoomLock && !isRoomLocked)
                                    Form(
                                      key: _formKey,
                                      child: SizedBox(
                                        width: 190,
                                        child: TextFormField(
                                          textAlign: TextAlign.center,
                                          controller: textEditingController,
                                          maxLength: 4,
                                          style: SafeGoogleFont(
                                            'Poppins',
                                            fontSize: 15,
                                            fontWeight: FontWeight.w300,
                                            color: const Color(0x99000000),
                                          ),
                                          keyboardType: TextInputType.number,
                                          textInputAction: TextInputAction.done,
                                          decoration: InputDecoration(
                                              isDense: true,
                                              filled: true,
                                              fillColor: Colors.white,
                                              enabledBorder: UnderlineInputBorder(
                                                borderSide:
                                                const BorderSide(color: Colors.transparent),
                                                borderRadius: BorderRadius.circular(50),
                                              ),
                                              focusedBorder: UnderlineInputBorder(
                                                borderSide:
                                                const BorderSide(color: Colors.transparent),
                                                borderRadius: BorderRadius.circular(50),
                                              ),
                                              counter: const SizedBox.shrink(),
                                              hintText: 'Enter 4 Digit PIN',
                                              alignLabelWithHint: false),
                                          validator: (value) {
                                            if(value?.length!=4){
                                              return 'Invalid PIN!';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                    ),
                                  GestureDetector(
                                    onTap: () {
                                      if(!hasRoomLock){
                                        Get.to(() => const Shop(index: 6));
                                      }else if(isRoomLocked){
                                        Provider.of<ZegoRoomProvider>(context,listen:false).updateRoomLock(null);
                                        Get.back();
                                      }else if(_formKey.currentState!.validate()){
                                        Provider.of<ZegoRoomProvider>(context,listen:false).updateRoomLock(textEditingController.text);
                                        Get.back();
                                      }
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          top: 12 * a,
                                          left: 0 * a,
                                          right: 0 * a),
                                      child: Container(
                                          width: 136 * a,
                                          height: 27 * a,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.only(
                                              topLeft: Radius.circular(
                                                  9 * a),
                                              topRight: Radius.circular(
                                                  9 * a),
                                              bottomLeft:
                                              Radius.circular(
                                                  9 * a),
                                              bottomRight:
                                              Radius.circular(
                                                  9 * a),
                                            ),
                                            color: const Color.fromRGBO(
                                                255, 229, 0, 1),
                                          ),
                                          child: Center(
                                            child: Text(
                                              hasRoomLock
                                                  ?(isRoomLocked
                                                    ?'UNLOCK'
                                                    :'LOCK')
                                                  :'SHOP',
                                              style: SafeGoogleFont(
                                                  'Poppins',
                                                  fontSize: 13 * a,
                                                  fontWeight:
                                                  FontWeight.w500,
                                                  height: 1.5 * b / a,
                                                  letterSpacing:
                                                  0.48 * a,
                                                  color: const Color.fromARGB(
                                                      255,
                                                      250,
                                                      249,
                                                      249)),
                                            ),
                                          )),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: 12 * a,
                                        left: 0 * a,
                                        right: 0 * a),
                                    child: GestureDetector(
                                      onTap: (){Get.back();},
                                      child: Text(
                                        'CANCEL',
                                        style: SafeGoogleFont('Poppins',
                                            fontSize: 13 * a,
                                            fontWeight: FontWeight.w500,
                                            height: 1.5 * b / a,
                                            letterSpacing: 0.48 * a,
                                            color: const Color.fromARGB(
                                                255, 64, 63, 63)),
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                        );
                      });
                },
                child: Row(
                  children: [
                    Icon(Icons.lock, color: Colors.black, size: 24 * a),
                    SizedBox(width: 12 * a),
                    Text(
                      'Lock',
                      style: SafeGoogleFont('Poppins',
                          fontSize: 12 * b,
                          fontWeight: FontWeight.w500,
                          height: 1.5 * b / a,
                          letterSpacing: 0.48 * a,
                          color: Colors.black),
                    )
                  ],
                ),
              ),
            ),
            if(owner)Divider(
              color: const Color(0x66000000),
              height: 20 * a,
            ),
            if(owner)SizedBox(
              width: 120*a,
              child: InkWell(
                onTap: () {
                  Get.to(() => const Shop(index: 2));
                },
                child: Row(
                  children: [
                    Icon(Icons.color_lens_rounded,
                        color: Colors.black, size: 24 * a),
                    SizedBox(width: 12 * a),
                    Text(
                      'Theme',
                      style: SafeGoogleFont('Poppins',
                          fontSize: 12 * b,
                          fontWeight: FontWeight.w500,
                          height: 1.5 * b / a,
                          letterSpacing: 0.48 * a,
                          color: Colors.black),
                    )
                  ],
                ),
              ),
            ),
            if(owner)Divider(
              color: const Color(0x66000000),
              height: 20 * a,
            ),
            if(!owner)SizedBox(
              width: 120*a,
              child: GestureDetector(
                onTap: () {
                },
                child: Row(
                  children: [
                    Icon(Icons.warning_amber_rounded, color: Colors.black, size: 24 * a),
                    SizedBox(width: 12 * a),
                    Text(
                      'Report',
                      style: SafeGoogleFont('Poppins',
                          fontSize: 12 * b,
                          fontWeight: FontWeight.w500,
                          height: 1.5 * b / a,
                          letterSpacing: 0.48 * a,
                          color: Colors.black),
                    )
                  ],
                ),
              ),
            ),
            if(!owner)Divider(
              color: const Color(0x66000000),
              height: 20 * a,
            ),
            SizedBox(
              width: 120*a,
              child: GestureDetector(
                onTap: () {
                  Get.back();
                  LiveRoomBottomSheets(context).showShareBottomSheet();
                },
                child: Row(
                  children: [
                    Icon(Icons.share, color: Colors.black, size: 24 * a),
                    SizedBox(width: 12 * a),
                    Text(
                      'Share',
                      style: SafeGoogleFont('Poppins',
                          fontSize: 12 * b,
                          fontWeight: FontWeight.w500,
                          height: 1.5 * b / a,
                          letterSpacing: 0.48 * a,
                          color: Colors.black),
                    )
                  ],
                ),
              ),
            ),
            Divider(
              color: const Color(0x66000000),
              height: 20 * a,
            ),
            if(owner)GestureDetector(
              onTap: (){
                Get.back();
                LiveRoomBottomSheets(context).showRoomAdminsBottomSheet();
              },
              child: SizedBox(
                width: 120*a,
                child: Row(
                  children: [
                    Icon(Icons.people_alt, color: Colors.black, size: 24 * a),
                    SizedBox(width: 12 * a),
                    Text(
                      'Admin',
                      style: SafeGoogleFont('Poppins',
                          fontSize: 12 * b,
                          fontWeight: FontWeight.w500,
                          height: 1.5 * b / a,
                          letterSpacing: 0.48 * a,
                          color: Colors.black),
                    )
                  ],
                ),
              ),
            ),
            if(owner)Divider(
              color: const Color(0x66000000),
              height: 20 * a,
            ),
            if(owner)SizedBox(
              width: 120*a,
              child: GestureDetector(
                onTap: (){
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          backgroundColor: Colors.white,
                          content: SizedBox(
                              width: 50 * a,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Extra Seats',
                                    style: SafeGoogleFont('Poppins',
                                        fontSize: 16 * b,
                                        fontWeight: FontWeight.w600,
                                        height: 1.5 * b / a,
                                        letterSpacing: 0.48 * a,
                                        color: Colors.black),
                                  ),
                                  SizedBox(height: 3*a),
                                  Text(
                                    'Buy extra seats from shop.',
                                    style: SafeGoogleFont('Poppins',
                                        fontSize: 10 * b,
                                        fontWeight: FontWeight.w500,
                                        height: 1.5 * b / a,
                                        letterSpacing: 0.48 * a,
                                        color: Colors.black),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Get.to(() => const Shop(index: 6));
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          top: 12 * a,
                                          left: 0 * a,
                                          right: 0 * a),
                                      child: Container(
                                          width: 136 * a,
                                          height: 27 * a,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.only(
                                              topLeft: Radius.circular(
                                                  9 * a),
                                              topRight: Radius.circular(
                                                  9 * a),
                                              bottomLeft:
                                              Radius.circular(
                                                  9 * a),
                                              bottomRight:
                                              Radius.circular(
                                                  9 * a),
                                            ),
                                            color: const Color.fromRGBO(
                                                255, 229, 0, 1),
                                          ),
                                          child: Center(
                                            child: Text(
                                              'SHOP',
                                              style: SafeGoogleFont(
                                                  'Poppins',
                                                  fontSize: 13 * a,
                                                  fontWeight:
                                                  FontWeight.w500,
                                                  height: 1.5 * b / a,
                                                  letterSpacing:
                                                  0.48 * a,
                                                  color: const Color.fromARGB(
                                                      255,
                                                      250,
                                                      249,
                                                      249)),
                                            ),
                                          )),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: 12 * a,
                                        left: 0 * a,
                                        right: 0 * a),
                                    child: GestureDetector(
                                      onTap: (){Get.back();},
                                      child: Text(
                                        'CANCEL',
                                        style: SafeGoogleFont('Poppins',
                                            fontSize: 13 * a,
                                            fontWeight: FontWeight.w500,
                                            height: 1.5 * b / a,
                                            letterSpacing: 0.48 * a,
                                            color: const Color.fromARGB(
                                                255, 64, 63, 63)),
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                        );
                      });
                },
                child: Row(
                  children: [
                    Icon(Icons.people_alt,
                        color: Colors.black, size: 24 * a),
                    SizedBox(width: 12 * a),
                    Text(
                      'Extra Seat',
                      style: SafeGoogleFont('Poppins',
                          fontSize: 12 * b,
                          fontWeight: FontWeight.w500,
                          height: 1.5 * b / a,
                          letterSpacing: 0.48 * a,
                          color: Colors.black),
                    )
                  ],
                ),
              ),
            ),
            if(owner)Divider(
              color: const Color(0x66000000),
              height: 20 * a,
            ),
            GestureDetector(
              onTap: (){Get.back();},
              child: Text(
                'Cancel',
                style: SafeGoogleFont('Poppins',
                    fontSize: 12 * b,
                    fontWeight: FontWeight.w500,
                    height: 1.5 * b / a,
                    letterSpacing: 0.48 * a,
                    color: Colors.black),
              ),
            ),
            SizedBox(height: 18 * a),
          ],
        ),
      ),
    );
  }
}
